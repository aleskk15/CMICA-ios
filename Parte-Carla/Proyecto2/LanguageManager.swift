import SwiftUI

class LanguageManager: ObservableObject {
    @Published var currentLanguage: String = "es"
    
    func toggleLanguage() {
        if currentLanguage == "es" {
            currentLanguage = "en"
        } else {
            currentLanguage = "es"
        }
    }
}

extension String {
    func traducido(_ idioma: String) -> String {
        guard let path = Bundle.main.path(forResource: idioma, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
