import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct ProfileFormView_Step1: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var editingProfile: Profile?
    @Binding var isPresented: Bool
    
    @State private var username: String = ""
    @State private var selectedImageName: String = "perfil1"
    @State private var selectedColorHex: String = "#F25696"
    @FocusState private var isUsernameFocused: Bool
    
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
                            .frame(width: 44, height: 44) // Área táctil mejorada
                            .contentShape(Rectangle())
                    }
                    Spacer()
                    Text(editingProfile == nil ? "Crear Perfil (1/2)" : "Editar Perfil (1/2)")
                        .font(.custom("LilitaOne",size: 35)).fontWeight(.bold).foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.title2).fontWeight(.bold).opacity(0)
                }
                .padding(.horizontal)
                .padding(.top, 75)
                .padding(.bottom, 10)
                
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            ProfilePhotoGrid(
                                profileImages: profileImages,
                                gridColumns: gridColumns,
                                selectedImageName: $selectedImageName,
                                selectedColorHex: selectedColorHex
                            )
                            
                            Text("Fondo")
                                .font(.custom("LilitaOne",size:30)).fontWeight(.bold).foregroundColor(.black).padding(.top, 10)

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
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Nombre de usuario")
                                    .font(.custom("LilitaOne", size:30)).fontWeight(.bold).foregroundColor(.black).padding(.top, 10)
                                
                                TextField("Escribe el nombre aquí...", text: $username)
                                    .font(.custom("LilitaOne",size:20)).padding()
                                    .background(textFieldBackgroundColor)
                                    .cornerRadius(30)
                                    .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                                    .focused($isUsernameFocused)
                                    .id("usernameField")
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Listo") {
                                                isUsernameFocused = false
                                            }
                                        }
                                    }
                            }

                            NavigationLink(destination: ProfileFormView_Step2(
                                editingProfile: editingProfile,
                                isPresented: $isPresented,
                                step1_username: username,
                                step1_imageName: selectedImageName,
                                step1_colorHex: selectedColorHex
                            )) {
                                Text("Siguiente")
                                    .font(.custom("LilitaOne", size:40)).fontWeight(.bold).foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .background(buttonColor)
                                    .cornerRadius(30)
                                    .shadow(radius: 5)
                            }
                            .disabled(username.trimmingCharacters(in: .whitespaces).isEmpty)
                            .padding(.top, 20)
                            .padding(.bottom, 300)
                            
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                    }
                    .onChange(of: isUsernameFocused) { isFocused in
                        if isFocused {
                            withAnimation {
                                scrollProxy.scrollTo("usernameField", anchor: .center)
                            }
                        }
                    }
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
    @EnvironmentObject var languageManager: LanguageManager
    
    // Detectar si es el primer usuario (BD vacía)
    @Query var existingProfiles: [Profile]
    
    var editingProfile: Profile?
    @Binding var isPresented: Bool
    
    let step1_username: String
    let step1_imageName: String
    let step1_colorHex: String
    
    @State private var realName: String = ""
    @State private var age: String = ""
    @State private var allergies: [String] = [""]
    
    @State private var showingDeleteAlert = false
    
    // Estados para Términos y Condiciones
    @State private var showTermsModal = false
    @State private var acceptedResponsibility = false
    @State private var acceptedTerms = false
    
    let allAllergies: [String] = [
        "Proteínas de leche de vaca", "Huevo", "Manzana", "Pera", "Kiwi", "Mango",
        "Durazno", "Plátano", "Sandía", "Papaya", "Uva", "Naranja", "Mandarina",
        "Higo", "Cereza", "Ciruela", "Fresa", "Melón", "Guayaba", "Coco",
        "Zanahoria", "Apio", "Calabaza", "Calabacita", "Pepino", "Aguacate",
        "Brocoli", "Coliflor", "Betabel", "Cebolla", "Ajo", "Esparrago", "Jitomate",
        "Tomate verde", "Trigo", "Maíz", "Cebada", "Centeno", "Arroz", "Avena",
        "Soya", "Garbanzo", "Frijol", "Lenteja", "Ejote", "Alubia", "Haba",
        "Avellana", "Almendra", "Pistache", "Nuez de la india", "Nuez", "Castaña",
        "Piñon", "Cacahuate", "Pescado", "Crustáceos", "Cefalópodos", "De concha (Bivalvos)"
    ]
    
    let buttonColor = Color(red: 238 / 255.0, green: 75 / 255.0, blue: 75 / 255.0)
    let textFieldBackgroundColor = Color.white.opacity(0.8)
    let termsButtonColor = Color(red: 40/255, green: 60/255, blue: 100/255)
    
    var canProceed: Bool {
        let fieldsValid = !realName.trimmingCharacters(in: .whitespaces).isEmpty
        if editingProfile != nil || !existingProfiles.isEmpty {
            return fieldsValid
        } else {
            return fieldsValid && acceptedResponsibility && acceptedTerms
        }
    }
    
    var body: some View {
        ZStack {
            Image("fondo")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .scaleEffect(1.1)
                .onTapGesture { hideKeyboard() }
            
            VStack(spacing: 0) {
                
                // --- HEADER ---
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2).fontWeight(.bold).foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    Spacer()
                    Text(editingProfile == nil ? "Crear Perfil (2/2)" : "Editar Perfil (2/2)")
                        .font(.custom("LilitaOne",size: 35)).fontWeight(.bold).foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.title2).fontWeight(.bold).opacity(0)
                        .frame(width: 44, height: 44)
                }
                .padding(.horizontal)
                .padding(.top, 75)
                .padding(.bottom, 10)
                
                // --- FORMULARIO ---
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Nombre")
                            .font(.custom("LilitaOne",size: 30)).fontWeight(.bold).foregroundColor(.black)
                        TextField("Nombre del niño/a", text: $realName)
                            .font(.custom("LilitaOne",size: 20)).padding()
                            .background(textFieldBackgroundColor)
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                        
                        Text("Edad")
                            .font(.custom("LilitaOne",size: 30)).fontWeight(.bold).foregroundColor(.black)
                        
                        TextField("Años", text: $age)
                            .font(.custom("LilitaOne",size: 20)).padding()
                            .background(textFieldBackgroundColor)
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                            .keyboardType(.numberPad)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Listo") {
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }
                                }
                            }
                        
                        AllergySelectionSection(
                            allAllergies: allAllergies,
                            allergies: $allergies,
                            textFieldBackgroundColor: textFieldBackgroundColor
                        )
                        
                        // --- TÉRMINOS Y CONDICIONES (SOLO SI ES PRIMERA VEZ) ---
                        if editingProfile == nil && existingProfiles.isEmpty {
                            VStack(spacing: 20) {
                                // Botón Leer
                                Button(action: {
                                    showTermsModal = true
                                }) {
                                    Text("terms_button".traducido(languageManager.currentLanguage))
                                        .font(.custom("LilitaOne", size: 20))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 20)
                                        .background(termsButtonColor)
                                        .cornerRadius(25)
                                }
                                
                                // Checkboxes alineados
                                VStack(alignment: .leading, spacing: 15) {
                                    // Check 1
                                    HStack(alignment: .top, spacing: 15) {
                                        Button(action: { acceptedResponsibility.toggle() }) {
                                            Image(systemName: acceptedResponsibility ? "checkmark.square.fill" : "square")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                        }
                                        Text("terms_responsibility".traducido(languageManager.currentLanguage))
                                            .font(.custom("LilitaOne", size: 16))
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .padding(.top, 4)
                                    }
                                    
                                    // Check 2
                                    HStack(alignment: .top, spacing: 15) {
                                        Button(action: { acceptedTerms.toggle() }) {
                                            Image(systemName: acceptedTerms ? "checkmark.square.fill" : "square")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                        }
                                        Text("terms_accept".traducido(languageManager.currentLanguage))
                                            .font(.custom("LilitaOne", size: 16))
                                            .foregroundColor(.black)
                                            .multilineTextAlignment(.leading)
                                            .padding(.top, 4)
                                    }
                                }
                                .padding(.horizontal, 10)
                            }
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                        }
                        
                        // --- BOTÓN GUARDAR / CREAR ---
                        Button(action: {
                            saveProfile()
                            isPresented = false
                        }) {
                            Text(editingProfile == nil ? "Crear Perfil" : "Guardar Cambios")
                                .font(.custom("LilitaOne",size:35)).fontWeight(.bold).foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .background(canProceed ? buttonColor : Color.gray)
                                .cornerRadius(30)
                                .shadow(radius: 5)
                        }
                        .disabled(!canProceed)
                        .padding(.top, 20)
                        // 👇 PADDING CONDICIONAL: Si es nuevo (y no hay botón eliminar), 60 abajo. Si es editar, 0.
                        .padding(.bottom, editingProfile == nil ? 60 : 0)
                        
                        // --- BOTÓN ELIMINAR (SOLO AL EDITAR) ---
                        if editingProfile != nil {
                            Button(action: {
                                showingDeleteAlert = true
                            }) {
                                Text("Eliminar Perfil")
                                    .font(.custom("LilitaOne",size:40)).fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 60)
                                    .background(Color.red)
                                    .cornerRadius(30)
                                    .shadow(radius: 5)
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 60)
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
        .sheet(isPresented: $showTermsModal) {
            TermsAndConditionsView()
                .environmentObject(languageManager)
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text(LocalizedStringKey("Eliminar Perfil")),
                message: Text(String(format: "confirm_delete_message".traducido(languageManager.currentLanguage), editingProfile?.name ?? "")),
                primaryButton: .destructive(Text(LocalizedStringKey("Eliminar"))) {
                    if let profile = editingProfile {
                        context.delete(profile)
                        isPresented = false
                    }
                },
                secondaryButton: .cancel(Text(LocalizedStringKey("Cancelar")))
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
                .font(.custom("LilitaOne",size: 30)).fontWeight(.bold).foregroundColor(.black)

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
                .font(.custom("LilitaOne",size:30)).fontWeight(.bold).foregroundColor(.black)
            
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
            Text(selectedAllergy.isEmpty ? LocalizedStringKey("Seleccionar alergia") : LocalizedStringKey(selectedAllergy))
                .font(.custom("LilitaOne", size: 20))
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
            Text(LocalizedStringKey("Ninguna")).tag("")
            ForEach(allAllergies, id: \.self) { allergy in
                Text(LocalizedStringKey(allergy)).tag(allergy)
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
