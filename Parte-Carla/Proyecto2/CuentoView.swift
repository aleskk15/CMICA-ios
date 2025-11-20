//
//  CuentoView.swift
//  Proyecto2
//
//  Created by Alumno on 19/11/25.
//

import SwiftUI

struct CuentoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let historia: HistoriaData
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            TabView {
                ForEach(historia.paginas, id: \.self) { nombreImagen in
                    Image(nombreImagen)
                        .resizable()
                        .scaledToFit()
                        .tag(nombreImagen)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.8))
                            .padding()
                    }
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let historiaPrueba = HistoriaData(
        titulo: "Prueba",
        portada: "perfil1",
        paginas: ["perfil1", "perfil2", "perfil3"] 
    )
    return CuentoView(historia: historiaPrueba)
}
