
import UIKit

struct StoryBrain {
    
    var storyNumber = 0
        
    let Stories = [
        Story(
            title: "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: Need a ride, boy?",
            choice1: "I'll hop in. Thanks for the help!", choice1Destination: 2,
            choice2: "Better ask him if he's a murderer first.", choice2Destination: 1, color: #colorLiteral(red: 0.2525317073, green: 0.326730907, blue: 0.3861291409, alpha: 1)
        ),
        Story(
            title: "He nods slowly, unfazed by the question.",
            choice1: "At least he's honest. I'll climb in.", choice1Destination: 2,
            choice2: "Wait, I know how to change a tire.", choice2Destination: 3, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        ),
        Story(
            title: "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box.",
            choice1: "I love Elton John! Hand him the cassette tape.", choice1Destination: 5,
            choice2: "It's him or me! You take the knife and stab him.", choice2Destination: 4, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        ),
        Story(
            title: "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?",
            choice1: "The", choice1Destination: 0,
            choice2: "End", choice2Destination: 0, color: #colorLiteral(red: 0.1171863601, green: 0.692614615, blue: 0, alpha: 1)
        ),
        Story(
            title: "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in.",
            choice1: "The", choice1Destination: 0,
            choice2: "End", choice2Destination: 0, color: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        ),
        Story(
            title: "You bond with the murderer while crooning verses of 'Can you feel the love tonight'. He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: 'Try the pier.'",
            choice1: "The", choice1Destination: 0,
            choice2: "End", choice2Destination: 0, color: #colorLiteral(red: 0.6625987887, green: 0, blue: 0.08400998265, alpha: 1)
        )
        
    ]
    
    mutating func nextStory(_ userChoice:String) {
        
        if userChoice == Stories[storyNumber].choice1 {
            storyNumber = Stories[storyNumber].choice1Destination
        } else if userChoice == Stories[storyNumber].choice2 {
            storyNumber = Stories[storyNumber].choice2Destination
        }
    }
    
    func getLabelText() -> String {
        return Stories[storyNumber].title
    }
    
    func getChoice1Text() -> String {
        return Stories[storyNumber].choice1
    }
    
    func getChoice2Text() -> String {
            return Stories[storyNumber].choice2
    }
    
    mutating func resetStory() {
        storyNumber = 0
    }
    
    func endOfStory() -> Int {
        if storyNumber == 3 || storyNumber == 4 || storyNumber == 5 {
            return storyNumber
        }else {
           return 3
        }
    }
    
    func getColor() -> UIColor {
        return Stories[storyNumber].color
    }
    
    func getButtonImage() -> UIImage {
        if storyNumber == 3 {
            return #imageLiteral(resourceName: "repeatButton")
        }else if storyNumber == 4 || storyNumber == 5 {
            return #imageLiteral(resourceName: "repeatButton2")
        } else {
            return #imageLiteral(resourceName: "repeatButton")
        }
    }
}
