
import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode

    let backgroundColor = Color(red: 241/255.0, green: 183/255.0, blue: 103/255.0)
    let darkBlueColor = Color(red: 1/255.0, green: 57/255.0, blue: 96/255.0)
    let lightBlueColor = Color(red: 58/255.0, green: 101/255.0, blue: 132/255.0)
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                ScrollView {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        Text("CMICA")
                            .font(.custom("LilitaOne", size:50))
                            .foregroundColor(darkBlueColor)
                            .offset(x: -15)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 20) {
                        
                        Text("Colegio Mexicano de\n Inmunología Clínica y Alergia A.C.")
                            .font(.custom("LilitaOne",size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(lightBlueColor)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Image("logo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .padding(.vertical, 10)
                        
                        Text(LocalizedStringKey("cmica_description"))
                            .font(.custom("LilitaOne", size: 23))
                            //.fontWeight(.bold)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                    }
                    .padding(.bottom, 50)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    InfoView()
}
