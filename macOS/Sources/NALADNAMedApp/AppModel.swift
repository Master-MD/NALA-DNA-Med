import Foundation
import SwiftUI
import NALADNAMedCore

enum AppSection: String, CaseIterable, Identifiable {
    case dashboard = "Dashboard"
    case firstRun = "First Run"
    case systemCheck = "System Check"
    case llmFit = "LLM-Fit"
    case projects = "Projects"
    case upload = "Upload Center"
    case biolab = "BioLab Demo"
    case jobsAudit = "Jobs / Audit"
    case resources = "Resources"
    case backup = "Backup / Restore"
    case support = "Support Report"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .dashboard: "rectangle.grid.2x2"
        case .firstRun: "hand.raised"
        case .systemCheck: "checklist"
        case .llmFit: "cpu"
        case .projects: "folder"
        case .upload: "square.and.arrow.up"
        case .biolab: "cross.vial"
        case .jobsAudit: "list.bullet.clipboard"
        case .resources: "externaldrive"
        case .backup: "arrow.clockwise"
        case .support: "doc.text.magnifyingglass"
        }
    }
}

@MainActor
final class AppModel: ObservableObject {
    @Published var selection: AppSection = .firstRun
    @Published var acceptedSafetyNotice = false
    @Published var selectedProfile: LLMFitProfile = .kleiner
    @Published var smilesInput = "CCO"
    @Published var proteinInput = "MEEPQSDPSV"
    @Published var modelWebLink = "https://huggingface.co/example/model/resolve/main/model.gguf"
    @Published var modelExpectedSizeGB = "4"
    @Published private(set) var modelImportPlan: ModelImportPlan?
    @Published private(set) var modelImportMessage = "Choose a model by Weblink or Finder file. Large files require confirmation."
    @Published private(set) var isModelTransferRunning = false
    @Published private(set) var snapshot: SystemSnapshot
    @Published private(set) var recommendation: LLMFitRecommendation
    @Published private(set) var projects: [Project]
    @Published private(set) var auditEvents: [AuditEvent]
    @Published private(set) var bioLabResult: BioLabDryRunResult

    private let llmFitService = LLMFitService()
    private let bioLabService = BioLabDemoService()
    private let supportReportService = SupportReportService()
    private let backupService = BackupService()
    private let modelImportPlanner = ModelImportPlanner()
    private let modelStorageService = ModelStorageService()

    init() {
        let initialSnapshot = SystemCheckService().currentSnapshot()
        let initialRecommendation = llmFitService.recommendation(for: initialSnapshot, preference: .optimal)
        snapshot = initialSnapshot
        recommendation = initialRecommendation
        selectedProfile = initialRecommendation.profile
        projects = [
            Project(
                id: "project_biolab_demo",
                tenantID: "tenant_mike",
                userID: "user_mike",
                name: "BioLab Demo Vault",
                summary: "Synthetic local demo workspace for SMILES, protein sequences, and literature notes.",
                createdAt: Date()
            )
        ]
        auditEvents = [
            AuditEvent(id: UUID().uuidString, action: "App initialized", status: .green, message: "Local Lite is available.", createdAt: Date()),
            AuditEvent(id: UUID().uuidString, action: "Safety notice required", status: .yellow, message: "Research-support boundary must be accepted.", createdAt: Date())
        ]
        bioLabResult = bioLabService.runDryRun(smiles: "CCO", proteinSequence: "MEEPQSDPSV")
    }

    func acceptSafetyAndStartDemo() {
        acceptedSafetyNotice = true
        selection = .dashboard
        addAudit(action: "CAVEMAN path started", status: .green, message: "User entered Local Lite Demo Mode.")
    }

    func refreshSystemCheck() {
        snapshot = SystemCheckService().currentSnapshot()
        recommendation = llmFitService.recommendation(for: snapshot, preference: selectedProfile)
        selectedProfile = recommendation.profile
        addAudit(action: "System Check", status: recommendation.status, message: recommendation.title)
    }

    func chooseProfile(_ profile: LLMFitProfile) {
        selectedProfile = profile
        recommendation = llmFitService.recommendation(for: snapshot, preference: profile)
        addAudit(action: "LLM-Fit profile", status: recommendation.status, message: "Selected \(recommendation.profile.rawValue).")
    }

    func runBioLabDryRun() {
        bioLabResult = bioLabService.runDryRun(smiles: smilesInput, proteinSequence: proteinInput)
        addAudit(action: "BioLab dry-run", status: .yellow, message: "Demo result generated with safety flags.")
    }

