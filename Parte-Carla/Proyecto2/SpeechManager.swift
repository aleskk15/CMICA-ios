import Foundation
import AVFoundation
import SwiftUI

class SpeechManager: NSObject, ObservableObject {
    // El sintetizador de voz
    private let synthesizer = AVSpeechSynthesizer()
    
    // Publicamos si está hablando para cambiar el icono del botón
    @Published var isSpeaking: Bool = false
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    func hablar(texto: String, idiomaApp: String) {
        // 1. Si ya está hablando, lo callamos (toggle)
        if synthesizer.isSpeaking {
            stop()
            return
        }
        
        // 2. Configuramos lo que va a decir
        let utterance = AVSpeechUtterance(string: texto)
        
        // 3. Configuramos la voz según el idioma de la app
        // "es" -> Español México ("es-MX"), "en" -> Inglés USA ("en-US")
        let voiceCode = (idiomaApp == "es") ? "es-MX" : "en-US"
        
        utterance.voice = AVSpeechSynthesisVoice(language: voiceCode)
        utterance.rate = 0.5 // Velocidad normal (0.0 a 1.0)
        utterance.pitchMultiplier = 1.1 // Un poquito más agudo para que suene amigable (opcional)
        
        // 4. ¡Hablar!
        synthesizer.speak(utterance)
        isSpeaking = true
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
}

// Extensión para saber cuándo termina de hablar y cambiar el icono
extension SpeechManager: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
}
