import Foundation
import SwiftUI // Importar SwiftUI para usar LocalizedStringKey

struct StoryPage: Identifiable {
    let id = UUID()
    let imageName: String
    let textKey: String // CAMBIO: Ahora guardamos la CLAVE, no el texto final
}

struct HistoriaData: Identifiable {
    let id = UUID()
    let tituloKey: String // CAMBIO: Clave del título
    let portada: String
    let paginas: [StoryPage]
}

class StoryRepository {
    static let historias: [HistoriaData] = [
        // HISTORIA 1: UN DÍA NORMAL
        HistoriaData(
            tituloKey: "story1_title",
            portada: "nina",
            paginas: [
                StoryPage(imageName: "Spag1", textKey: "story1_p1"),
                StoryPage(imageName: "Spag2", textKey: "story1_p2"),
                StoryPage(imageName: "Spag3", textKey: "story1_p3"),
                StoryPage(imageName: "Spag4", textKey: "story1_p4"),
                StoryPage(imageName: "Spag5", textKey: "story1_p5"),
                StoryPage(imageName: "Spag6", textKey: "story1_p6"),
                StoryPage(imageName: "Spag7", textKey: "story1_p7"),
                StoryPage(imageName: "Spag8", textKey: "story1_p8"),
                StoryPage(imageName: "Spag9", textKey: "story1_p9"),
                StoryPage(imageName: "Spag10", textKey: "story1_p10"),
                StoryPage(imageName: "Spag11", textKey: "story1_p11"),
                StoryPage(imageName: "Spag12", textKey: "story1_p12"),
                StoryPage(imageName: "Spag13", textKey: "story1_p13"),
                StoryPage(imageName: "Spag14", textKey: "story1_p14"),
                StoryPage(imageName: "Spag15", textKey: "story1_p15")
            ]
        ),
        
        // HISTORIA 2: LULI
        HistoriaData(
            tituloKey: "story2_title",
            portada: "luli",
            paginas: [
                StoryPage(imageName: "Tpag1", textKey: "story2_p1"),
                StoryPage(imageName: "Tpag2", textKey: "story2_p2"),
                StoryPage(imageName: "Tpag3", textKey: "story2_p3"),
                StoryPage(imageName: "Tpag4", textKey: "story2_p4"),
                StoryPage(imageName: "Tpag5", textKey: "story2_p5"),
                StoryPage(imageName: "Tpag6", textKey: "story2_p6"),
                StoryPage(imageName: "Tpag7", textKey: "story2_p7"),
                StoryPage(imageName: "Tpag8", textKey: "story2_p8"),
                StoryPage(imageName: "Tpag9", textKey: "story2_p9"),
                StoryPage(imageName: "Tpag10", textKey: "story2_p10"),
                StoryPage(imageName: "Tpag11", textKey: "story2_p11")
            ]
        ),
        
        // HISTORIA 3: COPITO
        HistoriaData(
            tituloKey: "story3_title",
            portada: "Copito",
            paginas: [
                StoryPage(imageName: "Cpag1", textKey: "story3_p1"),
                StoryPage(imageName: "Cpag2", textKey: "story3_p2"),
                StoryPage(imageName: "Cpag3", textKey: "story3_p3"),
                StoryPage(imageName: "Cpag4", textKey: "story3_p4"),
                StoryPage(imageName: "Cpag5", textKey: "story3_p5"),
                StoryPage(imageName: "Cpag6", textKey: "story3_p6"),
                StoryPage(imageName: "Cpag7", textKey: "story3_p7"),
                StoryPage(imageName: "Cpag8", textKey: "story3_p8"),
                StoryPage(imageName: "Cpag9", textKey: "story3_p9"),
                StoryPage(imageName: "Cpag10", textKey: "story3_p10"),
                StoryPage(imageName: "Cpag11", textKey: "story3_p11"),
                StoryPage(imageName: "Cpag12", textKey: "story3_p12"),
                StoryPage(imageName: "Cpag13", textKey: "story3_p13"),
                StoryPage(imageName: "Cpag14", textKey: "story3_p14"),
                StoryPage(imageName: "Cpag15", textKey: "story3_p15"),
                StoryPage(imageName: "Cpag16", textKey: "story3_p16"),
                StoryPage(imageName: "Cpag17", textKey: "story3_p17"),
                StoryPage(imageName: "Cpag18", textKey: "story3_p18")
            ]
        ),
        
        // HISTORIA 4: PIKO
        HistoriaData(
            tituloKey: "story4_title",
            portada: "Ppag0",
            paginas: [
                StoryPage(imageName: "Ppag1", textKey: "story4_p1"),
                StoryPage(imageName: "Ppag2", textKey: "story4_p2"),
                StoryPage(imageName: "Ppag3", textKey: "story4_p3"),
                StoryPage(imageName: "Ppag4", textKey: "story4_p4"),
                StoryPage(imageName: "Ppag5", textKey: "story4_p5"),
                StoryPage(imageName: "Ppag6", textKey: "story4_p6"),
                StoryPage(imageName: "Ppag7", textKey: "story4_p7"),
                StoryPage(imageName: "Ppag8", textKey: "story4_p8"),
                StoryPage(imageName: "Ppag9", textKey: "story4_p9"),
                StoryPage(imageName: "Ppag10", textKey: "story4_p10"),
                StoryPage(imageName: "Ppag11", textKey: "story4_p11")
            ]
        ),
        
        // HISTORIA 5: JUGANDO EN EL PARQUE
        HistoriaData(
            tituloKey: "story5_title",
            portada: "Apag0",
            paginas: [
                StoryPage(imageName: "Apag1", textKey: "story5_p1"),
                StoryPage(imageName: "Apag2", textKey: "story5_p2"),
                StoryPage(imageName: "Apag3", textKey: "story5_p3"),
                StoryPage(imageName: "Apag4", textKey: "story5_p4"),
                StoryPage(imageName: "Apag5", textKey: "story5_p5"),
                StoryPage(imageName: "Apag6", textKey: "story5_p6"),
                StoryPage(imageName: "Apag7", textKey: "story5_p7"),
                StoryPage(imageName: "Apag8", textKey: "story5_p8"),
                StoryPage(imageName: "Apag9", textKey: "story5_p9"),
                StoryPage(imageName: "Apag10", textKey: "story5_p10")
            ]
        )
    ]
}
