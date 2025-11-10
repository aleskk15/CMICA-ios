import SwiftUI

// --- Vista auxiliar para dibujar la cuadrícula ---
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
    // --- 1. AÑADE ESTA LÍNEA ---
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var puntos: Int = 2051
    @State private var alergicoA: String = "Maní"
    @State private var mostrarMensajePuntos: Bool = false
    @State private var mensajePuntosOffset: CGFloat = 0

    var body: some View {
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
                    Text(alergicoA).font(.title).fontWeight(.bold).foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 15)
                .background(
                    Color.black.opacity(0.2)
                        .edgesIgnoringSafeArea(.horizontal)
                )
                .padding(.top, 50)

                Text("\(puntos) puntos")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 255/255, green: 220/255, blue: 0/255))
                    .shadow(color: .black.opacity(0.7), radius: 3, y: 3)
                    .padding(.vertical, 20)

                GeometryReader { geo in
                    ZStack {
                        Image("manzana")
                            .resizable().scaledToFit().frame(width: 150)
                            .position(x: geo.size.width * 0.2, y: geo.size.height * 0.15)
                        
                        Image("mazapan")
                            .resizable().scaledToFit().frame(width: 120)
                            .position(x: geo.size.width * 0.15, y: geo.size.height * 0.68)
                        
                        Image("bolaRoja")
                            .resizable().scaledToFit().frame(width: 60)
                            .position(x: geo.size.width * 0.5, y: geo.size.height * 0.4)
                        
                        Image("Pizza")
                            .resizable().scaledToFit().frame(width: 150)
                            .position(x: geo.size.width * 0.80, y: geo.size.height * 0.4)
                        
                        if mostrarMensajePuntos {
                            VStack { Text("+5 puntos") }
                                .font(.system(.title3, weight: .bold))
                                .foregroundColor(Color(red: 255/255, green: 220/255, blue: 0/255))
                                .shadow(color: .black.opacity(0.7), radius: 2, y: 2)
                                .position(x: geo.size.width * 0.25, y: geo.size.height * 0.6 + mensajePuntosOffset)
                                .opacity(1.0 - (Double(mensajePuntosOffset) / 50.0))
                                .onAppear {
                                    withAnimation(.easeOut(duration: 1.0)) {
                                        mensajePuntosOffset = -50
                                    } completion: {
                                        mostrarMensajePuntos = false
                                        mensajePuntosOffset = 0
                                    }
                                }
                        }
                        
                        Image("arma")
                            .resizable().scaledToFit().frame(width: 150)
                            .position(x: geo.size.width / 2, y: geo.size.height * 0.9)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    JuegoView()
}
