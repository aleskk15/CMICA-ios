import SwiftUI

struct InfoFieldView: View {
    let label: String
    let value: String
    
    let fieldBackgroundColor = Color.white

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading, 20)

            HStack {
                Text(value)
                    .font(.title3)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .background(fieldBackgroundColor)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 2)
            )
        }
    }
}


struct ProfileDetailView: View {
    let profile: Profile
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let formBackgroundColor = Color(red: 242 / 255.0, green: 86 / 255.0, blue: 150 / 255.0)
    let fieldBackgroundColor = Color.white

    var body: some View {
        ZStack {
            formBackgroundColor
                .edgesIgnoringSafeArea(.all)

            Image("fondo")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .scaleEffect(1.2)
            
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
                    
                    Text("Información del perfil")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .opacity(0)
                }
                .padding(.horizontal)
                .padding(.top, 75)
                .padding(.bottom, 10)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        ZStack {
                            profile.backgroundColor
                            Image(profile.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 145, height: 145)
                                .clipShape(Circle())
                        }
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 20)

                        InfoFieldView(label: "Nombre de Usuario", value: profile.name)
                        InfoFieldView(label: "Nombre", value: profile.realName)
                        InfoFieldView(label: "Edad", value: profile.age != nil ? "\(profile.age!) años" : "No especificada")
                        
                        Text("Alergias")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                        
                        if profile.allergies.isEmpty {
                            HStack {
                                Text("No se registraron alergias")
                                    .font(.title3)
                                    .foregroundColor(.black.opacity(0.7))
                                Spacer()
                            }
                            .padding()
                            .background(fieldBackgroundColor)
                            .cornerRadius(30)
                            .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                        
                        } else {
                            ForEach(profile.allergies, id: \.self) { allergy in
                                HStack {
                                    Text(allergy)
                                        .font(.title3)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding()
                                .background(fieldBackgroundColor)
                                .cornerRadius(30)
                                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 2))
                            }
                        }
                    }
                    .padding(30)
                }
                .background(Color.clear)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileDetailView(profile: Profile(
                name: "Perfil Preview",
                imageName: "perfil1",
                backgroundColorHex: "#F25696",
                realName: "Nombre Real",
                age: 8,
                allergies: ["Maní", "Polen"]
            ))
        }
    }
}
