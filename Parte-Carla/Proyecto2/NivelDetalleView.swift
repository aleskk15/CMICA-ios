//
//  NivelDetalleView.swift
//

import SwiftUI

struct NivelDetalleView: View {
    
    let nivelNumero: Int
    
    let activeProfile: Profile
    
    var isLocked: Bool {
        nivelNumero > activeProfile.highestLevelUnlocked
    }
    
    var body: some View {
        ZStack {
            Color(red: 252/255, green: 172/255, blue: 80/255)
                .edgesIgnoringSafeArea(.all)
            
            FruitOverlayView()
                .allowsHitTesting(false)
            
            VStack(spacing: 20) {
                
                Spacer()
                
                Image("cmicapet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .offset(x: 15)
                
                NavigationLink(destination: JuegoView(activeProfile: activeProfile, nivelNumero: nivelNumero)) {
                    Text("Jugar")
                        .font(.title2).fontWeight(.bold).foregroundColor(.black)
                        .padding(.vertical, 15).padding(.horizontal, 70)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                }
                .disabled(isLocked)
                .grayscale(isLocked ? 1.0 : 0)
                ZStack {
                    Circle()
                        .fill(Color(red: 66/255, green: 211/255, blue: 197/255))
                        .overlay(
                            Circle().stroke(Color.black, lineWidth: 4)
                        )
                        .grayscale(isLocked ? 1.0 : 0)
                    if isLocked {
                        Image(systemName: "lock.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    } else {
                        Text("\(nivelNumero)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 70, height: 70)
                .padding(.top, 10)

                Spacer()
                Spacer()
            }
            .padding()
        }
    }
}

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
    let previewProfile = Profile(name: "Preview", imageName: "perfil1", backgroundColorHex: "#FFF", realName: "Preview", age: 8, allergies: [], highestLevelUnlocked: 2)
    
    return NivelDetalleView(nivelNumero: 3, activeProfile: previewProfile)
}
