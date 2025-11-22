import SwiftUI

struct CuentoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let historia: HistoriaData
    
    var body: some View {
        ZStack {
            Color(red: 242/255, green: 242/255, blue: 247/255)
                .edgesIgnoringSafeArea(.all)
            
            TabView {
                ForEach(historia.paginas) { pagina in
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
                                Text(pagina.text)
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
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .ignoresSafeArea(edges: .bottom)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.black.opacity(0.6))
                            .padding()
                            .padding(.top, 30)
                    }
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
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
