import SwiftUI
import UniformTypeIdentifiers
import NALADNAMedCore

struct ContentView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $model.selection)
        } detail: {
            DetailRouter(section: model.selection)
                .background(AppTheme.background)
        }
        .toolbar {
            ToolbarItemGroup {
                Button {
                    model.refreshSystemCheck()
                } label: {
                    Label("System Check", systemImage: "checklist")
                }

                Button {
                    model.copySupportReport()
                } label: {
                    Label("Support", systemImage: "doc.on.doc")
                }
            }
        }
    }
}

struct SidebarView: View {
    @Binding var selection: AppSection

    var body: some View {
        List(AppSection.allCases, selection: $selection) { section in
            Label(section.rawValue, systemImage: section.systemImage)
                .tag(section)
        }
        .listStyle(.sidebar)
        .navigationTitle("NALA-DNA-Med")
    }
}

struct DetailRouter: View {
    let section: AppSection

    var body: some View {
        switch section {
        case .dashboard:
            DashboardView()
        case .firstRun:
            FirstRunView()
        case .systemCheck:
            SystemCheckView()
        case .llmFit:
            LLMFitView()
        case .projects:
            ProjectsView()
        case .upload:
            UploadCenterView()
        case .biolab:
            BioLabDemoView()
        case .jobsAudit:
            JobsAuditView()
        case .resources:
            ResourcesView()
        case .backup:
            BackupRestoreView()
        case .support:
            SupportReportView()
        }
    }
}

struct FirstRunView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "CAVEMAN First Run", subtitle: "Installieren, starten, Demo nutzen. Kein Terminal fuer Local Lite.") {
            WarningBanner()
            HStack(alignment: .top, spacing: 16) {
                StatusCard(title: "1. Safety", status: model.acceptedSafetyNotice ? .green : .yellow, message: "Research support only. Keine Diagnose oder Therapie.")
                StatusCard(title: "2. System Check", status: model.recommendation.status, message: model.recommendation.title)
                StatusCard(title: "3. Demo Mode", status: .green, message: "Local Lite funktioniert ohne Docker.")
            }

            Card {
                VStack(alignment: .leading, spacing: 12) {
                    Text("CAVEMAN path")
                        .font(.headline)
                    Text("DMG oeffnen, App in Applications ziehen, starten, Safety Notice lesen, Kleiner waehlen, Demo Mode nutzen.")
                        .foregroundStyle(.secondary)
                    HStack {
                        Button("Use Demo Mode") {
                            model.acceptSafetyAndStartDemo()
                        }
                        .buttonStyle(.borderedProminent)
                        Button("Run System Check") {
                            model.refreshSystemCheck()
                            model.selection = .systemCheck
                        }
                    }
                }
            }
        }
    }
}

struct DashboardView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "Dashboard", subtitle: "Local-first biomedical research support workspace.") {
            WarningBanner()
            HStack(alignment: .top, spacing: 16) {
                StatusCard(title: "Runtime", status: .green, message: "Local Lite active")
                StatusCard(title: "LLM-Fit", status: model.recommendation.status, message: model.recommendation.profile.rawValue)
                StatusCard(title: "Projects", status: .green, message: "\(model.projects.count) local vaults")
            }
            Card {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Next actions").font(.headline)
                    ActionRow(text: "Create or open a research demo vault.", section: .projects)
                    ActionRow(text: "Run a safety-marked BioLab dry-run.", section: .biolab)
                    ActionRow(text: "Copy a CAVEMAN support report.", section: .support)
                }
            }
        }
    }
}

struct SystemCheckView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "System Check", subtitle: "Ampel-Check fuer CAVEMAN Installation und Local Lite.") {
            HStack(alignment: .top, spacing: 16) {
                StatusCard(title: "Mac", status: .green, message: model.snapshot.chipName)
                StatusCard(title: "Ollama", status: model.snapshot.hasOllama ? .green : .yellow, message: model.snapshot.hasOllama ? "Installed" : "Optional")
                StatusCard(title: "Docker", status: model.snapshot.hasDocker ? .green : .yellow, message: model.snapshot.hasDocker ? "Core Mode possible" : "Local Lite unaffected")
            }
            Card {
                VStack(alignment: .leading, spacing: 8) {
                    InfoLine("Architecture", model.snapshot.architecture)
                    InfoLine("Memory", ByteCountFormatter.string(fromByteCount: model.snapshot.memoryBytes, countStyle: .memory))
                    InfoLine("Free disk", ByteCountFormatter.string(fromByteCount: model.snapshot.freeDiskBytes, countStyle: .file))
                    InfoLine("GPU", model.snapshot.gpuDescription)
                    Button("Refresh System Check") {
                        model.refreshSystemCheck()
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
}

struct LLMFitView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "LLM-Fit Advisor", subtitle: "Waehle Kleiner, Optimal oder Maximal. Grosse Downloads nur nach Zustimmung.") {
            HStack(spacing: 16) {
                ProfileCard(profile: .kleiner, copy: profileCopy(.kleiner))
                ProfileCard(profile: .optimal, copy: profileCopy(.optimal))
                ProfileCard(profile: .maximal, copy: profileCopy(.maximal))
            }
            Card {
                VStack(alignment: .leading, spacing: 8) {
                    Text(model.recommendation.title).font(.headline)
                    ForEach(model.recommendation.reasons, id: \.self) { reason in
                        Text("- \(reason)")
                            .foregroundStyle(.secondary)
                    }
                    if model.recommendation.requiresLargeDownloadConfirmation {
                        Text("Large model downloads require explicit confirmation.")
                            .foregroundStyle(AppTheme.emerald)
                    }
                }
            }
        }
    }