    func createDemoProject() {
        let project = Project(
            id: "project_\(projects.count + 1)",
            tenantID: "tenant_mike",
            userID: "user_mike",
            name: "Research Demo \(projects.count + 1)",
            summary: "Local-only research-support workspace.",
            createdAt: Date()
        )
        projects.append(project)
        addAudit(action: "Project created", status: .green, message: project.name)
    }

    func supportReport() -> String {
        supportReportService.makeReport(snapshot: snapshot, recommendation: recommendation)
    }

    func copySupportReport() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(supportReport(), forType: .string)
        addAudit(action: "Support report copied", status: .green, message: "CAVEMAN diagnostic summary copied.")
    }

    func planWebModelImport() {
        guard let url = URL(string: modelWebLink) else {
            modelImportMessage = "Status: Red\nProblem: The Weblink is not a valid URL.\nNext step: Paste an https:// or http:// model link."
            addAudit(action: "Model Weblink rejected", status: .red, message: "Invalid URL.")
            return
        }
        let gb = Double(modelExpectedSizeGB.replacingOccurrences(of: ",", with: ".")) ?? 0
        let bytes = Int64(gb * 1024 * 1024 * 1024)
        do {
            let plan = try modelImportPlanner.planWebDownload(from: url, expectedSizeBytes: bytes > 0 ? bytes : nil)
            modelImportPlan = plan
            modelImportMessage = "Status: Yellow\nProblem: Large model download requires confirmation.\nImpact: \(plan.displayName) may use significant disk.\nNext step: Confirm in the final downloader before transfer starts.\nTechnical detail: \(plan.url.absoluteString)"
            addAudit(action: "Model Weblink planned", status: .yellow, message: plan.displayName)
        } catch {
            modelImportMessage = "Status: Red\nProblem: Unsupported Weblink.\nNext step: Use https:// or http:// links from Hugging Face, GitHub releases, or another trusted source."
            addAudit(action: "Model Weblink rejected", status: .red, message: "\(error)")
        }
    }

    func downloadWebModel() {
        guard !isModelTransferRunning else { return }
        guard let url = URL(string: modelWebLink) else {
            modelImportMessage = "Status: Red\nProblem: The Weblink is not a valid URL.\nNext step: Paste an https:// or http:// model link."
            addAudit(action: "Model Weblink rejected", status: .red, message: "Invalid URL.")
            return
        }
        let gb = Double(modelExpectedSizeGB.replacingOccurrences(of: ",", with: ".")) ?? 0
        let bytes = Int64(gb * 1024 * 1024 * 1024)
        do {
            let plan = try modelImportPlanner.planWebDownload(from: url, expectedSizeBytes: bytes > 0 ? bytes : nil)
            modelImportPlan = plan
            isModelTransferRunning = true
            modelImportMessage = "Status: Yellow\nProblem: Web model download is running.\nImpact: \(plan.displayName) will be stored in Application Support/NALA-DNA-Med/Models.\nNext step: Keep the app open until the transfer finishes."
            addAudit(action: "Model Weblink download started", status: .yellow, message: plan.displayName)

            Task {
                do {
                    let savedURL = try await modelStorageService.download(plan: plan)
                    isModelTransferRunning = false
                    modelImportMessage = "Status: Green\nProblem: None.\nImpact: Web model is available locally.\nNext step: Select it for a local backend when the runtime connector is enabled.\nTechnical detail: \(savedURL.path)"
                    addAudit(action: "Model Weblink downloaded", status: .green, message: savedURL.lastPathComponent)
                } catch {
                    isModelTransferRunning = false
                    modelImportMessage = "Status: Red\nProblem: Web model download failed.\nNext step: Check the URL, network, and free disk space, then retry.\nTechnical detail: \(error.localizedDescription)"
                    addAudit(action: "Model Weblink download failed", status: .red, message: error.localizedDescription)
                }
            }
        } catch {
            modelImportMessage = "Status: Red\nProblem: Unsupported Weblink.\nNext step: Use https:// or http:// links from Hugging Face, GitHub releases, or another trusted source."
            addAudit(action: "Model Weblink rejected", status: .red, message: "\(error)")
        }
    }

    func planLocalModelImport(from url: URL) {
        do {
            let plan = try modelImportPlanner.planLocalFileImport(from: url)
            modelImportPlan = plan
            modelImportMessage = "Status: Yellow\nProblem: Local model import requires confirmation.\nImpact: The app will reference or copy \(plan.displayName) from Finder/drive selection.\nNext step: Confirm import target and keep tenant/project data separate.\nTechnical detail: \(plan.url.path)"
            addAudit(action: "Local model import planned", status: .yellow, message: plan.displayName)
        } catch {
            modelImportMessage = "Status: Red\nProblem: Unsupported file type.\nNext step: Choose .gguf, .safetensors, .bin, .mlmodel, or .mlpackage."
            addAudit(action: "Local model import rejected", status: .red, message: "\(error)")
        }
    }

    func importPlannedLocalModel() {
        guard !isModelTransferRunning else { return }
        guard let plan = modelImportPlan, plan.source == .localFile else {
            modelImportMessage = "Status: Red\nProblem: No local model file is selected.\nNext step: Choose a model file from Finder or an external drive first."
            addAudit(action: "Local model import rejected", status: .red, message: "No selected local model.")
            return
        }

        isModelTransferRunning = true
        modelImportMessage = "Status: Yellow\nProblem: Local model import is running.\nImpact: \(plan.displayName) will be copied into Application Support/NALA-DNA-Med/Models.\nNext step: Keep the app open until the copy finishes."
        addAudit(action: "Local model import started", status: .yellow, message: plan.displayName)

        Task {
            do {
                let savedURL = try modelStorageService.importLocal(plan: plan)
                isModelTransferRunning = false
                modelImportMessage = "Status: Green\nProblem: None.\nImpact: Local model is available inside the app model folder.\nNext step: Select it for a local backend when the runtime connector is enabled.\nTechnical detail: \(savedURL.path)"
                addAudit(action: "Local model imported", status: .green, message: savedURL.lastPathComponent)
            } catch {
                isModelTransferRunning = false
                modelImportMessage = "Status: Red\nProblem: Local model import failed.\nNext step: Check file permissions and free disk space, then retry.\nTechnical detail: \(error.localizedDescription)"
                addAudit(action: "Local model import failed", status: .red, message: error.localizedDescription)
            }
        }
    }

    func recordModelImportFailure(_ error: Error) {
        modelImportPlan = nil
        modelImportMessage = "Status: Red\nProblem: Model file selection failed or was cancelled.\nNext step: Choose .gguf, .safetensors, .bin, .mlmodel, or .mlpackage from Finder or an external drive."
        addAudit(action: "Local model import failed", status: .red, message: "\(error)")
    }

    func suggestedBackupName() -> String {
        backupService.backupName(for: Date(), includeModels: false)
    }

    private func addAudit(action: String, status: CAVEMANStatus, message: String) {
        auditEvents.insert(
            AuditEvent(id: UUID().uuidString, action: action, status: status, message: message, createdAt: Date()),
            at: 0
        )
    }
}

