import SwiftUI

struct NivelesView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
             
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
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
            .padding(.top, 50)
            .padding(.bottom, 10)
            .background(Color(red: 252/255, green: 172/255, blue: 80/255))

            TabView {
                ForEach(1...10, id: \.self) { numero in
                    NivelDetalleView(nivelNumero: numero)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .background(Color(red: 252/255, green: 172/255, blue: 80/255).edgesIgnoringSafeArea(.all))
        .toolbar(.hidden, for: .navigationBar) 
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NivelesView()
}
