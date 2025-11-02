//
//  NivelDetalleView.swift
//

import SwiftUI

struct NivelDetalleView: View {
    
    let nivelNumero: Int
    
    var body: some View {
        // ZStack con el fondo naranja y las frutas
        ZStack {
            Color(red: 252/255, green: 172/255, blue: 80/255)
                .edgesIgnoringSafeArea(.all)
            
            FruitOverlayView() // Las frutas de fondo
                .allowsHitTesting(false)
            
            // VStack solo con el contenido del nivel
            VStack(spacing: 20) {
                
                Spacer() // Espacio para que baje el contenido
                
                Image("cmicapet") // El nombre de tu mascota
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .offset(x: 15)
                
                // Link para ir al juego
                NavigationLink(destination: JuegoView()) {
                    Text("Jugar")
                        .font(.title2).fontWeight(.bold).foregroundColor(.black)
                        .padding(.vertical, 15).padding(.horizontal, 70)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                }
                
                // El número del nivel
                Text("\(nivelNumero)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                    .background(
                        Circle()
                            .fill(Color(red: 66/255, green: 211/255, blue: 197/255))
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 4)
                            )
                    )
                    .padding(.top, 10)
                
                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

// (La vista de las frutas debe estar aquí abajo)
struct FruitOverlayView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("frutas")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.35)
                    .position(x: geo.size.width * 0.15, y: geo.size.height / 2)
                Image("futasizq")
                    .resizable()
                    .frame(width: geo.size.width * 0.35)
                    .position(x: geo.size.width * 0.85, y: geo.size.height / 2)
            }
        }
    }
}

#Preview {
    NivelDetalleView(nivelNumero: 1)
}
