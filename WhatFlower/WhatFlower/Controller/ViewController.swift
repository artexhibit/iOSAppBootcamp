
import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    private var flowerName: String? {
        didSet {
            if let flower = flowerName {
                self.requestInfo(flowerName: flower)
            }
        }
    }
    private let imagePicker = UIImagePickerController()
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.editedImage] as? UIImage {
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Failed to convert into CIImage")
            }
            detect(flowerImage: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(flowerImage: CIImage) {
        guard let flowerClassifier = try? FlowerClassifier(configuration: MLModelConfiguration.init()) else {
            fatalError("Failed to load a FlowerClassifier")
        }
        guard let model = try? VNCoreMLModel(for: flowerClassifier.model) else {
            fatalError("Failed to load a model")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process")
            }
            guard let firstResult = results.first?.identifier else {
                fatalError("Failed to receive a flower identifier from a model")
            }
            self.title = firstResult
            self.flowerName = firstResult
        }
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        do {
        try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    func requestInfo(flowerName: String) {
        
        let parameters : [String:String] = [
        "format": "json",
        "action": "query",
        "prop": "extracts|pageimages",
        "exintro": "",
        "explaintext": "",
        "titles": flowerName,
        "indexpageids": "",
        "redirects": "1",
        "pithumbsize": "500"
        ]
        
        AF.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (responce) in
            switch responce.result {
            case .success:
                let flowerJSON: JSON = JSON(responce.value!)
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                self.label.text = flowerDescription
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
            case .failure:
                print("Failed to get from wiki")
            }
        }
    }
}

