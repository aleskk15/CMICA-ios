import SwiftUI

struct TermsAndConditionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Términos y Condiciones")
                    .font(.custom("LilitaOne", size: 30))
                    .padding(.top, 20)
                
                ScrollView {
                    Text("terms_content".traducido(languageManager.currentLanguage))
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.leading)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cerrar")
                        .font(.custom("LilitaOne", size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .padding()
            }
        }
    }
}