    private func profileCopy(_ profile: LLMFitProfile) -> String {
        switch profile {
        case .kleiner:
            "Schnell, klein, sicher bei wenig Speicherplatz."
        case .optimal:
            "Balance aus Qualitaet, Tempo und Speicherbedarf."
        case .maximal:
            "Groesseres Setup nur mit bestaetigtem Download."
        }
    }
}

struct ProjectsView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "Projects / Vaults", subtitle: "Tenant-aware local research vaults.") {
            Button("Create Demo Project") {
                model.createDemoProject()
            }
            .buttonStyle(.borderedProminent)

            ForEach(model.projects) { project in
                Card {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(project.name).font(.headline)
                        Text(project.summary).foregroundStyle(.secondary)
                        Text("tenant_id: \(project.tenantID)  project_id: \(project.id)")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
        }
    }
}

struct UploadCenterView: View {
    var body: some View {
        ScreenScaffold(title: "Upload Center", subtitle: "Local placeholders for PDFs, CSV, FASTA, SMILES.") {
            WarningBanner()
            Card {
                VStack(alignment: .leading, spacing: 8) {
                    Text("CAVEMAN mode keeps uploads local in v0.1.")
                        .font(.headline)
                    Text("Drag-and-drop parsing is planned. Demo mode uses synthetic local examples only.")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

struct BioLabDemoView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "BioLab Demo", subtitle: "Dry-run only. Keine medizinischen Claims.") {
            WarningBanner()
            Card {
                VStack(alignment: .leading, spacing: 12) {
                    TextField("SMILES", text: $model.smilesInput)
                    TextField("Protein sequence", text: $model.proteinInput)
                    Button("Run Dry-Run") {
                        model.runBioLabDryRun()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            Card {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Demo result").font(.headline)
                    InfoLine("demo_mode", String(model.bioLabResult.demoMode))
                    InfoLine("not_medical_advice", String(model.bioLabResult.notMedicalAdvice))
                    InfoLine("confidence", model.bioLabResult.confidence.rawValue)
                    Text(model.bioLabResult.summary)
                        .foregroundStyle(.secondary)
                    ForEach(model.bioLabResult.warnings, id: \.self) { warning in
                        Text("- \(warning)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

struct JobsAuditView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "Jobs / Audit", subtitle: "Every important action leaves a local audit trace.") {
            ForEach(model.auditEvents) { event in
                StatusCard(title: event.action, status: event.status, message: event.message)
            }
        }
    }
}

struct ResourcesView: View {
    @EnvironmentObject private var model: AppModel
    @State private var isChoosingModelFile = false
    private let modelFileTypes: [UTType] = [
        UTType(filenameExtension: "gguf") ?? .data,
        UTType(filenameExtension: "safetensors") ?? .data,
        UTType(filenameExtension: "bin") ?? .data,
        UTType(filenameExtension: "mlmodel") ?? .data,
        UTType(filenameExtension: "mlpackage") ?? .package
    ]

    var body: some View {
        ScreenScaffold(title: "Resources", subtitle: "Small catalogs can refresh automatically; large models need confirmation.") {
            StatusCard(title: "Auto", status: .green, message: "Small JSON catalogs, templates, citations")
            StatusCard(title: "Confirm", status: .yellow, message: "LLM weights, biomedical weights, large datasets")
            StatusCard(title: "Blocked", status: .red, message: "Unknown source or insufficient disk")

            Card {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Model Manager").font(.headline)
                    Text("Direkt per Weblink oder ueber Finder/HD-Datei auswaehlen. Der Plan wird vorbereitet; grosse Transfers bleiben bestaetigungspflichtig.")
                        .foregroundStyle(.secondary)

                    TextField("https://huggingface.co/.../model.gguf", text: $model.modelWebLink)
                    HStack {
                        TextField("Expected GB", text: $model.modelExpectedSizeGB)
                            .frame(width: 120)
                        Button("Check Weblink") {
                            model.planWebModelImport()
                        }
                        Button("Download Weblink") {
                            model.downloadWebModel()
                        }
                        .disabled(model.isModelTransferRunning)
                        Button("Choose Local Model File...") {
                            isChoosingModelFile = true
                        }
                        .disabled(model.isModelTransferRunning)
                    }

                    Text(model.modelImportMessage)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)

                    if let plan = model.modelImportPlan {
                        InfoLine("Source", plan.source.rawValue)
                        InfoLine("Model", plan.displayName)
                        InfoLine("Confirm", plan.requiresConfirmation ? "yes" : "no")

                        if plan.source == .localFile {
                            Button("Import Selected File") {
                                model.importPlannedLocalModel()
                            }
                            .disabled(model.isModelTransferRunning)
                        }
                    }
                }
            }
        }
        .fileImporter(
            isPresented: $isChoosingModelFile,
            allowedContentTypes: modelFileTypes,
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    model.planLocalModelImport(from: url)
                }
            case .failure(let error):
                model.recordModelImportFailure(error)
            }
        }
    }
}

struct BackupRestoreView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "Backup / Restore", subtitle: "Timestamped local backups. No delete without confirmation.") {
            Card {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Suggested backup name").font(.headline)
                    Text(model.suggestedBackupName())
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(AppTheme.emerald)
                    Text("Model caches are excluded by default in CAVEMAN mode.")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

struct SupportReportView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        ScreenScaffold(title: "Support Report", subtitle: "Copy this when asking someone for help.") {
            Button("Copy Support Report") {
                model.copySupportReport()
            }
            .buttonStyle(.borderedProminent)
            Card {
                Text(model.supportReport())
                    .font(.system(.body, design: .monospaced))
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct SettingsScreen: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("NALA-DNA-Med Settings")
                .font(.title2.bold())
            Toggle("Safety notice accepted", isOn: $model.acceptedSafetyNotice)
            Picker("LLM-Fit profile", selection: $model.selectedProfile) {
                Text(LLMFitProfile.kleiner.rawValue).tag(LLMFitProfile.kleiner)
                Text(LLMFitProfile.optimal.rawValue).tag(LLMFitProfile.optimal)
                Text(LLMFitProfile.maximal.rawValue).tag(LLMFitProfile.maximal)
            }
            Text("Local Lite remains available without Docker, OrbStack, or Terminal.")
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding()
    }
}

struct ProfileCard: View {
    @EnvironmentObject private var model: AppModel
    let profile: LLMFitProfile
    let copy: String

    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.rawValue).font(.title3.bold())
                Text(copy)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Button(model.selectedProfile == profile ? "Selected" : "Select") {
                    model.chooseProfile(profile)
                }
                .buttonStyle(.bordered)
                .tint(model.selectedProfile == profile ? AppTheme.emerald : .secondary)
            }
        }
    }
}

struct ActionRow: View {
    @EnvironmentObject private var model: AppModel
    let text: String
    let section: AppSection

