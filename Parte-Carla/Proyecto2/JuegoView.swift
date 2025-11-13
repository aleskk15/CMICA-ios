import SwiftUI
import SwiftData

// --- GridBackgroundView (No cambia) ---
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
        let activeProfile: Profile
        let nivelNumero: Int
        
        @State private var puntos: Int = 0
        @State private var alimentosEnPantalla: [Alimento] = []
        @State private var proyectil: Proyectil? = nil
        @State private var armaPosition: CGPoint = .zero
        @State private var sePuedeDisparar: Bool = true
        @State private var mostrarMensajePuntos: Bool = false
        @State private var mensajePuntosTexto: String = ""
        @State private var mensajePuntosOffset: CGFloat = 0
        @State private var isGameOver: Bool = false
        @State private var showingWinAlert: Bool = false
        let winScore: Int = 100
        private let alimentoRepo = AlimentoRepository()
        @State private var gameTimer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
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
                        Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.title).fontWeight(.bold).foregroundColor(.white)
                        }
                        Text("Alérgico al: ").font(.title).fontWeight(.bold).foregroundColor(.white)
                        Text(activeProfile.allergies.isEmpty ? "Nada" : activeProfile.allergies.joined(separator: ", "))
                            .font(.title3).fontWeight(.bold).foregroundColor(.white)
                            .lineLimit(1)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15)
                    .background(Color.black.opacity(0.2).edgesIgnoringSafeArea(.horizontal))
                    .padding(.top, 50)

                    Text("\(puntos) puntos")
                        .font(.largeTitle).fontWeight(.bold)
                        .foregroundColor(Color(red: 255/255, green: 220/255, blue: 0/255))
                        .shadow(color: .black.opacity(0.7), radius: 3, y: 3)
                        .padding(.vertical, 20)
                    
                    Spacer()
                }
                .ignoresSafeArea(edges: .top)

                ForEach(alimentosEnPantalla) { alimento in
                    Image(alimento.imagenNombre)
                        .resizable().scaledToFit()
                        .frame(width: 120)
                        .position(alimento.position)
                        .opacity(alimento.isHit ? 0 : 1)
                        .shadow(color: alimento.isAlergenoParaJugador ? .red : .clear, radius: 5, x: 0, y: 3)
                        .onTapGesture {
                            if sePuedeDisparar && !isGameOver { // CAMBIO: No disparar si el juego terminó
                                dispararHacia(alimento: alimento, geometry: geo)
                            }
                        }
                }
                
                Image("arma")
                    .resizable().scaledToFit().frame(width: 150)
                    .position(armaPosition)

                if let proyectil = proyectil {
                    Image("bolaRoja")
                        .resizable().scaledToFit().frame(width: 60)
                        .position(proyectil.position)
                }
                
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
                self.armaPosition = CGPoint(x: geo.size.width / 2, y: geo.size.height * 0.9)
                generarAlimentos(geometry: geo)
            }
            .onReceive(gameTimer) { _ in
                // CAMBIO: Si el juego terminó, el timer deja de mover las cosas
                guard !isGameOver else { return }
                gameTick(geometry: geo)
            }

            //.alert("¡Felicidades!", isPresented: $showingWinAlert) {
                Button("Volver al Menú") {

                    presentationMode.wrappedValue.dismiss()
                }
            }
        //}
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    func gameTick(geometry: GeometryProxy) {
        moverAlimentos(geometry: geometry)
        reemplazarAlimentosPerdidos(geometry: geometry)
    }
    
    func moverAlimentos(geometry: GeometryProxy) {
        for i in alimentosEnPantalla.indices {
            if !alimentosEnPantalla[i].isHit {
                alimentosEnPantalla[i].position.y += alimentosEnPantalla[i].velocidad
            }
        }
    }
    
    func reemplazarAlimentosPerdidos(geometry: GeometryProxy) {
        for i in alimentosEnPantalla.indices {
            guard i < alimentosEnPantalla.count else { continue }
            
            if alimentosEnPantalla[i].position.y > (geometry.size.height + 60) {

                if alimentosEnPantalla[i].isAlergenoParaJugador {
                    puntos -= 5
                    mostrarMensaje(texto: "-5 Puntos")
                    // CAMBIO: Revisar si perdiste
                    checkGameStatus()
                }
                
                if let nuevoAlimento = alimentoRepo.generarUnAlimento(alergiasJugador: activeProfile.allergies, geometry: geometry) {
                    alimentosEnPantalla[i] = nuevoAlimento
                }
            }
        }
    }
    
    func generarAlimentos(geometry: GeometryProxy) {
        self.alimentosEnPantalla = alimentoRepo.generarAlimentosParaNivel(
            numAlimentos: 15,
            alergiasJugador: activeProfile.allergies,
            geometry: geometry
        )
    }
    
    func dispararHacia(alimento: Alimento, geometry: GeometryProxy) {
        sePuedeDisparar = false
        
        proyectil = Proyectil(position: self.armaPosition)
        
        withAnimation(.linear(duration: 0.4)) {
            proyectil?.position = alimento.position
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            procesarImpacto(alimento: alimento, geometry: geometry)
        }
    }
    
    func procesarImpacto(alimento: Alimento, geometry: GeometryProxy) {
        self.proyectil = nil
        
        guard let index = alimentosEnPantalla.firstIndex(where: { $0.id == alimento.id }) else {
            sePuedeDisparar = true
            return
        }
        
        alimentosEnPantalla[index].isHit = true
        
        if alimento.isAlergenoParaJugador {
            puntos += 50
            mostrarMensaje(texto: "+50 Puntos!")
        } else {
            puntos -= 10
            mostrarMensaje(texto: "-10 Puntos")
        }
        
        checkGameStatus()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {

            guard !isGameOver else { return }
            
            if let nuevaComida = alimentoRepo.generarUnAlimento(
                alergiasJugador: activeProfile.allergies,
                geometry: geometry
            ) {
                alimentosEnPantalla[index] = nuevaComida
            }
            
            sePuedeDisparar = true
        }
    }
    
    func checkGameStatus() {
            if puntos >= winScore {
                puntos = winScore
                isGameOver = true
                sePuedeDisparar = false
                gameTimer.upstream.connect().cancel()
                if nivelNumero == activeProfile.highestLevelUnlocked {
                    if nivelNumero < 10 {
                        activeProfile.highestLevelUnlocked += 1
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showingWinAlert = true
                }
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
    let previewProfile = Profile(name: "Preview", imageName: "perfil1", backgroundColorHex: "#FFF", realName: "Preview", age: 8, allergies: ["Maní"])
    
    return JuegoView(activeProfile: previewProfile, nivelNumero: 1)
        .environmentObject(ActiveProfileManager())
        .modelContainer(for: Profile.self)
}
