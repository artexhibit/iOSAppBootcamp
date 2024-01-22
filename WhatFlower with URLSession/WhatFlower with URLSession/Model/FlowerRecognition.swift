
import Foundation
import CoreML
import Vision
import UIKit

struct FlowerRecognition {
    
    func detect(flowerImage: CIImage) -> String {
        var capitalizedResult = String()
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: MLModelConfiguration()).model) else {
            fatalError("Failed to load a model")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process")
            }
            guard let firstResult = results.first?.identifier else {
                fatalError("Failed to receive a flower identifier from a model")
            }
            capitalizedResult = firstResult.capitalized
        }
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        return capitalizedResult
    }
}
