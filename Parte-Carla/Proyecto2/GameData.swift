import Foundation
import SwiftUI

enum Alergeno: String {
    case mani = "Maní"
    case huevo = "Huevo"
    case lacteos = "Lácteos"
    case trigo = "Trigo"
    case soya = "Soya"
    case pescado = "Pescado"
    case mariscos = "Mariscos"
    case nueces = "Nueces"
    case polen = "Polen"
    case polvo = "Polvo"
    case penicilina = "Penicilina"
    case latex = "Látex"
}

struct Alimento: Identifiable, Equatable {
    let id = UUID()
    let nombre: String
    let imagenNombre: String
    let alergenos: [Alergeno]
    
    var position: CGPoint = .zero
    var isAlergenoParaJugador: Bool = false
    var isHit: Bool = false
    
}

struct Proyectil: Identifiable {
    let id = UUID()
    var position: CGPoint
}


class AlimentoRepository {
    
    private let todosLosAlimentos: [Alimento] = [
        Alimento(nombre: "Manzana", imagenNombre: "manzana", alergenos: []),
        Alimento(nombre: "Mazapán", imagenNombre: "mazapan", alergenos: [.mani]),
        Alimento(nombre: "Cacahuate", imagenNombre: "cacahuate", alergenos: [.mani]),
        Alimento(nombre: "cremaCacahuate", imagenNombre: "cremaCacahuate", alergenos: [.mani]),
        Alimento(nombre: "Pizza", imagenNombre: "Pizza", alergenos: [.trigo, .lacteos]),
        Alimento(nombre: "spaguetti", imagenNombre: "spaguetti", alergenos: [.trigo, .lacteos]),
        Alimento(nombre: "Huevo", imagenNombre: "huevo", alergenos: [.huevo]),
        Alimento(nombre: "huevo_frito", imagenNombre: "huevo_frito", alergenos: [.huevo]),
        Alimento(nombre: "omelette", imagenNombre: "omelette", alergenos: [.huevo]),
        Alimento(nombre: "Pan", imagenNombre: "pan", alergenos: [.trigo, .lacteos]),
        Alimento(nombre: "Galleta", imagenNombre: "galleta", alergenos: [.trigo, .lacteos]),
        Alimento(nombre: "Leche", imagenNombre: "leche", alergenos: [.lacteos]),
        Alimento(nombre: "queso", imagenNombre: "queso", alergenos: [.lacteos]),
        Alimento(nombre: "yogurt", imagenNombre: "yogurt", alergenos: [.lacteos]),
        Alimento(nombre: "mantequilla", imagenNombre: "mantequilla", alergenos: [.lacteos]),
        Alimento(nombre: "Camarón", imagenNombre: "camaron", alergenos: [.mariscos]),
        Alimento(nombre: "Langosta", imagenNombre: "langosta", alergenos: [.mariscos]),
        Alimento(nombre: "Ostiones", imagenNombre: "ostiones", alergenos: [.mariscos]),
        Alimento(nombre: "Mejillones", imagenNombre: "mejillones", alergenos: [.mariscos]),
        Alimento(nombre: "Salmon", imagenNombre: "salmon", alergenos: [.pescado]),
        Alimento(nombre: "Trucha", imagenNombre: "trucha", alergenos: [.pescado]),
        Alimento(nombre: "Bacalao", imagenNombre: "bacalao", alergenos: [.pescado]),
        Alimento(nombre: "Atun", imagenNombre: "atun", alergenos: [.pescado]),
        Alimento(nombre: "Nuez", imagenNombre: "nuez", alergenos: [.nueces]),
        Alimento(nombre: "pistache", imagenNombre: "pistache", alergenos: [.nueces]),
        Alimento(nombre: "almendras", imagenNombre: "almendras", alergenos: [.nueces]),
        Alimento(nombre: "Crema_Avellanas", imagenNombre: "Crema_Avellanas", alergenos: [.nueces]),
        Alimento(nombre: "Brócoli", imagenNombre: "brocoli", alergenos: []) ,
        Alimento(nombre: "Edamame", imagenNombre: "edamame", alergenos: [.soya]),
        Alimento(nombre: "Tofu", imagenNombre: "tofu", alergenos: [.soya]),
        Alimento(nombre: "leche_soya", imagenNombre: "leche_soya", alergenos: [.soya]),
        Alimento(nombre: "salsa-soya", imagenNombre: "salsa-soya", alergenos: [.soya]),
    ]
    
    

    
    func generarSetDeAlimentos(alergiasJugador: [String], gameSize: CGSize) -> [Alimento] {
        var setDeAlimentos: [Alimento] = []
        
        var alimentosProcesados: [Alimento] = todosLosAlimentos.map { alimentoBase in
            var nuevoAlimento = alimentoBase
            nuevoAlimento.isAlergenoParaJugador = nuevoAlimento.alergenos.contains { alergeno in
                alergiasJugador.contains(alergeno.rawValue)
            }
            return nuevoAlimento
        }
        
        let alergenos = alimentosProcesados.filter { $0.isAlergenoParaJugador }
        let seguros = alimentosProcesados.filter { !$0.isAlergenoParaJugador }
        
        if let alergenoParaRonda = alergenos.randomElement() {
            setDeAlimentos.append(alergenoParaRonda)
        } else {
            if let seguroExtra = seguros.randomElement() {
                setDeAlimentos.append(seguroExtra)
            }
        }
        
        for _ in 0..<2 {
            if let seguroParaRonda = seguros.randomElement() {
                if !setDeAlimentos.contains(where: { $0.id == seguroParaRonda.id }) {
                    setDeAlimentos.append(seguroParaRonda)
                }
            }
        }
        
        let areaJuego = gameSize
        
        let laneWidth = areaJuego.width / 3
        let lanePadding: CGFloat = 50
        
        var xPositions: [CGFloat] = [
            CGFloat.random(in: (laneWidth * 0 + lanePadding)...(laneWidth * 1 - lanePadding)),
            CGFloat.random(in: (laneWidth * 1 + lanePadding)...(laneWidth * 2 - lanePadding)),
            CGFloat.random(in: (laneWidth * 2 + lanePadding)...(laneWidth * 3 - lanePadding)),
        ]
        
        let ySpawnStart = areaJuego.height * 0.30
        let ySpawnEnd = areaJuego.height * 0.65
        let ySpawnHeight = ySpawnEnd - ySpawnStart
        let yLaneHeight = ySpawnHeight / 3
        
        var yPositions: [CGFloat] = [
            CGFloat.random(in: (ySpawnStart)...(ySpawnStart + yLaneHeight)),
            CGFloat.random(in: (ySpawnStart + yLaneHeight)...(ySpawnStart + yLaneHeight * 2)),
            CGFloat.random(in: (ySpawnStart + yLaneHeight * 2)...(ySpawnStart + yLaneHeight * 3))
        ]
        
        xPositions.shuffle()
        yPositions.shuffle()
        
        for i in setDeAlimentos.indices {
            guard i < xPositions.count && i < yPositions.count else { continue }
            
            setDeAlimentos[i].position = CGPoint(
                x: xPositions[i],
                y: yPositions[i]
            )
        }
        
        return setDeAlimentos
    }
}
