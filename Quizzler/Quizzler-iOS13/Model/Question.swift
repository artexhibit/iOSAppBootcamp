
import Foundation

struct Question {
    let text: String
    let answers: [String]
    let correctAnswer: String
    
    init(q: String, a: [String], ca: String) {
        text = q
        answers = a
        correctAnswer = ca
    }
}
