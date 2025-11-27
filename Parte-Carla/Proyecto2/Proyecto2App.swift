import SwiftUI
import SwiftData

@main
struct Proyecto2App: App {

    @StateObject private var activeProfileManager = ActiveProfileManager()
    @StateObject private var languageManager = LanguageManager()

    var body: some Scene {
    
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(activeProfileManager)
            .environmentObject(languageManager)
            
            .environment(\.locale, .init(identifier: languageManager.currentLanguage))
            .id(languageManager.currentLanguage)
            .navigationViewStyle(.stack)
            .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Profile.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            if let url = container.configurations.first?.url {
                try FileManager.default.setAttributes(
                    [.protectionKey: FileProtectionType.complete],
                    ofItemAtPath: url.path
                )
                print("Base de datos protegida y encriptada correctamente.")
            }
            
            return container
        } catch {
            fatalError("Error al crear el contenedor: \(error)")
        }
    }()
}
