
import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipsyBrain = TipsyBrain()
   
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let tipAmount = sender.currentTitle!
        tipsyBrain.tipToFloat(tipAmount)
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let stepperValue = sender.value
        splitNumberLabel.text = tipsyBrain.stepperToString(stepperValue)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        tipsyBrain.splitNumber = splitNumberLabel.text
        tipsyBrain.billNumber = billTextField.text
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = tipsyBrain.calculateResult()
            destinationVC.split = tipsyBrain.splitNumber
            destinationVC.tip = tipsyBrain.tipNumber
        }
    }
}

