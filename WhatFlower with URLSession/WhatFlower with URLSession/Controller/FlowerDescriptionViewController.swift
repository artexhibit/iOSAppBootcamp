
import UIKit

class FlowerDescriptionViewController: UIViewController, FlowerNetworkingDelegate {

    @IBOutlet weak var wikiImage: UIImageView!
    @IBOutlet weak var wikiLabel: UILabel!
    
    private var flowerNetworking = FlowerNetworking()
    var updateTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = updateTitle
        flowerNetworking.delegate = self
        flowerNetworking.getFlowerInfo(flowerName: updateTitle!)
    }
    
    func didUpdateFlower(_ flowerNetworking: FlowerNetworking, flowerData: FlowerModel) {
        DispatchQueue.main.async {
            self.wikiLabel.text = flowerData.description
            self.wikiImage.image = flowerData.picture
        }
    }
    func didFailWithError(_ flowerNetworking: FlowerNetworking, error: Error) {
        print(error)
    }
}
