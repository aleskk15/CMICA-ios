import SwiftUI

@main
struct Proyecto2App: App {
    @StateObject private var activeProfileManager = ActiveProfileManager()
        var body: some Scene {
            WindowGroup {
                NavigationView {
                    ContentView()
                }
                .environmentObject(activeProfileManager)
            }
            .modelContainer(for: Profile.self)
    }
}
