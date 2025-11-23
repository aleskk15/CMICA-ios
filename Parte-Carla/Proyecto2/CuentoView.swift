import SwiftUI

struct CuentoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var languageManager: LanguageManager
    @StateObject private var speechManager = SpeechManager()
    @State private var currentPageIndex: Int = 0
    
    let historia: HistoriaData
    
    var body: some View {
            ZStack {
                Color(red: 242/255, green: 242/255, blue: 247/255)
                    .edgesIgnoringSafeArea(.all)
                
                // 3. TABVIEW CON ÍNDICE ($currentPageIndex)
                TabView(selection: $currentPageIndex) {
                    // Usamos .enumerated() para saber el número de página (0, 1, 2...)
                    ForEach(Array(historia.paginas.enumerated()), id: \.element.id) { index, pagina in
                        VStack(spacing: 0) {
                            
                            GeometryReader { geo in
                                Image(pagina.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width, height: geo.size.height)
                                    .clipped()
                            }
                            .frame(maxHeight: .infinity)
                            
                            VStack {
                                ScrollView {
                                    // Texto traducido
                                    Text(pagina.textKey.traducido(languageManager.currentLanguage))
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                }
                            }
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20, corners: [.topLeft, .topRight])
                            .shadow(radius: 5)
                        }
                        .tag(index) // Importante: Etiquetamos la página con su número
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .ignoresSafeArea(edges: .bottom)
                
                // CAMBIO: DETECTAR CAMBIO DE PÁGINA PARA CALLAR LA VOZ
                // Si el niño cambia de página, el audio anterior se detiene.
                .onChange(of: currentPageIndex) { _ in
                    speechManager.stop()
                }
                
                // BOTONES FLOTANTES (Cerrar y Hablar)
                VStack {
                    HStack {
                        // Botón Cerrar (Izquierda)
                        Button(action: {
                            speechManager.stop() // Callar al salir
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.black.opacity(0.6))
                        }
                        
                        Spacer()
                        
                        // 4. BOTÓN DE TEXT TO SPEECH (Derecha)
                        Button(action: {
                            // A. Obtenemos la clave de texto de la página actual
                            let claveTexto = historia.paginas[currentPageIndex].textKey
                            // B. La traducimos al idioma actual
                            let textoTraducido = claveTexto.traducido(languageManager.currentLanguage)
                            // C. Le decimos al manager que hable
                            speechManager.hablar(texto: textoTraducido, idiomaApp: languageManager.currentLanguage)
                        }) {
                            // Cambia el icono si está hablando o callado
                            Image(systemName: speechManager.isSpeaking ? "speaker.wave.2.circle.fill" : "speaker.circle.fill")
                                .font(.system(size: 40))
                                // Si habla se pone naranja, si no, gris oscuro
                                .foregroundColor(speechManager.isSpeaking ? .orange : .black.opacity(0.6))
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 50) 
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .onDisappear {
                speechManager.stop()
            }
        }
    }

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    CuentoView(historia: StoryRepository.historias[0])
}
