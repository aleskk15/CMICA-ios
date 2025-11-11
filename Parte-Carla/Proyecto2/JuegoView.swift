import SwiftUI
import SwiftData
struct GridBackgroundView: View {
    let gridSize: CGFloat = 70
    let lineColor = Color.white.opacity(0.3)
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for i in 0...Int(geometry.size.width / gridSize) {
                    let x = CGFloat(i) * gridSize
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                }
                
                for i in 0...Int(geometry.size.height / gridSize) {
                    let y = CGFloat(i) * gridSize
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }
            }
            .stroke(lineColor, lineWidth: 4)
        }
    }
}


struct JuegoView: View {
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
    
    @State private var puntos: Int = 0
    @State private var alimentosEnPantalla: [Alimento] = []
    @State private var proyectil: Proyectil? = nil
    @State private var armaPosition: CGPoint = .zero
    @State private var sePuedeDisparar: Bool = true
    
    @State private var mostrarMensajePuntos: Bool = false
    @State private var mensajePuntosTexto: String = ""
    @State private var mensajePuntosOffset: CGFloat = 0
    
    private let alimentoRepo = AlimentoRepository()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(red: 45/255, green: 71/255, blue: 118/255)
                    .edgesIgnoringSafeArea(.all)

                GridBackgroundView()
                    .edgesIgnoringSafeArea(.all)
                
                Image("blobRosa")
                    .resizable().scaledToFit().frame(width: 500, height: 500)
                    .position(x: 100, y: 300).blendMode(.screen)
                Image("blobAzul")
                    .resizable().scaledToFit().frame(width: 300, height: 300)
                    .position(x: 300, y: 00).blendMode(.screen)
                Image("blobVerde")
                    .resizable().scaledToFit().frame(width: 250, height: 250)
                    .position(x: 390, y: 700).blendMode(.screen)

                VStack(spacing: 0) {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title).fontWeight(.bold).foregroundColor(.white)
                        }
                        Text("Alérgico al: ").font(.title).fontWeight(.bold).foregroundColor(.white)
                        // Mostramos las alergias REALES del perfil
                        Text(activeProfile.allergies.isEmpty ? "Nada" : activeProfile.allergies.joined(separator: ", "))
                            .font(.title3).fontWeight(.bold).foregroundColor(.white) // Un poco más pequeño
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.horizontal))
                    .padding(.top, 50)

                    Text("\(puntos) puntos") // Mostramos los puntos REALES
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 255/255, green: 220/255, blue: 0/255))
                        .shadow(color: .black.opacity(0.7), radius: 3, y: 3)
                        .padding(.vertical, 20)

                    Spacer() // Ocupa el espacio restante
                }
                .ignoresSafeArea(edges: .top)
                
                // --- ÁREA DE JUEGO (COMIDA, ARMA, PROYECTIL) ---
                
                // 1. Dibuja los 15 alimentos
                ForEach(alimentosEnPantalla) { alimento in
                    Image(alimento.imagenNombre)
                        .resizable().scaledToFit()
                        .frame(width: 120) // Tamaño unificado
                        .position(alimento.position)
                        .opacity(alimento.isHit ? 0 : 1) // Desaparece si es golpeado
                        .shadow(color: alimento.isAlergenoParaJugador ? .red : .green, radius: 5) // Sombra de color
                        .onTapGesture {
                            // ¡Este es tu "TRIGGER"!
                            if sePuedeDisparar {
                                dispararHacia(alimento: alimento, geometry: geo)
                            }
                        }
                }
                
                // 2. Dibuja el arma
                Image("arma")
                    .resizable().scaledToFit().frame(width: 150)
                    .position(armaPosition)
                
                // 3. Dibuja el proyectil (si existe)
                if let proyectil = proyectil {
                    Image("bolaRoja")
                        .resizable().scaledToFit().frame(width: 60)
                        .position(proyectil.position)
                }
                
                // 4. Dibuja el mensaje de puntos flotante
                if mostrarMensajePuntos {
                    VStack { Text(mensajePuntosTexto) }
                        .font(.system(.title3, weight: .bold))
                        .foregroundColor(Color(red: 255/255, green: 220/255, blue: 0/255))
                        .shadow(color: .black.opacity(0.7), radius: 2, y: 2)
                        .position(x: geo.size.width / 2, y: geo.size.height / 2 + mensajePuntosOffset)
                        .opacity(1.0 - (Double(mensajePuntosOffset) / 50.0))
                }
            }
            .onAppear {
                // Configuración inicial del juego
                self.armaPosition = CGPoint(x: geo.size.width / 2, y: geo.size.height * 0.9)
                generarAlimentos(geometry: geo)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    // --- 3. FUNCIONES DE LÓGICA DEL JUEGO ---
    
    func generarAlimentos(geometry: GeometryProxy) {
        // Llama al repositorio para obtener 15 alimentos
        // usando las alergias del perfil activo
        self.alimentosEnPantalla = alimentoRepo.generarAlimentosParaNivel(
            numAlimentos: 15,
            alergiasJugador: activeProfile.allergies,
            geometry: geometry
        )
    }
    
    func dispararHacia(alimento: Alimento, geometry: GeometryProxy) {
        // 1. Bloquea nuevos disparos
        sePuedeDisparar = false
        
        // 2. Crea el proyectil en la posición del arma
        proyectil = Proyectil(position: self.armaPosition)
        
        // 3. Anima el proyectil
        withAnimation(.linear(duration: 0.4)) {
            proyectil?.position = alimento.position
        }
        
        // 4. Procesa el impacto después de la animación
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            procesarImpacto(alimento: alimento, geometry: geometry)
        }
    }
    
    func procesarImpacto(alimento: Alimento, geometry: GeometryProxy) {
        // 1. Reinicia el proyectil
        self.proyectil = nil
        
        // 2. Marca la comida como "golpeada"
        if let index = alimentosEnPantalla.firstIndex(where: { $0.id == alimento.id }) {
            alimentosEnPantalla[index].isHit = true
        }
        
        // 3. Calcula los puntos
        if alimento.isAlergenoParaJugador {
            // ¡Bien! Le diste a un alérgeno
            puntos += 5
            mostrarMensaje(texto: "+5 Puntos!")
        } else {
            // ¡Mal! Le diste a comida segura
            puntos -= 2
            mostrarMensaje(texto: "-2 Puntos")
        }
        
        // 4. Reemplaza la comida golpeada por una nueva
        // (Para que siempre haya 15 en pantalla)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            alimentosEnPantalla.removeAll { $0.id == alimento.id }
            
            // Genera UNA comida nueva para reemplazarla
            let nuevaComida = alimentoRepo.generarAlimentosParaNivel(
                numAlimentos: 1,
                alergiasJugador: activeProfile.allergies,
                geometry: geometry
            )
            alimentosEnPantalla.append(contentsOf: nuevaComida)
            
            // 5. Permite disparar de nuevo
            sePuedeDisparar = true
        }
    }
    
    func mostrarMensaje(texto: String) {
        mensajePuntosTexto = texto
        mostrarMensajePuntos = true
        mensajePuntosOffset = 0
        
        withAnimation(.easeOut(duration: 1.0)) {
            mensajePuntosOffset = -50
        } completion: {
            mostrarMensajePuntos = false
        }
    }
}

#Preview {
    // El Preview necesita el EnvironmentObject para funcionar
    JuegoView()
        .environmentObject(ActiveProfileManager())
        .modelContainer(for: Profile.self) // Y el contenedor de SwiftData
}
