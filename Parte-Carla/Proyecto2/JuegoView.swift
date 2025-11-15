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
    let nivelNumero: Int
    @EnvironmentObject var activeProfileManager: ActiveProfileManager
    @Query var profiles: [Profile]
    var activeProfile: Profile {
        if let activeID = activeProfileManager.activeProfileID,
           let profile = profiles.first(where: { $0.id == activeID }) {
            return profile
        } else if let firstProfile = profiles.first {
            return firstProfile
        } else {
            return Profile(name: "Error", imageName: "perfil1", backgroundColorHex: "#FF0000", realName: "Error", age: nil, allergies: ["Maní"])
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
    @State private var gameAreaSize: CGSize = .zero
    
    @State private var roundTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var roundTimeRemaining: Int = 2
    
    var targetPuntos: Int {
            let basePuntos = 50
            let incrementoPorNivel = 30
            return basePuntos + (incrementoPorNivel * (nivelNumero - 1))
        }
    
    let loseThreshold: Int = -15
    
    @State private var isGameFinished: Bool = false
    

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(red: 45/255, green: 71/255, blue: 118/255).edgesIgnoringSafeArea(.all)
                GridBackgroundView().edgesIgnoringSafeArea(.all)
                Image("blobRosa").resizable().scaledToFit().frame(width: 500, height: 500).position(x: 100, y: 300).blendMode(.screen)
                Image("blobAzul").resizable().scaledToFit().frame(width: 300, height: 300).position(x: 300, y: 00).blendMode(.screen)
                Image("blobVerde").resizable().scaledToFit().frame(width: 250, height: 250).position(x: 390, y: 700).blendMode(.screen)

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
                        .padding(.vertical, 10)
                    
                    
                    Text("Meta: \(targetPuntos)")
                        .font(.title2).fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.8))
                        .shadow(color: .black.opacity(0.5), radius: 2, y: 2)
                        .padding(.bottom, 10)
                    
                    
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
                            if sePuedeDisparar {
                                dispararHacia(alimento: alimento)
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
                self.gameAreaSize = geo.size
                self.armaPosition = CGPoint(x: geo.size.width / 2, y: geo.size.height * 0.9)
                iniciarNuevaRonda()
            }
            .onReceive(roundTimer) { _ in
                manejarTickDelRound()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    func iniciarNuevaRonda() {
        self.alimentosEnPantalla = alimentoRepo.generarSetDeAlimentos(
            alergiasJugador: activeProfile.allergies,
            gameSize: self.gameAreaSize
        )
        self.roundTimeRemaining = 2
        self.sePuedeDisparar = true
    }
    
    func manejarTickDelRound() {
        guard sePuedeDisparar else { return }
        
        if roundTimeRemaining > 0 {
            roundTimeRemaining -= 1
        }
        
        if roundTimeRemaining == 0 {
            sePuedeDisparar = false
            puntos -= 5
            mostrarMensaje(texto: "¡Muy lento! -5 Puntos")
            
            checkGameState()
            
            if !isGameFinished {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    iniciarNuevaRonda()
                }
            }
        }
    }
    
    func dispararHacia(alimento: Alimento) {
        sePuedeDisparar = false
        
        proyectil = Proyectil(position: self.armaPosition)
        
        withAnimation(.linear(duration: 0.4)) {
            proyectil?.position = alimento.position
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            procesarImpacto(alimento: alimento)
        }
    }
    
    func procesarImpacto(alimento: Alimento) {
        self.proyectil = nil
        
        guard let index = alimentosEnPantalla.firstIndex(where: { $0.id == alimento.id }) else {
            if !isGameFinished { iniciarNuevaRonda() }
            return
        }
        
        alimentosEnPantalla[index].isHit = true
        
        if alimento.isAlergenoParaJugador {
            puntos += 5
            mostrarMensaje(texto: "+5 Puntos!")
        } else {
            puntos -= 2
            mostrarMensaje(texto: "-2 Puntos")
        }
        
        checkGameState()

        if !isGameFinished {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                iniciarNuevaRonda()
            }
        }
    }
    
    func mostrarMensaje(texto: String) {
        // ...
    }
    func checkGameState() {
        guard !isGameFinished else { return }

        if puntos >= targetPuntos {
            isGameFinished = true
            handleGameEnd(didWin: true)
            
        } else if puntos <= loseThreshold {
            isGameFinished = true
            handleGameEnd(didWin: false)
        }
    }
    
    func handleGameEnd(didWin: Bool) {
        sePuedeDisparar = false
        roundTimer.upstream.connect().cancel()

        if didWin {
            mostrarMensaje(texto: "¡Nivel Completado!")
            
            if nivelNumero == activeProfile.highestLevelUnlocked {
                activeProfile.highestLevelUnlocked += 1
            }
        } else {
            mostrarMensaje(texto: "¡Inténtalo de nuevo!")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    JuegoView(nivelNumero: 1)
        .environmentObject(ActiveProfileManager())
        .modelContainer(for: Profile.self)
}
