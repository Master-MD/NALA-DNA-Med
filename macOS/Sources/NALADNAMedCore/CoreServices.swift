import Foundation

public struct LLMFitService: Sendable {
    private let minimumComfortableDisk: Int64 = 60 * 1024 * 1024 * 1024
    private let maximalDisk: Int64 = 140 * 1024 * 1024 * 1024

    public init() {}

    public func recommendation(for snapshot: SystemSnapshot, preference: LLMFitProfile) -> LLMFitRecommendation {
        var reasons: [String] = []

        if snapshot.freeDiskBytes < minimumComfortableDisk {
            reasons.append("Free disk is tight; use a small local model profile until more disk is available.")
            if snapshot.hasOllama {
                reasons.append("Ollama is available, so Kleiner can still run local demo models.")
            }
            return LLMFitRecommendation(
                profile: .kleiner,
                status: .yellow,
                title: "Kleiner recommended",
                reasons: reasons,
                requiresLargeDownloadConfirmation: false
            )
        }

        if preference == .maximal, snapshot.freeDiskBytes >= maximalDisk {
            reasons.append("\(snapshot.chipName) and available disk can support a larger opt-in model.")
            reasons.append("Large downloads still require explicit confirmation.")
            return LLMFitRecommendation(
                profile: .maximal,
                status: .green,
                title: "Maximal available",
                reasons: reasons,
                requiresLargeDownloadConfirmation: true
            )
        }

        reasons.append("Hardware is strong enough for a balanced local profile.")
        if !snapshot.hasOllama {
            reasons.append("Install Ollama to enable local LLM runs.")
        }
        return LLMFitRecommendation(
            profile: .optimal,
            status: snapshot.hasOllama ? .green : .yellow,
            title: "Optimal recommended",
            reasons: reasons,
            requiresLargeDownloadConfirmation: true
        )
    }
}

public struct ResourceDownloadGate: Sendable {
    private let automaticLimit: Int64 = 25 * 1024 * 1024

    public init() {}

    public func decision(for resource: RemoteResource, availableDiskBytes: Int64) -> DownloadDecision {
        if resource.sizeBytes > max(0, availableDiskBytes - (2 * 1024 * 1024 * 1024)) {
            return .blockedInsufficientDisk
        }

        switch resource.kind {
        case .catalog, .template, .sourceMetadata, .modelMetadata:
            return resource.sizeBytes <= automaticLimit ? .allowedAutomatically : .requiresConfirmation
        case .modelWeights, .biomedicalWeights, .largeDataset, .dependencyBundle:
            return .requiresConfirmation
        }
    }
}

public struct BioLabDemoService: Sendable {
    public init() {}

    public func runDryRun(smiles: String, proteinSequence: String) -> BioLabDryRunResult {
        let moleculeHint = smiles.isEmpty ? "No SMILES input provided." : "SMILES input accepted for demo parsing."
        let proteinHint = proteinSequence.isEmpty ? "No protein sequence provided." : "Protein sequence accepted for demo parsing."
        return BioLabDryRunResult(
            demoMode: true,
            notMedicalAdvice: true,
            confidence: .low,
            summary: "\(moleculeHint) \(proteinHint) Dry-run only: prioritize literature review and expert validation.",
            warnings: [
                "Demo mode only.",
                "Not medical advice.",
                "No diagnosis, prescription, or clinical decision support."
            ]
        )
    }
}

public struct ModelImportPlanner: Sendable {
    private let supportedExtensions: Set<String> = ["gguf", "bin", "safetensors", "mlmodel", "mlpackage"]
    private let confirmationThreshold: Int64 = 25 * 1024 * 1024

    public init() {}

    public func planWebDownload(from url: URL, expectedSizeBytes: Int64?) throws -> ModelImportPlan {
        guard ["https", "http"].contains(url.scheme?.lowercased()) else {
            throw ModelImportError.unsupportedURLScheme
        }
        let displayName = url.lastPathComponent.isEmpty ? url.host ?? "remote-model" : url.lastPathComponent
        return ModelImportPlan(
            source: .webLink,
            displayName: displayName,
            url: url,
            expectedSizeBytes: expectedSizeBytes,
            requiresConfirmation: (expectedSizeBytes ?? confirmationThreshold + 1) > confirmationThreshold
        )
    }

