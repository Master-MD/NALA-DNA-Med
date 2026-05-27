import AppKit
import SwiftUI
import NALADNAMedCore

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }
}

@main
struct NALADNAMedApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var model = AppModel()

    var body: some Scene {
        WindowGroup("NALA-DNA-Med") {
            ContentView()
                .environmentObject(model)
                .frame(minWidth: 1180, minHeight: 760)
        }
        .commands {
            CommandGroup(after: .appInfo) {
                Button("Copy Support Report") {
                    model.copySupportReport()
                }
                .keyboardShortcut("r", modifiers: [.command, .shift])
            }
        }

        Settings {
            SettingsScreen()
                .environmentObject(model)
                .frame(width: 520, height: 360)
        }
    }
}
