
import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        navBarSetUp()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Failed to convert UIImage into CIImage")
            }
            detect(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        guard let inceptionV3 = try? Inceptionv3(configuration: MLModelConfiguration.init()) else {
            fatalError("Initialising InceptionV3 model failed")
        }
        guard let model = try? VNCoreMLModel(for: inceptionV3.model) else {
            fatalError("Loading CoreML model failed")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navBarSetUp(barColor: .green, titleColor: .black)
                    self.title = "Хот-дог!😍"
                } else {
                    self.navBarSetUp(barColor: .red, titleColor: .white)
                    self.title = "Это не хот-дог!😩"
                }
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
        try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func navBarSetUp(barColor: UIColor? = nil, titleColor: UIColor? = nil) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = nil
        
        if let colorToSet = barColor, let titleColorToSet = titleColor {
            appearance.backgroundColor = colorToSet
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColorToSet]
            navigationController?.navigationBar.tintColor = titleColorToSet
        } else {
            navigationController?.navigationBar.tintColor = UIColor(named: "TintColor")
        }
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
