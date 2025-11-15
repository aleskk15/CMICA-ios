import SwiftUI
import SwiftData

struct NivelesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var activeProfileManager: ActiveProfileManager
    @Query var profiles: [Profile]
    
    var activeProfile: Profile {
        if let activeID = activeProfileManager.activeProfileID,
           let profile = profiles.first(where: { $0.id == activeID }) {
            return profile
        } else if let firstProfile = profiles.first {
            return firstProfile
        } else {
            return Profile(name: "Error", imageName: "perfil1", backgroundColorHex: "#FF0000", realName: "Error", age: nil, allergies: [])
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Niveles")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .fontWeight(.bold)
                    .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top, 50)
            .padding(.bottom, 10)
            .background(Color(red: 252/255, green: 172/255, blue: 80/255))

            
            
            GeometryReader { geometry in
                
                ScrollViewReader { scrollProxy in
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            ForEach(1...10, id: \.self) { numero in
                                NivelDetalleView(nivelNumero: numero, activeProfile: activeProfile)
                                    .frame(height: geometry.size.height)
                                
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.paging)
                    .ignoresSafeArea(edges: .bottom)
                    
                    .onAppear {
                        
                        var targetLevel = activeProfile.highestLevelUnlocked
                        
                        if targetLevel > 10 {
                            targetLevel = 10
                        }
                        
                        scrollProxy.scrollTo(targetLevel, anchor: .top)
                    }
                }
            }
        }
        .background(Color(red: 252/255, green: 172/255, blue: 80/255).edgesIgnoringSafeArea(.all))
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NivelesView()
        .environmentObject(ActiveProfileManager())
        .modelContainer(for: Profile.self)
}
