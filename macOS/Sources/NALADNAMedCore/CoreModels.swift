import Foundation

public enum CAVEMANStatus: String, Codable, Sendable {
    case green
    case yellow
    case red
}

public struct SystemSnapshot: Codable, Equatable, Sendable {
    public var chipName: String
    public var architecture: String
    public var memoryBytes: Int64
    public var gpuDescription: String
    public var freeDiskBytes: Int64
    public var hasOllama: Bool
    public var hasDocker: Bool
    public var hasOrbStack: Bool

    public init(
        chipName: String,
        architecture: String,
        memoryBytes: Int64,
        gpuDescription: String,
        freeDiskBytes: Int64,
        hasOllama: Bool,
        hasDocker: Bool,
        hasOrbStack: Bool
    ) {
        self.chipName = chipName
        self.architecture = architecture
        self.memoryBytes = memoryBytes
        self.gpuDescription = gpuDescription
        self.freeDiskBytes = freeDiskBytes
        self.hasOllama = hasOllama
        self.hasDocker = hasDocker
        self.hasOrbStack = hasOrbStack
    }
}

public enum LLMFitProfile: String, Codable, CaseIterable, Hashable, Sendable {
    case kleiner = "Kleiner"
    case optimal = "Optimal"
    case maximal = "Maximal"
}

public struct LLMFitRecommendation: Codable, Equatable, Sendable {
    public var profile: LLMFitProfile
    public var status: CAVEMANStatus
    public var title: String
    public var reasons: [String]
    public var requiresLargeDownloadConfirmation: Bool
}

public enum RemoteResourceKind: String, Codable, Sendable {
    case catalog
    case template
    case sourceMetadata
    case modelMetadata
    case modelWeights
    case biomedicalWeights
    case largeDataset
    case dependencyBundle
}

public struct RemoteResource: Codable, Equatable, Sendable {
    public var name: String
    public var source: URL
    public var sizeBytes: Int64
    public var kind: RemoteResourceKind
    public var license: String?

    public init(name: String, source: URL, sizeBytes: Int64, kind: RemoteResourceKind, license: String?) {
        self.name = name
        self.source = source
        self.sizeBytes = sizeBytes
        self.kind = kind
        self.license = license
    }
}

public enum DownloadDecision: String, Codable, Sendable {
    case allowedAutomatically
    case requiresConfirmation
    case blockedInsufficientDisk
}

public enum ConfidenceLevel: String, Codable, Sendable {
    case low
}

public struct BioLabDryRunResult: Codable, Equatable, Sendable {
    public var demoMode: Bool
    public var notMedicalAdvice: Bool
    public var confidence: ConfidenceLevel
    public var summary: String
    public var warnings: [String]
}

public struct TenantContext: Codable, Equatable, Sendable {
    public var tenantID: String?
    public var userID: String?
    public var projectID: String?

    public init(tenantID: String?, userID: String?, projectID: String?) {
        self.tenantID = tenantID
        self.userID = userID
        self.projectID = projectID
    }
}

public enum TenantShieldError: Error, Equatable, Sendable {
    case missingTenantID
    case missingProjectID
}

public struct Project: Identifiable, Codable, Equatable, Sendable {
    public var id: String
    public var tenantID: String
    public var userID: String
    public var name: String
    public var summary: String
    public var createdAt: Date

    public init(id: String, tenantID: String, userID: String, name: String, summary: String, createdAt: Date) {
        self.id = id
        self.tenantID = tenantID
        self.userID = userID
        self.name = name
        self.summary = summary
        self.createdAt = createdAt
    }
}

public struct AuditEvent: Identifiable, Codable, Equatable, Sendable {
    public var id: String
    public var action: String
    public var status: CAVEMANStatus
    public var message: String
    public var createdAt: Date

    public init(id: String, action: String, status: CAVEMANStatus, message: String, createdAt: Date) {
        self.id = id
        self.action = action
        self.status = status
        self.message = message
        self.createdAt = createdAt
    }
}
