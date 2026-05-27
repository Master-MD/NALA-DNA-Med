import Testing
import Foundation
@testable import NALADNAMedCore

@Test func llmFitChoosesSmallWhenDiskIsTight() async throws {
    let snapshot = SystemSnapshot(
        chipName: "Apple M4 Max",
        architecture: "arm64",
        memoryBytes: 64 * 1024 * 1024 * 1024,
        gpuDescription: "40-core GPU",
        freeDiskBytes: 12 * 1024 * 1024 * 1024,
        hasOllama: true,
        hasDocker: true,
        hasOrbStack: false
    )

    let recommendation = LLMFitService().recommendation(for: snapshot, preference: .optimal)

    #expect(recommendation.profile == .kleiner)
    #expect(recommendation.status == .yellow)
    #expect(recommendation.reasons.contains { $0.contains("disk") })
}

@Test func llmFitAllowsMaximalOnlyWithEnoughDisk() async throws {
    let snapshot = SystemSnapshot(
        chipName: "Apple M4 Max",
        architecture: "arm64",
        memoryBytes: 64 * 1024 * 1024 * 1024,
        gpuDescription: "40-core GPU",
        freeDiskBytes: 180 * 1024 * 1024 * 1024,
        hasOllama: true,
        hasDocker: true,
        hasOrbStack: true
    )

    let recommendation = LLMFitService().recommendation(for: snapshot, preference: .maximal)

    #expect(recommendation.profile == .maximal)
    #expect(recommendation.requiresLargeDownloadConfirmation)
}

@Test func largeDownloadGateBlocksAutomaticModelWeights() async throws {
    let resource = RemoteResource(
        name: "Qwen3 32B GGUF",
        source: URL(string: "https://huggingface.co/example/model.gguf")!,
        sizeBytes: 22 * 1024 * 1024 * 1024,
        kind: .modelWeights,
        license: "Apache-2.0"
    )

    let decision = ResourceDownloadGate().decision(for: resource, availableDiskBytes: 90 * 1024 * 1024 * 1024)

    #expect(decision == .requiresConfirmation)
}

@Test func smallCatalogCanDownloadAutomatically() async throws {
    let resource = RemoteResource(
        name: "Model Catalog",
        source: URL(string: "https://example.org/catalog.json")!,
        sizeBytes: 200_000,
        kind: .catalog,
        license: "CC0"
    )

    let decision = ResourceDownloadGate().decision(for: resource, availableDiskBytes: 5 * 1024 * 1024 * 1024)

    #expect(decision == .allowedAutomatically)
}

@Test func biolabDryRunAlwaysContainsSafetyFlags() async throws {
    let result = BioLabDemoService().runDryRun(
        smiles: "CCO",
        proteinSequence: "MEEPQSDPSV"
    )

    #expect(result.demoMode)
    #expect(result.notMedicalAdvice)
    #expect(result.confidence == .low)
    #expect(!result.warnings.isEmpty)
    #expect(!result.summary.localizedCaseInsensitiveContains("treat"))
}

@Test func tenantShieldRejectsMissingProjectContext() async throws {
    let context = TenantContext(
        tenantID: "tenant_mike",
        userID: "user_mike",
        projectID: nil
    )

    #expect(throws: TenantShieldError.missingProjectID) {
        try TenantShield.validate(context)
    }
}

@Test func backupNamesAreTimestampedAndStable() async throws {
    let date = Date(timeIntervalSince1970: 1_800_000_000)

    let name = BackupService().backupName(for: date, includeModels: false)

    #expect(name == "NALA-DNA-Med-backup-2027-01-15-080000-lite.zip")
}

@Test func supportReportSummarizesCavemanStatus() async throws {
    let snapshot = SystemSnapshot(
        chipName: "Apple M4 Max",
        architecture: "arm64",
        memoryBytes: 64 * 1024 * 1024 * 1024,
        gpuDescription: "40-core GPU",
        freeDiskBytes: 35 * 1024 * 1024 * 1024,
        hasOllama: true,
        hasDocker: true,
        hasOrbStack: false
    )
    let recommendation = LLMFitService().recommendation(for: snapshot, preference: .optimal)

    let report = SupportReportService().makeReport(snapshot: snapshot, recommendation: recommendation)

    #expect(report.contains("CAVEMAN"))
    #expect(report.contains("Apple M4 Max"))
    #expect(report.contains("Recommended profile"))
    #expect(report.contains("No Terminal required for Local Lite"))
}
