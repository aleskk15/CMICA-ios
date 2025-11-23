import Foundation
import SwiftUI

enum Alergeno: String {
    case proteinasLecheVaca = "Proteínas de leche de vaca"
    case huevo = "Huevo"
    case manzana = "Manzana"
    case pera = "Pera"
    case kiwi = "Kiwi"
    case mango = "Mango"
    case durazno = "Durazno"
    case platano = "Plátano"
    case sandia = "Sandía"
    case papaya = "Papaya"
    case uva = "Uva"
    case naranja = "Naranja"
    case mandarina = "Mandarina"
    case higo = "Higo"
    case cereza = "Cereza"
    case ciruela = "Ciruela"
    case fresa = "Fresa"
    case melon = "Melón"
    case guayaba = "Guayaba"
    case coco = "Coco"
    case zanahoria = "Zanahoria"
    case apio = "Apio"
    case calabaza = "Calabaza"
    case calabacita = "Calabacita"
    case pepino = "Pepino"
    case aguacate = "Aguacate"
    case brocoli = "Brocoli"
    case coliflor = "Coliflor"
    case betabel = "Betabel"
    case cebolla = "Cebolla"
    case ajo = "Ajo"
    case esparrago = "Esparrago"
    case jitomate = "Jitomate"
    case tomateVerde = "Tomate verde"
    case trigo = "Trigo"
    case maiz = "Maíz"
    case cebada = "Cebada"
    case centeno = "Centeno"
    case arroz = "Arroz"
    case avena = "Avena"
    case soya = "Soya"
    case garbanzo = "Garbanzo"
    case frijol = "Frijol"
    case lenteja = "Lenteja"
    case ejote = "Ejote"
    case alubia = "Alubia"
    case haba = "Haba"
    case avellana = "Avellana"
    case almendra = "Almendra"
    case pistache = "Pistache"
    case nuezDeLaIndia = "Nuez de la india"
    case nuez = "Nuez"
    case castana = "Castaña"
    case pinon = "Piñon"
    case cacahuate = "Cacahuate"
    case pescado = "Pescado"
    case crustaceos = "Crustáceos"
    case cefalopodos = "Cefalópodos"
    case deConchaBivalvos = "De concha (Bivalvos)"
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
        Alimento(nombre: "hummus", imagenNombre: "hummus", alergenos: [.ajo, .garbanzo]),
        Alimento(nombre: "pescado_ajo", imagenNombre: "pescado_ajo", alergenos: [.ajo, .pescado]),
        Alimento(nombre: "carne_ajo_mantequilla", imagenNombre: "carne_ajo_mantequilla", alergenos: [.ajo, .proteinasLecheVaca]),
        Alimento(nombre: "pan_ajo", imagenNombre: "pan_ajo", alergenos: [.ajo, .trigo, .huevo, .proteinasLecheVaca]),
        Alimento(nombre: "ajo", imagenNombre: "ajo", alergenos: [.ajo]),
        
        Alimento(nombre: "bivalvos", imagenNombre: "bivalvos", alergenos: [.deConchaBivalvos]),        
        Alimento(nombre: "bivalvos2", imagenNombre: "bivalvos2", alergenos: [.deConchaBivalvos]),
        Alimento(nombre: "bivalvos3", imagenNombre: "bivalvos3", alergenos: [.deConchaBivalvos]),
        Alimento(nombre: "bivalvos4", imagenNombre: "bivalvos4", alergenos: [.deConchaBivalvos]),
        
        Alimento(nombre: "calamar", imagenNombre: "calamar", alergenos: [.cefalopodos, .jitomate]),
        Alimento(nombre: "pulpo", imagenNombre: "pulpo", alergenos: [.cefalopodos, .jitomate]),
        Alimento(nombre: "cefalopodos", imagenNombre: "cefalopodos", alergenos: [.cefalopodos]),
        Alimento(nombre: "cefalopodos2", imagenNombre: "cefalopodos2", alergenos: [.cefalopodos]),
        
