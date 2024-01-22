
import UIKit

class UserPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var knowButton: UIButton!
    
    private let imagePicker = UIImagePickerController()
    private let flowerRecognition = FlowerRecognition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        knowButton.isHidden = true
        navigationItem.backButtonTitle = ""
        imageView.image = UIImage(named: "LaunchImage")
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToFlower", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FlowerDescriptionViewController
        destinationVC.updateTitle = self.title
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.editedImage] as? UIImage {
            imageView.image = userPickedImage
            knowButton.isHidden = false
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Failed to convert into CIImage")
            }
            self.title = flowerRecognition.detect(flowerImage: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