private struct ModelStorageService {
    func download(plan: ModelImportPlan) async throws -> URL {
        let (temporaryURL, response) = try await URLSession.shared.download(from: plan.url)
        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            throw ModelStorageError.httpStatus(httpResponse.statusCode)
        }
        let destination = try destinationURL(for: plan.displayName)
        try FileManager.default.moveItem(at: temporaryURL, to: destination)
        return destination
    }

    func importLocal(plan: ModelImportPlan) throws -> URL {
        let canAccess = plan.url.startAccessingSecurityScopedResource()
        defer {
            if canAccess {
                plan.url.stopAccessingSecurityScopedResource()
            }
        }

        let destination = try destinationURL(for: plan.displayName)
        try FileManager.default.copyItem(at: plan.url, to: destination)
        return destination
    }

    private func destinationURL(for displayName: String) throws -> URL {
        let directory = try modelsDirectory()
        let cleanName = cleanFileName(displayName)
        var candidate = directory.appendingPathComponent(cleanName)
        let baseName = (cleanName as NSString).deletingPathExtension
        let fileExtension = (cleanName as NSString).pathExtension
        var index = 2

        while FileManager.default.fileExists(atPath: candidate.path) {
            let suffix = fileExtension.isEmpty ? "-\(index)" : "-\(index).\(fileExtension)"
            candidate = directory.appendingPathComponent("\(baseName)\(suffix)")
            index += 1
        }

        return candidate
    }

    private func modelsDirectory() throws -> URL {
        let baseURL = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let modelsURL = baseURL
            .appendingPathComponent("NALA-DNA-Med", isDirectory: true)
            .appendingPathComponent("Models", isDirectory: true)
        try FileManager.default.createDirectory(at: modelsURL, withIntermediateDirectories: true)
        return modelsURL
    }

    private func cleanFileName(_ value: String) -> String {
        let cleaned = value
            .replacingOccurrences(of: "/", with: "-")
            .replacingOccurrences(of: ":", with: "-")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return cleaned.isEmpty ? "model.bin" : cleaned
    }
}

private enum ModelStorageError: LocalizedError {
    case httpStatus(Int)

    var errorDescription: String? {
        switch self {
        case .httpStatus(let statusCode):
            "HTTP status \(statusCode)"
        }
    }
}
