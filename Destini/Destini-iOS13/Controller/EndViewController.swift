
import UIKit

class EndViewController: UIViewController {
    
    var storyLabel: String?
    var color: UIColor?
    var buttonImage: UIImage?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var repeatButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = storyLabel
        repeatButton.setBackgroundImage(buttonImage, for: .normal)
        view.backgroundColor = color
    }
    
    @IBAction func repeatPressed(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
}
