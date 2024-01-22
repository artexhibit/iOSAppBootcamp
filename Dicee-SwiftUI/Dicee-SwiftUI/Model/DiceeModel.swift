

import Foundation
import SwiftUI


class DiceeModel: ObservableObject {
    
    @Published var leftDiceNumber = 1
    @Published var rightDiceNumber = 1
    
    func roll() {
        leftDiceNumber = Int.random(in: 1...6)
        rightDiceNumber = Int.random(in: 1...6)
    }
    
}
