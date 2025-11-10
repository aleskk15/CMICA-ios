import Foundation
import SwiftUI
import SwiftData

@Model
class Profile {
    @Attribute(.unique) var id: UUID
    var name: String
    var imageName: String
    var backgroundColorHex: String
    
    var realName: String
    var age: Int? 
    var allergies: [String]
    
    @Transient
    var backgroundColor: Color {
        Color(hex: backgroundColorHex)
    }
    
    init(id: UUID = UUID(), name: String, imageName: String, backgroundColorHex: String, realName: String, age: Int?, allergies: [String]) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.backgroundColorHex = backgroundColorHex
        self.realName = realName
        self.age = age
        self.allergies = allergies
    }
}
