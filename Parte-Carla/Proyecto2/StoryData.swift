//
//  StoryData.swift
//  Proyecto2
//
//  Created by Alumno on 19/11/25.
//
import Foundation

struct HistoriaData: Identifiable {
    let id = UUID()
    let titulo: String
    let portada: String
    let paginas: [String]
}

class StoryRepository {
    static let historias: [HistoriaData] = [
        HistoriaData(
            titulo: "Un día normal",
            portada: "niña",
            paginas: [
                "pag1",
                "pag2",
                "pag3",
                "pag4",
                "pag5",
                "pag6"
            ]
        ),
        HistoriaData(
                    titulo: "Luli la tortuga",
                    portada: "perfil1",
                    paginas: ["perfil1", "perfil2"]
                ),
                
                // HISTORIA 3
                HistoriaData(
                    titulo: "Jugando en el parque",
                    portada: "perfil2",
                    paginas: ["perfil3", "perfil4"] 
                )
    ]
}


