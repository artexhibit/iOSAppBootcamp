
import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var result:String?
    var split:String?
    var tip:Float?

    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = result
        settingsLabel.text = "Расчёт на \(split!) человек и \(Int((tip ?? 0.0) * 100))% чаевых."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
