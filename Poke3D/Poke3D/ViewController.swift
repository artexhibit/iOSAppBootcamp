
import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    private var pokemons: [String: String] = [
        "eevee-card": "art.scnassets/eevee.scn",
        "oddish-card": "art.scnassets/oddish.scn"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = pokemons.count
        }
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        DispatchQueue.main.async {
            if let imageAnchor = anchor as? ARImageAnchor {
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                plane.firstMaterial?.diffuse.contents = UIColor.clear
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi/2
                node.addChildNode(planeNode)
                
                if let imageName = imageAnchor.referenceImage.name {
                    self.addPokemon(withName: imageName, to: planeNode)
                }
            }
        }
        return node
    }
    
    func addPokemon(withName name: String, to planeNode: SCNNode) {
        guard let pokeName = pokemons[name] else {return}
        guard let pokeScene = SCNScene(named: pokeName) else {return}
        guard let pokeNode = pokeScene.rootNode.childNodes.first else {return}
        pokeNode.eulerAngles.x = .pi/2
        planeNode.addChildNode(pokeNode)
    }
}