        Alimento(nombre: "camarones", imagenNombre: "camarones", alergenos: [.crustaceos]),
        Alimento(nombre: "cangrejos", imagenNombre: "cangrejos", alergenos: [.crustaceos]),
        Alimento(nombre: "crustaceos", imagenNombre: "crustaceos", alergenos: [.crustaceos]),
        Alimento(nombre: "coctel", imagenNombre: "coctel", alergenos: [.crustaceos, .jitomate, .cebolla, .aguacate]),
        
        Alimento(nombre: "salmon", imagenNombre: "salmon", alergenos: [.pescado]),
        Alimento(nombre: "sushi", imagenNombre: "sushi", alergenos: [.pescado, .arroz]),
        Alimento(nombre: "pescado", imagenNombre: "pescado", alergenos: [.pescado]),
        
        
        Alimento(nombre: "cacahuate", imagenNombre: "cacahuate", alergenos: [.cacahuate]),
        Alimento(nombre: "cacahuates2", imagenNombre: "cacahuates2", alergenos: [.cacahuate]),
        Alimento(nombre: "crema_cacahuate", imagenNombre: "crema_cacahuate", alergenos: [.cacahuate]),
        Alimento(nombre: "cacahuates_chile", imagenNombre: "cacahuates_chile", alergenos: [.cacahuate]),
        
        Alimento(nombre: "castana", imagenNombre: "castana", alergenos: [.castana]),
        Alimento(nombre: "castana2", imagenNombre: "castana2", alergenos: [.castana]),
        Alimento(nombre: "castana_asada", imagenNombre: "castana_asada", alergenos: [.castana]),
        
        Alimento(nombre: "pinon", imagenNombre: "piñon", alergenos: [.pinon]),
        Alimento(nombre: "cerdo_ciruela_pinon", imagenNombre: "cerdo_ciruela_piñon", alergenos: [.pinon]),
        Alimento(nombre: "piñon2", imagenNombre: "piñon2", alergenos: [.pinon]),
        Alimento(nombre: "pollo_almendras_piñon_brocoli_ejote", imagenNombre: "pollo_almendras_piñon_brocoli_ejote", alergenos: [.pinon, .almendra, .brocoli]),
        
        Alimento(nombre: "nuez", imagenNombre: "nuez", alergenos: [.nuez]),
        Alimento(nombre: "nueces2", imagenNombre: "nueces2", alergenos: [.nuez]),
        Alimento(nombre: "galleta_nuez", imagenNombre: "galleta_nuez", alergenos: [.nuez, .trigo, .huevo, .proteinasLecheVaca]),
        Alimento(nombre: "ensalada_manzana_nuez_leche", imagenNombre: "ensalada_manzana_nuez_leche", alergenos: [.nuez, .manzana, .proteinasLecheVaca]),
        
        Alimento(nombre: "nuez_india", imagenNombre: "nuez_india", alergenos: [.nuezDeLaIndia]),
        Alimento(nombre: "nueces_india2", imagenNombre: "nueces_india2", alergenos: [.nuezDeLaIndia]),
        Alimento(nombre: "nueces_india3", imagenNombre: "nueces_india3", alergenos: [.nuezDeLaIndia]),
        Alimento(nombre: "nueces_india4", imagenNombre: "nueces_india4", alergenos: [.nuezDeLaIndia]),
        
        Alimento(nombre: "pistache", imagenNombre: "pistache", alergenos: [.pistache]),
        Alimento(nombre: "pistache2", imagenNombre: "pistache2", alergenos: [.pistache]),
        Alimento(nombre: "pistache3", imagenNombre: "pistache3", alergenos: [.pistache]),
        Alimento(nombre: "helado_pistache", imagenNombre: "helado_pistache", alergenos: [.pistache, .proteinasLecheVaca]),
        
        Alimento(nombre: "almendra", imagenNombre: "almendra", alergenos: [.almendra]),
        Alimento(nombre: "macaroon", imagenNombre: "macaroon", alergenos: [.almendra, .huevo, .proteinasLecheVaca]),
        Alimento(nombre: "aceite_almendras", imagenNombre: "aceite_almendras", alergenos: [.almendra]),
        
