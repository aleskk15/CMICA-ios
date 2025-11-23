import SwiftUI

struct HistoriaView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var languageManager: LanguageManager
    
    let colorFondo = Color(red: 90/255, green: 84/255, blue: 137/255)
    let colorBarras = Color(red: 111/255, green: 105/255, blue: 156/255)

    let historias = StoryRepository.historias

    var body: some View {
        ZStack {
            colorFondo
                .edgesIgnoringSafeArea(.all)
            
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
                    /*Text("Cuentos")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)*/
                    
                    Text("Contar una historia")
                        .padding(.top,15)
                        .font(.custom("LilitaOne", size:35))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom,8)
                    
                    Spacer()
                    Image(systemName: "chevron.left")
                        .font(.title2).fontWeight(.bold).opacity(0)
                }
                .padding()
                .padding(.top, 40)

                TabView {
                    ForEach(historias) { historia in
                        VStack {
                            Text(historia.tituloKey.traducido(languageManager.currentLanguage))
                                .font(.custom("LilitaOne", size:40))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(colorBarras)
                                .cornerRadius(15)
                                .padding(.horizontal)
                        
                            Spacer()
                            
                            // Portada
                            Image(historia.portada)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 350)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            Spacer()

                            NavigationLink(destination: CuentoView(historia: historia)) {
                                HStack {
                                    Image(systemName: "book.fill")
                                    Text("Leer Historia")
                                        .fontWeight(.bold)
                                }
                                .font(.custom("LilitaOne", size:25))    .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 40)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                            }
                            .padding(.bottom, 60)
                        }
                        .tag(historia.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
            .ignoresSafeArea(edges: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    HistoriaView()
}
