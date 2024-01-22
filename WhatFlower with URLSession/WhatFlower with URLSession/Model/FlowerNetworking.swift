
import Foundation
import UIKit

protocol FlowerNetworkingDelegate {
    func didUpdateFlower(_ flowerNetworking: FlowerNetworking, flowerData: FlowerModel)
    func didFailWithError(_ flowerNetworking: FlowerNetworking, error: Error)
}

struct FlowerNetworking {
    var delegate: FlowerNetworkingDelegate?
    
    let baseURL = "https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts|pageimages&exintro=&explaintext=&indexpageids&redirects=1&pithumbsize=500&titles"
    
    func getFlowerInfo(flowerName: String) {
        let lowercasedName = flowerName.lowercased()
        let url = "\(baseURL)=\(lowercasedName)"
        if let urlWithAllowedCharacters = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            performRequest(with: urlWithAllowedCharacters)
        }
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(self, error: error!)
                    return
                }
                if let safeData = data {
                    if let flower = self.parseJSON(with: safeData) {
                        self.delegate?.didUpdateFlower(self, flowerData: flower)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(with flowerData: Data) -> FlowerModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FlowerData.self, from: flowerData)
            let pageId = decodedData.query.pageids[0]
            let flowerDescription = decodedData.query.pages[pageId]?.extract
            let flowerPictureURL = decodedData.query.pages[pageId]?.thumbnail.source
            let flowerPicture = loadImage(with: flowerPictureURL!)
            let flowerModel = FlowerModel(description: flowerDescription, picture: flowerPicture)
            return flowerModel
        } catch {
            self.delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
    
    func loadImage(with urlString: String) -> UIImage {
        guard let url = URL(string: urlString) else {
            fatalError("Error configuring URL")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Error fetching the Data")
        }
        guard let imageToSet = UIImage(data: data) else {
            fatalError("Error creating an UIImage")
        }
        return imageToSet
    }
}