        Alimento(nombre: "avellana", imagenNombre: "avellana", alergenos: [.avellana]),
        Alimento(nombre: "nutella", imagenNombre: "nutella", alergenos: [.avellana]),
        Alimento(nombre: "pan_nutella", imagenNombre: "pan_nutella", alergenos: [.avellana, .huevo, .proteinasLecheVaca]),
        Alimento(nombre: "crepa_nutella_platano", imagenNombre: "crepa_nutella_platano", alergenos: [.avellana, .trigo, .platano, .huevo, .proteinasLecheVaca]),
        
        Alimento(nombre: "haba", imagenNombre: "haba", alergenos: [.haba]),
        Alimento(nombre: "haba2", imagenNombre: "haba2", alergenos: [.haba]),
        Alimento(nombre: "haba_amarillas", imagenNombre: "haba_amarillas", alergenos: [.haba]),
        Alimento(nombre: "sopa_habas", imagenNombre: "sopa_habas", alergenos: [.haba]),
        
        Alimento(nombre: "ejote", imagenNombre: "ejote", alergenos: [.ejote]),
        Alimento(nombre: "ejote2", imagenNombre: "ejote2", alergenos: [.ejote]),
        Alimento(nombre: "sopa_verduras", imagenNombre: "sopa_verduras", alergenos: [.ejote, .maiz, .jitomate, .cebolla, .brocoli, .apio, .zanahoria]),
        Alimento(nombre: "ejote_cebolla_tomate", imagenNombre: "ejote_cebolla_tomate", alergenos: [.ejote, .cebolla]),
        
        Alimento(nombre: "alubia", imagenNombre: "alubia", alergenos: [.alubia]),
        Alimento(nombre: "alubias_hervidas", imagenNombre: "alubias_hervidas", alergenos: [.alubia]),
        Alimento(nombre: "alubia_apio_carne_tomate", imagenNombre: "alubia_apio_carne_tomate", alergenos: [.alubia, .jitomate, .apio]),
        Alimento(nombre: "alubias_lata_tomate", imagenNombre: "alubias_lata_tomate", alergenos: [.alubia, .jitomate]),
        
        Alimento(nombre: "lenteja", imagenNombre: "lenteja", alergenos: [.lenteja]),
        Alimento(nombre: "ensalada_lentejas_cebolla_tomate", imagenNombre: "ensalada_lentejas_cebolla_tomate", alergenos: [.lenteja, .jitomate, .cebolla]),
        Alimento(nombre: "sopa_lentejas_zanahoria_tomate_cebolla", imagenNombre: "sopa_lentejas_zanahoria_tomate_cebolla", alergenos: [.lenteja, .jitomate, .cebolla, .zanahoria]),
        Alimento(nombre: "lentejas_lata_tomate", imagenNombre: "lentejas_lata_tomate", alergenos: [.lenteja]),
        
        Alimento(nombre: "frijol", imagenNombre: "frijol", alergenos: [.frijol]),
        Alimento(nombre: "frijoles_lata", imagenNombre: "frijoles_lata", alergenos: [.frijol]),
        Alimento(nombre: "frijoles_pure", imagenNombre: "frijoles_pure", alergenos: [.frijol]),
        Alimento(nombre: "frijoles_cebolla", imagenNombre: "frijoles_cebolla", alergenos: [.frijol, .cebolla]),
        
        Alimento(nombre: "garbanzo", imagenNombre: "garbanzo", alergenos: [.garbanzo]),
        Alimento(nombre: "garbanzos2", imagenNombre: "garbanzos2", alergenos: [.garbanzo]),
        Alimento(nombre: "garbanzos_chile", imagenNombre: "garbanzos_chile", alergenos: [.garbanzo]),
        
        Alimento(nombre: "soya", imagenNombre: "soya", alergenos: [.soya]),
        Alimento(nombre: "leche_soya", imagenNombre: "leche_soya", alergenos: [.soya]),
        Alimento(nombre: "salsa_soya", imagenNombre: "salsa_soya", alergenos: [.soya]),
        Alimento(nombre: "comida_asiatica", imagenNombre: "comida_asiatica", alergenos: [.soya, .trigo, .huevo]),
        
