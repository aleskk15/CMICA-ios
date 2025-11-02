import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color(red: 252/255, green: 172/255, blue: 80/255)
                .edgesIgnoringSafeArea(.all)

            FruitOverlayView()
                .allowsHitTesting(false)

            VStack(spacing: 20) {
                
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Niveles")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .opacity(0)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Image("cmicapet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
                    .offset(x: 15)
                
                Button(action: {
                }) {
                    Text("Jugar")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 70)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.2), radius: 5, y: 5)
                }
                
                Button(action: {
                }) {
                    Text("1")
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
                }
                .padding(.top, 10)
                
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
    ContentView()
}
