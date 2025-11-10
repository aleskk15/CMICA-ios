import SwiftUI
import SwiftData

struct SelectProfileView: View {
    @EnvironmentObject var activeProfileManager: ActiveProfileManager
    
    @Environment(\.modelContext) var context
    
    @Query(sort: \Profile.name) var profiles: [Profile]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var navigateToAddProfile = false
    @State private var navigateToEditProfile = false
    @State private var profileToEdit: Profile? = nil

    let backgroundColor = Color(red: 4/255.0, green: 203/255.0, blue: 198/255.0)
    let profileRingColor = Color.black
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 0) {
                    
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title2).fontWeight(.bold).foregroundColor(.black)
                        }
                        Spacer()
                        Text("Seleccionar perfil")
                            .font(.largeTitle).fontWeight(.bold).foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.left").font(.title2).fontWeight(.bold).opacity(0)
                    }
                    .padding(.horizontal)
                    .padding(.top, 75)
                    .padding(.bottom, 10)
                    
                    let isEvenCount = profiles.count % 2 == 0

                    LazyVGrid(columns: columns, spacing: 40) {
                        ForEach(profiles) { profile in
                            ProfileCircleWithActionsView(
                                profile: profile,
                                ringColor: profileRingColor,
                                onSelect: {
                                    activeProfileManager.setActiveProfile(id: profile.id)
                                    presentationMode.wrappedValue.dismiss()
                                },
                                onEdit: {
                                    self.profileToEdit = profile
                                    self.navigateToEditProfile = true
                                }
                            )
                        }
                        
                        if !isEvenCount {
                            AddProfileCircleView(ringColor: profileRingColor)
                                .onTapGesture {
                                    navigateToAddProfile = true
                                }
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 30)

                    if isEvenCount {
                        AddProfileCircleView(ringColor: profileRingColor)
                            .onTapGesture {
                                navigateToAddProfile = true
                            }
                            .padding(.top, 40)
                    }
                
                }
            }
            
            VStack {
                NavigationLink(
                    destination: ProfileFormView_Step1(isPresented: $navigateToAddProfile),
                    isActive: $navigateToAddProfile
                ) { EmptyView() }
                
                NavigationLink(
                    destination: ProfileFormView_Step1(
                        editingProfile: profileToEdit,
                        isPresented: $navigateToEditProfile
                    ),
                    isActive: $navigateToEditProfile
                ) { EmptyView() }
            }
            
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            if let activeID = activeProfileManager.activeProfileID {
                if !profiles.contains(where: { $0.id == activeID }) {
                    activeProfileManager.activeProfileID = profiles.first?.id
                }
            } else {
                activeProfileManager.activeProfileID = profiles.first?.id
            }
        }
    }
}

struct ProfileCircleWithActionsView: View {
    let profile: Profile
    let ringColor: Color
    var onSelect: () -> Void
    var onEdit: () -> Void

    let circleSize: CGFloat = 100
    let iconSize: CGFloat = 28
    let iconOffset: CGFloat = 35

    var body: some View {
        VStack {
            ZStack {
                profile.backgroundColor
                Image(profile.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: circleSize - 5, height: circleSize - 5)
                    .clipShape(Circle())
            }
            .frame(width: circleSize, height: circleSize)
            .clipShape(Circle())
            .overlay(Circle().stroke(ringColor, lineWidth: 4))
            .shadow(radius: 5)
            .onTapGesture(perform: onSelect)
            
            .overlay(
                NavigationLink(destination: ProfileDetailView(profile: profile)) {
                    Image(systemName: "book.closed.fill")
                        .resizable().scaledToFit().frame(width: iconSize, height: iconSize)
                        .foregroundColor(.black).background(Color.white.opacity(0.8))
                        .clipShape(Circle()).overlay(Circle().stroke(Color.black, lineWidth: 1))
                }
                .offset(x: -iconOffset, y: iconOffset)
            )
            .overlay(
                Button(action: onEdit) {
                    Image(systemName: "pencil.circle.fill")
                        .resizable().scaledToFit().frame(width: iconSize, height: iconSize)
                        .foregroundColor(.black).background(Color.white.opacity(0.8))
                        .clipShape(Circle()).overlay(Circle().stroke(Color.black, lineWidth: 1))
                }
                .offset(x: iconOffset, y: iconOffset)
            )
            
            Text(profile.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 5)
        }
    }
}

struct AddProfileCircleView: View {
    let ringColor: Color
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .overlay(Circle().stroke(Color.black, lineWidth: 4))
                Image(systemName: "plus")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(width: 100, height: 100)
            .shadow(radius: 5)
            
            Text("Añadir perfil")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 5)
        }
    }
}

struct SelectProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Ejecuta en el simulador para ver SelectProfileView")
    }
}