        Alimento(nombre: "avena", imagenNombre: "avena", alergenos: [.avena]),
        Alimento(nombre: "barra_avena", imagenNombre: "barra_avena", alergenos: [.avena]),
        Alimento(nombre: "avena_leche", imagenNombre: "avena_leche", alergenos: [.avena,.proteinasLecheVaca]),
        Alimento(nombre: "pastel_cereza", imagenNombre: "pastel_cereza", alergenos: [.avena, .trigo, .cereza, .huevo,.proteinasLecheVaca]),
        Alimento(nombre: "avena_galleta_trigo_leche_huevo", imagenNombre: "avena_galleta_trigo_leche_huevo", alergenos: [.avena,.trigo, .huevo, .proteinasLecheVaca]),
        
        Alimento(nombre: "arroz", imagenNombre: "arroz", alergenos: [.arroz]),
        Alimento(nombre: "arroz_leche", imagenNombre: "arroz_leche", alergenos: [.arroz]),
        Alimento(nombre: "mochi_fresa", imagenNombre: "mochi_fresa", alergenos: [.arroz, .fresa]),
        Alimento(nombre: "arroz_elote", imagenNombre: "arroz_elote", alergenos: [.arroz, .maiz]),
        
        Alimento(nombre: "centeno", imagenNombre: "centeno", alergenos: [.centeno]),
        Alimento(nombre: "pan_centeno", imagenNombre: "pan_centeno", alergenos: [.centeno, .proteinasLecheVaca]),
        Alimento(nombre: "pan_centeno2", imagenNombre: "centeno", alergenos: [.centeno]),
        Alimento(nombre: "harina_centeno", imagenNombre: "harina_centeno", alergenos: [.centeno]),
        
        Alimento(nombre: "cebada", imagenNombre: "cebada", alergenos: [.cebada]),
        Alimento(nombre: "agua_cebada", imagenNombre: "agua_cebada", alergenos: [.cebada]),
        Alimento(nombre: "agua_cebada2", imagenNombre: "agua_cebada2", alergenos: [.cebada]),
        Alimento(nombre: "cebada_plato", imagenNombre: "cebada_plato", alergenos: [.cebada]),
        
        Alimento(nombre: "maiz", imagenNombre: "maiz", alergenos: [.maiz]),
        Alimento(nombre: "elote_preparado", imagenNombre: "elote_preparado", alergenos: [.maiz, .huevo, .proteinasLecheVaca]),
        
        Alimento(nombre: "trigo", imagenNombre: "trigo", alergenos: [.trigo]),
        Alimento(nombre: "pan", imagenNombre: "pan", alergenos: [.trigo, .proteinasLecheVaca]),
        Alimento(nombre: "tarta_uvas", imagenNombre: "tarta_uvas", alergenos: [.trigo, .uva]),
        Alimento(nombre: "pan_platano", imagenNombre: "pan_platano", alergenos: [.trigo, .platano, .huevo, .proteinasLecheVaca]),
        Alimento(nombre: "huevo", imagenNombre: "huevo", alergenos: [.trigo]),
        Alimento(nombre: "tostada_aguacate", imagenNombre: "tostada_aguacate", alergenos: [.trigo, .aguacate]),
        Alimento(nombre: "pie_manzana", imagenNombre: "pie_manzana", alergenos: [.trigo, .manzana]),
        
        Alimento(nombre: "tomate_verde", imagenNombre: "tomate_verde", alergenos: [.tomateVerde]),
        Alimento(nombre: "pure_tomateverde", imagenNombre: "pure_tomateverde", alergenos: [.tomateVerde]),
        Alimento(nombre: "salsa_tomateverde_cebolla", imagenNombre: "salsa_tomateverde_cebolla", alergenos: [.tomateVerde, .cebolla]),
        Alimento(nombre: "chilaquiles_verdes", imagenNombre: "chilaquiles_verdes", alergenos: [.tomateVerde, .jitomate, .cebolla, .proteinasLecheVaca]),
        
