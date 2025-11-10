import Foundation

class ActiveProfileManager: ObservableObject {
    
    @Published var activeProfileID: UUID? {
        didSet {
            UserDefaults.standard.set(activeProfileID?.uuidString, forKey: "activeProfileID")
        }
    }
    
    init() {
        if let savedIDString = UserDefaults.standard.string(forKey: "activeProfileID") {
            self.activeProfileID = UUID(uuidString: savedIDString)
        }
    }
    
    func setActiveProfile(id: UUID) {
        self.activeProfileID = id
    }
}
