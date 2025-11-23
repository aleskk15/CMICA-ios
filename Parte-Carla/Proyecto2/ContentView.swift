import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    
    @EnvironmentObject var activeProfileManager: ActiveProfileManager
    @Environment(\.modelContext) var modelContext
    @Query var profiles: [Profile]
    @EnvironmentObject var languageManager: LanguageManager    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var showingFirstTimeSetup: Bool = false
    
    var activeProfile: Profile {
        if let activeID = activeProfileManager.activeProfileID,
           let profile = profiles.first(where: { $0.id == activeID }) {
            return profile
        } else if let firstProfile = profiles.first {
            DispatchQueue.main.async {
                activeProfileManager.setActiveProfile(id: firstProfile.id)
            }
            return firstProfile
        } else {
            return Profile(name: "KAN", imageName: "perfil1", backgroundColorHex: "#F25696", realName: "Usuario", age: nil, allergies: [])
        }
    }

    let appBackgroundColor = Color(red: 4 / 255.0, green: 203 / 255.0, blue: 198 / 255.0)

    var body: some View {
        ZStack {
            appBackgroundColor.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                
                ZStack {
                    HStack {
                        Spacer()
                        Text("KAN")
                            .font(.custom("LilitaOne", size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.top, 10)

                    HStack {
                        NavigationLink(destination: SelectProfileView()) {
                            VStack(alignment: .center) {
                                ZStack {
                                    activeProfile.backgroundColor
                                    Image(activeProfile.imageName)
                                        .resizable().scaledToFill()
                                        .frame(width: 60, height: 60).clipShape(Circle())
                                }
                                .frame(width: 60, height: 60).clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 2))

                                Text(activeProfile.name)
                                    .font(.custom("LilitaOne", size: 15))
                                    .fontWeight(.semibold).foregroundColor(.black)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                languageManager.toggleLanguage()
                            }
                        }) {
                            ZStack {
                                // Globo de texto
                                Image(systemName: "bubble.left.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white.opacity(0.9))
                                    .overlay(
                                        Image(systemName: "bubble.left")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.black)
                                    )
                                
                                Text(languageManager.currentLanguage == "es" ? "ENG" : "ESP")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.black)
                                    .offset(y: -3)
                            }
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 100)
                
                Spacer()

                Image("CMICA")
                    .resizable().scaledToFit()
                    .frame(width: 350, height: 250).padding(.bottom, 40)

                VStack(spacing: 20) {
                    let buttonColor = Color(red: 242 / 255.0, green: 86 / 255.0, blue: 150 / 255.0)
                    let color2 = Color(red: 235/255.0, green: 144/255.0, blue: 0/255.0)
                    
                    NavigationLink(destination: JuegoView(nivelNumero: activeProfile.highestLevelUnlocked)) {
                        Text("Jugar")
                            .font(.custom("LilitaOne",size:28)).fontWeight(.bold).foregroundColor(.white)
                            .frame(width: 250, height: 60).background(buttonColor).cornerRadius(30)
                    }

                    NavigationLink(destination: NivelesView().environmentObject(activeProfileManager)) {
                        Text("Seleccionar nivel")
                            .font(.custom("LilitaOne",size:28)).fontWeight(.bold).foregroundColor(.white)
                            .frame(width: 250, height: 60).background(buttonColor).cornerRadius(30)
                    }

                    NavigationLink(destination: HistoriaView()) {
                        Text("Historias")
                            .font(.custom("LilitaOne",size:28)).fontWeight(.bold).foregroundColor(.white)
                            .frame(width: 250, height: 60).background(buttonColor).cornerRadius(30)
                    }
                    
                    NavigationLink(destination: InfoView()) {
                        Text("CONÓCENOS") 
                            .font(.custom("LilitaOne",size:28)).fontWeight(.bold).foregroundColor(.white)
                            .frame(width: 250, height: 60).background(color2).cornerRadius(30)
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
        .onAppear {
            if profiles.isEmpty { showingFirstTimeSetup = true }
            UINavigationController.prototype.navigationBar.isHidden = true
            
            pedirPermisoNotificaciones()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                print("App en background: Programando notificación...")
                programarNotificacionSalida()
            } else if newPhase == .active {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                print("App activa: Notificación cancelada.")
            }
        }
        .onDisappear {
            UINavigationController.prototype.navigationBar.isHidden = false
        }
        .sheet(isPresented: $showingFirstTimeSetup) {
            NavigationView {
                ProfileFormView_Step1(isPresented: $showingFirstTimeSetup)
                    .environmentObject(activeProfileManager)
            }
            .interactiveDismissDisabled()
            .modelContext(modelContext)
            .environment(\.locale, .init(identifier: languageManager.currentLanguage))
        }
    }
    
    func pedirPermisoNotificaciones() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted { print("Permiso notif. concedido ✅") }
        }
    }

    func programarNotificacionSalida() {
        let content = UNMutableNotificationContent()
        
        let titulo = NSLocalizedString("¡Hora de jugar!", comment: "")
        let cuerpo = NSLocalizedString("¡Kids Anafilaxia niños te extraña!", comment: "")
        
        content.title = titulo
        content.body = cuerpo
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "regresaApp", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UINavigationController {
    private static var onDisappearSwizzle: () = {
        let originalSelector = #selector(UINavigationController.viewWillDisappear(_:))
        let swizzledSelector = #selector(UINavigationController.swizzledViewWillDisappear(_:))
        guard let originalMethod = class_getInstanceMethod(UINavigationController.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(UINavigationController.self, swizzledSelector) else { return }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }()
    @objc private func swizzledViewWillDisappear(_ animated: Bool) {
        swizzledViewWillDisappear(animated)
        if let onDisappear = self.onDisappear { onDisappear() }
    }
    private struct AssociatedKeys { static var onDisappear = "onDisappear" }
    var onDisappear: (() -> Void)? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.onDisappear) as? () -> Void }
        set { _ = UINavigationController.onDisappearSwizzle; objc_setAssociatedObject(self, &AssociatedKeys.onDisappear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    static var prototype: UINavigationController { return UINavigationController(rootViewController: UIViewController()) }
}
