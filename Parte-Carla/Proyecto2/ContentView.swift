import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var activeProfileManager: ActiveProfileManager
    @Environment(\.modelContext) var modelContext
    @Query var profiles: [Profile]
    
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

    let appBackgroundColor = Color(
        red: 4 / 255.0,
        green: 203 / 255.0,
        blue: 198 / 255.0
    )

    var body: some View {
        ZStack {
            appBackgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                
                ZStack {
                    HStack {
                        Spacer()
                        Text("KAN")
                            .font(.largeTitle)
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
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 2))

                                Text(activeProfile.name)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                .frame(height: 100)
                
                Spacer()

                Image("CMICA")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 250)
                    .padding(.bottom, 40)

                VStack(spacing: 20) {
                    let buttonColor = Color(
                        red: 242 / 255.0,
                        green: 86 / 255.0,
                        blue: 150 / 255.0
                    )
                    
                    NavigationLink(destination: JuegoView(
                                                        nivelNumero: activeProfile.highestLevelUnlocked
                                    )) {
                                        Text("Comenzar")
                                            .font(.title2).fontWeight(.bold).foregroundColor(.white)
                                            .frame(width: 250, height: 60)
                                            .background(buttonColor)
                                            .cornerRadius(30)
                                    }

                    NavigationLink(destination: NivelesView()) {
                    }

                    NavigationLink(destination: NivelesView()) {
                        Text("Seleccionar nivel")
                            .font(.title2).fontWeight(.bold).foregroundColor(.white)
                            .frame(width: 250, height: 60)
                            .background(buttonColor)
                            .cornerRadius(30)
                    }

                    NavigationLink(destination: HistoriaView()) {
                        Text("Contar una historia")
                            .font(.title2).fontWeight(.bold).foregroundColor(.white)
                            .frame(width: 250, height: 60)
                            .background(buttonColor)
                            .cornerRadius(30)
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear {
            if profiles.isEmpty {
                showingFirstTimeSetup = true
            }
            
            UINavigationController.prototype.navigationBar.isHidden = true
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
                }
            }
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Ejecuta en el simulador para ver ContentView")
    }
}

extension UINavigationController {
    private static var onDisappearSwizzle: () = {
        let originalSelector = #selector(UINavigationController.viewWillDisappear(_:))
        let swizzledSelector = #selector(UINavigationController.swizzledViewWillDisappear(_:))
        
        guard let originalMethod = class_getInstanceMethod(UINavigationController.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(UINavigationController.self, swizzledSelector)
        else { return }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }()
    
    @objc private func swizzledViewWillDisappear(_ animated: Bool) {
        swizzledViewWillDisappear(animated)
        if let onDisappear = self.onDisappear {
            onDisappear()
        }
    }
    
    private struct AssociatedKeys {
        static var onDisappear = "onDisappear"
    }
    
    var onDisappear: (() -> Void)? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.onDisappear) as? () -> Void
        }
        set {
            _ = UINavigationController.onDisappearSwizzle
            objc_setAssociatedObject(self, &AssociatedKeys.onDisappear, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static var prototype: UINavigationController {
        return UINavigationController(rootViewController: UIViewController())
    }
}
