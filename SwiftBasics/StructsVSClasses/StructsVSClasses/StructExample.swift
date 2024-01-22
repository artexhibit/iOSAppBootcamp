
import Foundation

struct StructHero {
    var name: String
    var universe: String
    
    mutating func reverseNameInsideStruct() {
        self.name = String(self.name.reversed())
    }
    
    func reverseName() -> String {
        String(self.name.reversed())
    }
}
