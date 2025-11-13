//
//  GameData.swift
//  Proyecto2
//
//  Created by Alumno on 11/11/25.
//
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
    var velocidad: CGFloat = 2.0 // <-- ¡AÑADIMOS ESTO DE VUELTA!
}

class AlimentoRepository {
    private let todosLosAlimentos: [Alimento] = [
        // ... (Aquí va toda tu lista de alimentos, no la borres) ...
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
    
    func generarAlimentosParaNivel(numAlimentos: Int, alergiasJugador: [String], geometry: GeometryProxy) -> [Alimento] {
        
        var alimentosDelNivel: [Alimento] = []
        let areaJuego = geometry.size
        
        for _ in 0..<numAlimentos {
            guard var nuevoAlimento = todosLosAlimentos.randomElement() else { continue }
            
            nuevoAlimento.isAlergenoParaJugador = nuevoAlimento.alergenos.contains { alergeno in
                alergiasJugador.contains(alergeno.rawValue)
            }
            
            nuevoAlimento.position = CGPoint(
                x: CGFloat.random(in: 50...(areaJuego.width - 50)),
                y: CGFloat.random(in: -areaJuego.height...(-50))
            )
            
            nuevoAlimento.velocidad = CGFloat.random(in: 1.0...2.5)
            
            alimentosDelNivel.append(nuevoAlimento)
        }
        
        return alimentosDelNivel
    }
    
    func generarUnAlimento(alergiasJugador: [String], geometry: GeometryProxy) -> Alimento? {
        guard var nuevoAlimento = todosLosAlimentos.randomElement() else { return nil }
        
        let areaJuego = geometry.size
        
        nuevoAlimento.isAlergenoParaJugador = nuevoAlimento.alergenos.contains { alergeno in
            alergiasJugador.contains(alergeno.rawValue)
        }
        
        nuevoAlimento.position = CGPoint(
            x: CGFloat.random(in: 50...(areaJuego.width - 50)),
            y: -50 
        )
        
        nuevoAlimento.velocidad = CGFloat.random(in: 1.0...2.5)
        
        return nuevoAlimento
    }
}

struct Proyectil: Identifiable {
    let id = UUID()
    var position: CGPoint
}
