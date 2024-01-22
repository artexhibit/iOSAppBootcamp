
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    
    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userGotItRight = quizBrain.checkAnswer(sender.currentTitle!)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        let getAnswers = quizBrain.getQuestionAnswer()
        topButton.setTitle(getAnswers[0], for: .normal)
        middleButton.setTitle(getAnswers[1], for: .normal)
        bottomButton.setTitle(getAnswers[2], for: .normal)
        
        topButton.backgroundColor = UIColor.clear
        middleButton.backgroundColor = UIColor.clear
        bottomButton.backgroundColor = UIColor.clear
        }
        
}
