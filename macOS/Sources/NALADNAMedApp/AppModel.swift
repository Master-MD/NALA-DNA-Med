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
    @Published private(set) var snapshot: SystemSnapshot
    @Published private(set) var recommendation: LLMFitRecommendation
    @Published private(set) var projects: [Project]
    @Published private(set) var auditEvents: [AuditEvent]
    @Published private(set) var bioLabResult: BioLabDryRunResult

    private let llmFitService = LLMFitService()
    private let bioLabService = BioLabDemoService()
    private let supportReportService = SupportReportService()
    private let backupService = BackupService()

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
