import SwiftUI

struct HistoriaView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let colorFondo = Color(red: 90/255, green: 84/255, blue: 137/255)
    let colorBarras = Color(red: 111/255, green: 105/255, blue: 156/255)

    var body: some View {
        ZStack {
            colorFondo
                .edgesIgnoringSafeArea(.all)
            
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
                    
                    Text("Contar una historia")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.bold)
                        .opacity(0)
                }
                .padding()
                .padding(.top, 40)

                Text("Un día normal")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(colorBarras)
                
                Image("niña")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 40)
                    .offset(x: 10)
                Spacer()

                Button(action: {

                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(25)
                        .background(Color.black)
                        .clipShape(Circle())
                }
                .padding(.bottom, 50)
            }
            .ignoresSafeArea(edges: .top)
            
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    HistoriaView()
}
