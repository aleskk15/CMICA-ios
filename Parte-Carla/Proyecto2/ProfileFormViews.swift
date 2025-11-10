import SwiftUI
import SwiftData

struct ProfileFormView_Step1: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var editingProfile: Profile?
    @Binding var isPresented: Bool
    
    @State private var username: String = ""
    @State private var selectedImageName: String = "perfil1"
    @State private var selectedColorHex: String = "#F25696"
    
    let profileImages = ["perfil1", "perfil2", "perfil3", "perfil4", "perfil5", "perfil6"]
    let gridColumns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let backgroundColorsHex = ["#F25696", "#FF7A00", "#FFC700", "#00C455", "#00B2FF", "#4B00B2", "#9A00B2"]
    
    let formBackgroundColor = Color(red: 242 / 255.0, green: 86 / 255.0, blue: 150 / 255.0)
    let buttonColor = Color(red: 238 / 255.0, green: 75 / 255.0, blue: 75 / 255.0)
    let textFieldBackgroundColor = Color.white

    var body: some View {
        ZStack {
            formBackgroundColor
                .edgesIgnoringSafeArea(.all)

            Image("fondo")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .scaleEffect(1.1)
                .onTapGesture { hideKeyboard() }
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2).fontWeight(.bold).foregroundColor(.black)
                    }
                    Spacer()
                    Text(editingProfile == nil ? "Crear Perfil (1/2)" : "Editar Perfil (1/2)")
                        .font(.title2).fontWeight(.bold).foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.title2).fontWeight(.bold).opacity(0)
                }
                .padding(.horizontal)
                .padding(.top, 75)
                .padding(.bottom, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        ProfilePhotoGrid(
                            profileImages: profileImages,
                            gridColumns: gridColumns,
                            selectedImageName: $selectedImageName,
                            selectedColorHex: selectedColorHex
                        )
                        
                        Text("Fondo")
                            .font(.title2).fontWeight(.bold).foregroundColor(.black).padding(.top, 10)

                        HStack(spacing: 15) {
                            ForEach(backgroundColorsHex, id: \.self) { colorHex in
                                Circle()
                                    .fill(Color(hex: colorHex))
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: 3)
                                            .opacity(selectedColorHex == colorHex ? 1 : 0)
                                    )
                                    .onTapGesture { selectedColorHex = colorHex }
                            }
                        }
                        
                        Text("Nombre de usuario")
                            .font(.title2).fontWeight(.bold).foregroundColor(.black).padding(.top, 10)
                        
                        TextField("Escribe el nombre aquí...", text: $username)
                            .font(.title3).padding()
                            .background(textFieldBackgroundColor)
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))

                        NavigationLink(destination: ProfileFormView_Step2(
                            editingProfile: editingProfile,
                            isPresented: $isPresented,
                            step1_username: username,
                            step1_imageName: selectedImageName,
                            step1_colorHex: selectedColorHex
                        )) {
                            Text("Siguiente")
                                .font(.title).fontWeight(.bold).foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .background(buttonColor)
                                .cornerRadius(30)
                                .shadow(radius: 5)
                        }
                        .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty)
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                }
                .background(Color.clear)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            if let editingProfile = editingProfile {
                username = editingProfile.name
                selectedImageName = editingProfile.imageName
                selectedColorHex = editingProfile.backgroundColorHex
            }
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ProfileFormView_Step2: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Environment(\.modelContext) var context
    @EnvironmentObject var activeProfileManager: ActiveProfileManager
    
    var editingProfile: Profile?
    
    @Binding var isPresented: Bool
    
    let step1_username: String
    let step1_imageName: String
    let step1_colorHex: String
    
    @State private var realName: String = ""
    @State private var age: String = ""
    @State private var allergies: [String] = [""]
    
    @State private var showingDeleteAlert = false
    
    let allAllergies: [String] = [
        "Maní", "Lácteos", "Huevo", "Trigo", "Soya",
        "Pescado", "Mariscos", "Nueces", "Polen", "Polvo",
        "Penicilina", "Látex"
    ]
    
    let buttonColor = Color(red: 238 / 255.0, green: 75 / 255.0, blue: 75 / 255.0)
    let textFieldBackgroundColor = Color.white.opacity(0.8)

    var body: some View {
        ZStack {
            Image("fondo")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .scaleEffect(1.1)
                .onTapGesture { hideKeyboard() }
            
            VStack(spacing: 0) {

                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2).fontWeight(.bold).foregroundColor(.black)
                    }
                    Spacer()
                    Text(editingProfile == nil ? "Crear Perfil (2/2)" : "Editar Perfil (2/2)")
                        .font(.title2).fontWeight(.bold).foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.title2).fontWeight(.bold).opacity(0)
                }
                .padding(.horizontal)
                .padding(.top, 75)
                .padding(.bottom, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Nombre")
                            .font(.title2).fontWeight(.bold).foregroundColor(.black)
                        TextField("Nombre del niño/a", text: $realName)
                            .font(.title3).padding()
                            .background(textFieldBackgroundColor)
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))

                        Text("Edad")
                            .font(.title2).fontWeight(.bold).foregroundColor(.black)
                        TextField("Años", text: $age)
                            .font(.title3).padding()
                            .background(textFieldBackgroundColor)
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                            .keyboardType(.numberPad)

                        AllergySelectionSection(
                            allAllergies: allAllergies,
                            allergies: $allergies,
                            textFieldBackgroundColor: textFieldBackgroundColor
                        )

                        Button(action: {
                            saveProfile()
                            isPresented = false
                        }) {
                            Text(editingProfile == nil ? "Crear Perfil" : "Guardar Cambios")
                                .font(.title).fontWeight(.bold).foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .background(buttonColor)
                                .cornerRadius(30)
                                .shadow(radius: 5)
                        }
                        .disabled(realName.trimmingCharacters(in: .whitespaces).isEmpty)
                        .padding(.top, 20)
                        
                        if editingProfile != nil {
                            Button(action: {
                                showingDeleteAlert = true
                            }) {
                                Text("Eliminar Perfil")
                                    .font(.title).fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .background(Color.red)
                                    .cornerRadius(30)
                                    .shadow(radius: 5)
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 40)
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                }
                .background(Color.clear)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            if let editingProfile = editingProfile {
                realName = editingProfile.realName
                age = editingProfile.age != nil ? "\(editingProfile.age!)" : ""
                allergies = editingProfile.allergies.isEmpty ? [""] : editingProfile.allergies
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Eliminar Perfil"),
                message: Text("¿Estás seguro de que quieres eliminar el perfil \(editingProfile?.name ?? "")? Esta acción no se puede deshacer."),
                primaryButton: .destructive(Text("Eliminar")) {
                    if let profile = editingProfile {
                        context.delete(profile)
                        isPresented = false
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func saveProfile() {
        let finalAge = Int(age)
        let filteredAllergies = allergies.filter { !$0.isEmpty }

        if let profile = editingProfile {
            profile.name = step1_username
            profile.imageName = step1_imageName
            profile.backgroundColorHex = step1_colorHex
            profile.realName = realName
            profile.age = finalAge
            profile.allergies = filteredAllergies
        } else {
            let newProfile = Profile(
                name: step1_username,
                imageName: step1_imageName,
                backgroundColorHex: step1_colorHex,
                realName: realName,
                age: finalAge,
                allergies: filteredAllergies
            )
            context.insert(newProfile)
            activeProfileManager.setActiveProfile(id: newProfile.id)
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct AllergySelectionSection: View {
    
    let allAllergies: [String]
    @Binding var allergies: [String]
    let textFieldBackgroundColor: Color

    var body: some View {
        Group {
            Text("Alergias")
                .font(.title2).fontWeight(.bold).foregroundColor(.black)

            AllergyPickerList(
                allAllergies: allAllergies,
                allergies: $allergies,
                textFieldBackgroundColor: textFieldBackgroundColor
            )
            
            AllergyAddRemoveButtons(allergies: $allergies)
        }
    }
}

struct ProfilePhotoGrid: View {
    let profileImages: [String]
    let gridColumns: [GridItem]
    @Binding var selectedImageName: String
    let selectedColorHex: String
    
    var body: some View {
        Group {
            Text("Foto de perfil")
                .font(.title2).fontWeight(.bold).foregroundColor(.black)
            
            LazyVGrid(columns: gridColumns, spacing: 20) {
                ForEach(profileImages, id: \.self) { imageName in
                    ZStack {
                        Color(hex: selectedColorHex)
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipShape(Circle())
                    }
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 3))
                    .padding(4)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 3).padding(4)
                            .opacity(selectedImageName == imageName ? 1 : 0)
                    )
                    .onTapGesture { selectedImageName = imageName }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct AllergyAddRemoveButtons: View {
    @Binding var allergies: [String]
    
    var body: some View {
        HStack(spacing: 30) {
            Spacer()
            Button(action: {
                allergies.append("")
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 50)).foregroundColor(.white).shadow(radius: 3)
            }
            Button(action: {
                if allergies.count > 1 {
                    allergies.removeLast()
                } else {
                    allergies[0] = ""
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 50)).foregroundColor(.white).shadow(radius: 3)
            }
            .disabled(allergies.count == 1 && allergies[0].isEmpty)
            Spacer()
        }
        .padding(.top, 10)
    }
}

struct AllergyPickerList: View {
    let allAllergies: [String]
    @Binding var allergies: [String]
    let textFieldBackgroundColor: Color
    
    var body: some View {
        ForEach(allergies.indices, id: \.self) { index in
            AllergyPickerRow(
                allAllergies: allAllergies,
                selectedAllergy: $allergies[index],
                textFieldBackgroundColor: textFieldBackgroundColor
            )
        }
    }
}

struct AllergyPickerRow: View {
    let allAllergies: [String]
    @Binding var selectedAllergy: String
    let textFieldBackgroundColor: Color
    
    var pickerLabel: some View {
        HStack {
            Text(selectedAllergy.isEmpty ? "Seleccionar alergia" : selectedAllergy)
                .font(.title3)
                .foregroundColor(selectedAllergy.isEmpty ? .black.opacity(0.6) : .black)
            Spacer()
        }
        .padding()
        .background(textFieldBackgroundColor)
        .cornerRadius(30)
        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
    }

    var body: some View {
        Picker(selection: $selectedAllergy, label: pickerLabel) {
            Text("Ninguna").tag("")
            ForEach(allAllergies, id: \.self) { allergy in
                Text(allergy).tag(allergy)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}

struct ProfileFormViews_Previews: PreviewProvider {
    static var previews: some View {
        Text("Preview de ProfileFormViews deshabilitado para compilación.")
            .padding()
            .environmentObject(ActiveProfileManager())
    }
}