        Alimento(nombre: "jitomate", imagenNombre: "jitomate", alergenos: [.jitomate]),
        Alimento(nombre: "guacamole", imagenNombre: "guacamole", alergenos: [.jitomate, .cebolla, .aguacate]),
        Alimento(nombre: "calabacita_tomate", imagenNombre: "calabacita_tomate", alergenos: [.jitomate, .calabacita]),
        
        Alimento(nombre: "esparrago", imagenNombre: "esparrago", alergenos: [.esparrago]),
        Alimento(nombre: "esparragos2", imagenNombre: "esparragos2", alergenos: [.esparrago]),
        Alimento(nombre: "esparragos3", imagenNombre: "esparragos3", alergenos: [.esparrago]),
        Alimento(nombre: "esparragos4", imagenNombre: "esparragos4", alergenos: [.esparrago]),
        
        Alimento(nombre: "coliflor", imagenNombre: "coliflor", alergenos: [.coliflor]),
        Alimento(nombre: "coliflor_queso", imagenNombre: "coliflor_queso", alergenos: [.coliflor,.proteinasLecheVaca]),
        Alimento(nombre: "coliflor_queso_huevo", imagenNombre: "coliflor_queso_huevo", alergenos: [.coliflor, .huevo, .proteinasLecheVaca]),
        Alimento(nombre: "coliflor_rebanada", imagenNombre: "coliflor_rebanada", alergenos: [.coliflor]),
        
        Alimento(nombre: "cebolla", imagenNombre: "cebolla", alergenos: [.cebolla]),
        
        Alimento(nombre: "betabel", imagenNombre: "betabel", alergenos: [.betabel]),
        Alimento(nombre: "betabel2", imagenNombre: "betabel2", alergenos: [.betabel]),
        Alimento(nombre: "jugo_betabel", imagenNombre: "jugo_betabel", alergenos: [.betabel]),
        Alimento(nombre: "betabel_salmuera", imagenNombre: "betabel_salmuera", alergenos: [.betabel]),
        
        Alimento(nombre: "brocoli", imagenNombre: "brocoli", alergenos: [.brocoli]),
        Alimento(nombre: "brocoli_hervido", imagenNombre: "brocoli_hervido", alergenos: [.brocoli]),
        
        Alimento(nombre: "aguacate", imagenNombre: "aguacate", alergenos: [.aguacate]),
        
        Alimento(nombre: "pepino", imagenNombre: "pepino", alergenos: [.pepino]),
        Alimento(nombre: "pepinillos", imagenNombre: "pepinillos", alergenos: [.pepino]),
        Alimento(nombre: "pepino_limon_chile", imagenNombre: "pepino_limon_chile", alergenos: [.pepino]),
        Alimento(nombre: "agua_pepino_limon", imagenNombre: "agua_pepino_limon", alergenos: [.pepino]),
        
        Alimento(nombre: "calabacita", imagenNombre: "calabacita", alergenos: [.calabacita]),
        Alimento(nombre: "calabacitas2", imagenNombre: "calabacitas2", alergenos: [.calabacita]),
        Alimento(nombre: "calabacita_asada", imagenNombre: "calabacita_asada", alergenos: [.calabacita]),
        
        Alimento(nombre: "calabaza", imagenNombre: "calabaza", alergenos: [.calabaza]),
        Alimento(nombre: "calabaza_dulce", imagenNombre: "calabaza_dulce", alergenos: [.calabaza]),
        Alimento(nombre: "calabaza_haloween", imagenNombre: "calabaza_haloween", alergenos: [.calabaza]),
        Alimento(nombre: "pumpkin_spice", imagenNombre: "pumpkin_spice", alergenos: [.calabaza]),
        
        Alimento(nombre: "apio", imagenNombre: "apio", alergenos: [.apio]),
        Alimento(nombre: "jugo_verde", imagenNombre: "jugo_verde", alergenos: [.apio, .naranja, .manzana]),
        
        Alimento(nombre: "zanahoria", imagenNombre: "zanahoria", alergenos: [.zanahoria]),
        Alimento(nombre: "jugo_zanahoria_naranja", imagenNombre: "jugo_zanahoria_naranja", alergenos: [.zanahoria, .naranja]),
        Alimento(nombre: "pastel_zanahoria", imagenNombre: "pastel_zanahoria", alergenos: [.zanahoria, .huevo, .proteinasLecheVaca]),
        