    var body: some View {
        Button {
            model.selection = section
        } label: {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .buttonStyle(.plain)
        .padding(.vertical, 4)
    }
}

struct ScreenScaffold<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.largeTitle.bold())
                    Text(subtitle)
                        .foregroundStyle(.secondary)
                }
                content
            }
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct WarningBanner: View {
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.yellow)
            Text("Dieses System ist keine medizinische Beratung und nicht fuer Diagnose oder Therapie validiert.")
                .font(.headline)
        }
        .padding(12)
        .background(AppTheme.warningBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct StatusCard: View {
    let title: String
    let status: CAVEMANStatus
    let message: String

    var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Circle()
                        .fill(statusColor)
                        .frame(width: 10, height: 10)
                    Text(title)
                        .font(.headline)
                }
                Text(message)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private var statusColor: Color {
        switch status {
        case .green: AppTheme.emerald
        case .yellow: .yellow
        case .red: .red
        }
    }
}

struct Card<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppTheme.card)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.border, lineWidth: 1)
            )
    }
}

struct InfoLine: View {
    let label: String
    let value: String

    init(_ label: String, _ value: String) {
        self.label = label
        self.value = value
    }

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.system(.body, design: .monospaced))
                .textSelection(.enabled)
        }
    }
}

enum AppTheme {
    static let emerald = Color(red: 0.0, green: 0.88, blue: 0.48)
    static let background = LinearGradient(
        colors: [
            Color(red: 0.02, green: 0.025, blue: 0.025),
            Color(red: 0.075, green: 0.085, blue: 0.085)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    static let card = Color(red: 0.09, green: 0.105, blue: 0.105).opacity(0.92)
    static let border = Color(red: 0.0, green: 0.58, blue: 0.34).opacity(0.35)
    static let warningBackground = Color.yellow.opacity(0.14)
}
