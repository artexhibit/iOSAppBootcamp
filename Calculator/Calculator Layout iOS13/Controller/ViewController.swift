
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    private var calculatorLogic = CalculatorLogic()
    
    var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("Can't convert displayLabel text to a Double")
            }
            return number
        }
        set {
            let isInt = floor(newValue) == newValue
            
            if isInt {
                displayLabel.text = String(format: "%.0f", newValue)
            } else {
                displayLabel.text = String(newValue)
                if newValue == 0 {
                    displayLabel.text = "0"
                }
            }
        }
    }
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTypingNumber = true
        calculatorLogic.setNumber(displayValue)
        if let calcMethod = sender.currentTitle {
            if let result = calculatorLogic.calculate(with: calcMethod) {
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                if numValue == "." {
                    displayLabel.text! = "0."
                } else {
                    displayLabel.text! = numValue
                }
                isFinishedTypingNumber = false
            } else {
                if !displayLabel.text!.contains(".") || numValue != "." {
                    displayLabel.text! += numValue
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
