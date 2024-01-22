
import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    private var nodeIsTracked = true
    private var videoNode = SKVideoNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Potter Picture", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    //MARK: - ARCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if nodeIsTracked {
            if let imageAnchor = anchor as? ARImageAnchor {
                videoNode = SKVideoNode(fileNamed: "harrypotter.mp4")
                videoNode.play()
                let videoScene = SKScene(size: CGSize(width: 640, height: 360))
                videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
                videoNode.yScale = -1.0
                videoScene.addChild(videoNode)
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                plane.firstMaterial?.diffuse.contents = videoScene
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi/2
                node.addChildNode(planeNode)
            }
        }
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if node.isHidden {
            if let imageAnchor = anchor as? ARImageAnchor {
                sceneView.session.remove(anchor: imageAnchor)
                videoNode.pause()
            }
        } else {
            nodeIsTracked = true
        }
    }
}