        Alimento(nombre: "coco", imagenNombre: "coco", alergenos: [.coco]),
        Alimento(nombre: "leche_coco", imagenNombre: "leche_coco", alergenos: [.coco]),
        Alimento(nombre: "agua_coco", imagenNombre: "agua_coco", alergenos: [.coco]),
        Alimento(nombre: "coco_rebanado", imagenNombre: "coco_rebanado", alergenos: [.coco]),
        
        Alimento(nombre: "guayaba", imagenNombre: "guayaba", alergenos: [.guayaba]),
        Alimento(nombre: "ate_guayaba", imagenNombre: "ate_guayaba", alergenos: [.guayaba]),
        Alimento(nombre: "mermelada_guayaba", imagenNombre: "mermelada_guayaba", alergenos: [.guayaba]),
        Alimento(nombre: "agua_guayaba", imagenNombre: "agua_guayaba", alergenos: [.guayaba]),
        
        Alimento(nombre: "melon", imagenNombre: "melon", alergenos: [.melon]),
        Alimento(nombre: "melon2", imagenNombre: "melon2", alergenos: [.melon]),
        Alimento(nombre: "melon3", imagenNombre: "melon3", alergenos: [.melon]),
        Alimento(nombre: "agua_melon", imagenNombre: "agua_melon", alergenos: [.melon]),
        
        Alimento(nombre: "fresa", imagenNombre: "fresa", alergenos: [.fresa]),
        Alimento(nombre: "helado_fresa", imagenNombre: "helado_fresa", alergenos: [.fresa, .proteinasLecheVaca]),
        Alimento(nombre: "fresas_crema", imagenNombre: "fresas_crema", alergenos: [.fresa,.proteinasLecheVaca]),
        Alimento(nombre: "malteada_fresa", imagenNombre: "malteada_fresa", alergenos: [.fresa, .proteinasLecheVaca]),
        
        Alimento(nombre: "ciruela", imagenNombre: "ciruela", alergenos: [.ciruela]),
        Alimento(nombre: "ciruela2", imagenNombre: "ciruela2", alergenos: [.ciruela]),
        Alimento(nombre: "te_ciruela", imagenNombre: "te_ciruela", alergenos: [.ciruela]),
        Alimento(nombre: "cerdo_ciruela_piñon", imagenNombre: "cerdo_ciruela_piñon", alergenos: [.ciruela]),
        
        Alimento(nombre: "cereza", imagenNombre: "cereza", alergenos: [.cereza]),
        Alimento(nombre: "cerezas2", imagenNombre: "cerezas2", alergenos: [.cereza]),
        Alimento(nombre: "cerezas3", imagenNombre: "cerezas3", alergenos: [.cereza]),
        
        Alimento(nombre: "higo", imagenNombre: "higo", alergenos: [.higo]),
        Alimento(nombre: "higos2", imagenNombre: "higos2", alergenos: [.higo]),
        Alimento(nombre: "higos3", imagenNombre: "higos3", alergenos: [.higo]),
        Alimento(nombre: "higos4", imagenNombre: "higos4", alergenos: [.higo]),
        
        Alimento(nombre: "mandarina", imagenNombre: "mandarina", alergenos: [.mandarina]),
        Alimento(nombre: "mandarina2", imagenNombre: "mandarina2", alergenos: [.mandarina]),
        Alimento(nombre: "mandarina_gajos", imagenNombre: "mandarina_gajos", alergenos: [.mandarina]),
        Alimento(nombre: "jugo_mandarina", imagenNombre: "jugo_mandarina", alergenos: [.mandarina]),
        
        Alimento(nombre: "naranja", imagenNombre: "naranja", alergenos: [.naranja]),
        Alimento(nombre: "naranja2", imagenNombre: "naranja2", alergenos: [.naranja]),
        Alimento(nombre: "jugo_naranja", imagenNombre: "jugo_naranja", alergenos: [.naranja]),
        