    public func planLocalFileImport(from url: URL) throws -> ModelImportPlan {
        guard supportedExtensions.contains(url.pathExtension.lowercased()) else {
            throw ModelImportError.unsupportedFileType
        }
        return ModelImportPlan(
            source: .localFile,
            displayName: url.lastPathComponent,
            url: url,
            expectedSizeBytes: nil,
            requiresConfirmation: true
        )
    }
}

public enum TenantShield {
    public static func validate(_ context: TenantContext) throws {
        guard let tenantID = context.tenantID, !tenantID.isEmpty else {
            throw TenantShieldError.missingTenantID
        }
        guard let projectID = context.projectID, !projectID.isEmpty else {
            throw TenantShieldError.missingProjectID
        }
    }
}

public struct BackupService: Sendable {
    public init() {}

    public func backupName(for date: Date, includeModels: Bool) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd-HHmmss"
        let suffix = includeModels ? "with-models" : "lite"
        return "NALA-DNA-Med-backup-\(formatter.string(from: date))-\(suffix).zip"
    }
}

public struct SupportReportService: Sendable {
    public init() {}

    public func makeReport(snapshot: SystemSnapshot, recommendation: LLMFitRecommendation) -> String {
        """
        NALA-DNA-Med CAVEMAN Support Report
        No Terminal required for Local Lite.

        Machine: \(snapshot.chipName)
        Architecture: \(snapshot.architecture)
        GPU: \(snapshot.gpuDescription)
        Memory: \(ByteCountFormatter.string(fromByteCount: snapshot.memoryBytes, countStyle: .memory))
        Free disk: \(ByteCountFormatter.string(fromByteCount: snapshot.freeDiskBytes, countStyle: .file))
        Ollama: \(snapshot.hasOllama ? "yes" : "no")
        Docker: \(snapshot.hasDocker ? "yes" : "no")
        OrbStack: \(snapshot.hasOrbStack ? "yes" : "no")

        Recommended profile: \(recommendation.profile.rawValue)
        Status: \(recommendation.status.rawValue)
        Reasons:
        \(recommendation.reasons.map { "- \($0)" }.joined(separator: "\n"))
        """
    }
}

public struct SystemCheckService: Sendable {
    public init() {}

    public func currentSnapshot() -> SystemSnapshot {
        SystemSnapshot(
            chipName: shellOutput("/usr/sbin/sysctl", ["-n", "machdep.cpu.brand_string"]).ifEmpty("Apple Silicon"),
            architecture: shellOutput("/usr/bin/uname", ["-m"]).ifEmpty("unknown"),
            memoryBytes: Int64(ProcessInfo.processInfo.physicalMemory),
            gpuDescription: "Metal-capable GPU",
            freeDiskBytes: freeDiskBytes(),
            hasOllama: commandExists("ollama"),
            hasDocker: commandExists("docker"),
            hasOrbStack: commandExists("orbstack")
        )
    }

    private func commandExists(_ name: String) -> Bool {
        !shellOutput("/usr/bin/which", [name]).isEmpty
    }

    private func shellOutput(_ launchPath: String, _ arguments: [String]) -> String {
        let process = Process()
        let pipe = Pipe()
        process.executableURL = URL(fileURLWithPath: launchPath)
        process.arguments = arguments
        process.standardOutput = pipe
        process.standardError = Pipe()
        do {
            try process.run()
            process.waitUntilExit()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            return String(decoding: data, as: UTF8.self).trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return ""
        }
    }

    private func freeDiskBytes() -> Int64 {
        do {
            let values = try URL(fileURLWithPath: NSHomeDirectory()).resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            if let capacity = values.volumeAvailableCapacityForImportantUsage {
                return capacity
            }
        } catch {}
        return 0
    }
}

private extension String {
    func ifEmpty(_ fallback: String) -> String {
        isEmpty ? fallback : self
    }
}
