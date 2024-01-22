
import UIKit

class StoryViewController: UIViewController {
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyLabel.text = storyBrain.getLabelText()
        choice1Button.setTitle(storyBrain.getChoice1Text(), for: .normal)
        choice2Button.setTitle(storyBrain.getChoice2Text(), for: .normal)
        view.backgroundColor = storyBrain.getColor()
        buttonAttributes()
    }
    
    @IBAction func choiceMade(_ sender: UIButton) {
        let userChoice = sender.currentTitle!
        storyBrain.nextStory(userChoice)
        updateUI()
        
        if storyBrain.storyNumber == storyBrain.endOfStory() {
        performSegue(withIdentifier: "goToEndOfStory", sender: self)
            storyBrain.resetStory()
            updateUI()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEndOfStory" {
            let destinationVC = segue.destination as! EndViewController
            destinationVC.storyLabel = storyBrain.getLabelText()
            destinationVC.color = storyBrain.getColor()
            destinationVC.buttonImage = storyBrain.getButtonImage()
        }
    }
    
    func updateUI() {
        storyLabel.text = storyBrain.getLabelText()
        choice1Button.setTitle(storyBrain.getChoice1Text(), for: .normal)
        choice2Button.setTitle(storyBrain.getChoice2Text(), for: .normal)
    }
    
    func buttonAttributes() {
        choice1Button.titleLabel!.adjustsFontSizeToFitWidth = true
        choice2Button.titleLabel!.adjustsFontSizeToFitWidth = true
        
        choice2Button.titleLabel!.textAlignment = .center
        choice2Button.titleLabel!.numberOfLines = 0
        
        choice1Button.titleLabel!.textAlignment = .center
        choice1Button.titleLabel!.numberOfLines = 0
    }
}