        Alimento(nombre: "uvas", imagenNombre: "uvas", alergenos: [.uva]),
        Alimento(nombre: "jugo_uvas", imagenNombre: "jugo_uvas", alergenos: [.uva]),
        Alimento(nombre: "gelatina_uva", imagenNombre: "gelatina_uva", alergenos: [.uva, .proteinasLecheVaca]),
        
        Alimento(nombre: "papaya", imagenNombre: "papaya", alergenos: [.papaya]),
        Alimento(nombre: "papaya2", imagenNombre: "papaya_2", alergenos: [.papaya]),
        Alimento(nombre: "papaya3", imagenNombre: "papaya_3", alergenos: [.papaya]),
        Alimento(nombre: "jugo_papaya", imagenNombre: "jugo_papaya", alergenos: [.papaya]),
        
        Alimento(nombre: "sandia", imagenNombre: "sandia", alergenos: [.sandia]),
        Alimento(nombre: "sandia2", imagenNombre: "sandia2", alergenos: [.sandia]),
        Alimento(nombre: "sandia_chile", imagenNombre: "sandia_chile", alergenos: [.sandia]),
        Alimento(nombre: "agua_sandia", imagenNombre: "agua_sandia", alergenos: [.sandia]),
        
        Alimento(nombre: "platano", imagenNombre: "platano", alergenos: [.platano]),
        Alimento(nombre: "pudin_platano", imagenNombre: "pudin_platano", alergenos: [.platano, .huevo, .proteinasLecheVaca]),
        
        Alimento(nombre: "durazno", imagenNombre: "durazno", alergenos: [.durazno]),
        Alimento(nombre: "duraznos_crema", imagenNombre: "duraznos_crema", alergenos: [.durazno, .proteinasLecheVaca]),
        Alimento(nombre: "durazno_lata", imagenNombre: "duraznos_lata", alergenos: [.durazno]),
        Alimento(nombre: "jugo_durazno", imagenNombre: "jugo_durazno", alergenos: [.durazno]),
        
        Alimento(nombre: "mango", imagenNombre: "mango", alergenos: [.mango]),
        Alimento(nombre: "mango2", imagenNombre: "mango2", alergenos: [.mango]),
        Alimento(nombre: "nieve_mango", imagenNombre: "nieve_mango", alergenos: [.mango]),
        Alimento(nombre: "jugo_mango", imagenNombre: "jugo_mango", alergenos: [.mango]),
        
        Alimento(nombre: "pera", imagenNombre: "pera", alergenos: [.pera]),
        Alimento(nombre: "pera_horno", imagenNombre: "pera_horno", alergenos: [.pera]),
        Alimento(nombre: "jugo_pera", imagenNombre: "jugo_pera", alergenos: [.pera]),
        Alimento(nombre: "mermelada_pera", imagenNombre: "mermelada_pera", alergenos: [.pera]),
        
        Alimento(nombre: "kiwi", imagenNombre: "kiwi", alergenos: [.kiwi]),
        Alimento(nombre: "kiwi2", imagenNombre: "kiwi2", alergenos: [.kiwi]),
        Alimento(nombre: "kiwi3", imagenNombre: "kiwi3", alergenos: [.kiwi]),
        Alimento(nombre: "kiwi4", imagenNombre: "jugo_kiwi", alergenos: [.kiwi]),
        
        Alimento(nombre: "manzana", imagenNombre: "manzana", alergenos: [.manzana]),
        Alimento(nombre: "jugo_manzana", imagenNombre: "jugo_manzana", alergenos: [.manzana]),

        
        Alimento(nombre: "huevo", imagenNombre: "huevo", alergenos: [.huevo]),
        Alimento(nombre: "pastel", imagenNombre: "pastel", alergenos: [.huevo, .proteinasLecheVaca]),
        
        Alimento(nombre: "leche", imagenNombre: "leche", alergenos: [.proteinasLecheVaca]),
        Alimento(nombre: "mantequilla", imagenNombre: "mantequilla", alergenos: [.proteinasLecheVaca]),
        Alimento(nombre: "crema", imagenNombre: "crema", alergenos: [.proteinasLecheVaca]),
        

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
