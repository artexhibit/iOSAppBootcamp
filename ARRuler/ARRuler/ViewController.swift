
import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    private var dotNodes = [SCNNode]()
    private var textNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            if dotNodes.count >= 2 {
                for dot in dotNodes {
                    dot.removeFromParentNode()
                }
                dotNodes.removeAll()
                textNode.removeFromParentNode()
            }
            
            if let query = sceneView.raycastQuery(from: touchLocation, allowing: .estimatedPlane, alignment: .any) {
                let results = sceneView.session.raycast(query)
                if let result = results.first {
                    addDot(at: result)
                }
            }
        }
    }
    
    func addDot(at result: ARRaycastResult) {
        let dotGeometry = SCNSphere(radius: 0.005)
        let dotMaterial = SCNMaterial()
        dotMaterial.diffuse.contents = UIColor.red
        dotGeometry.materials = [dotMaterial]
        let dotNode = SCNNode(geometry: dotGeometry)
        dotNode.position = SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
        sceneView.scene.rootNode.addChildNode(dotNode)
        dotNodes.append(dotNode)
        
        if dotNodes.count >= 2 {
            calculate()
        }
    }
    
    func calculate() {
        let start = dotNodes[0]
        let end = dotNodes[1]
        //distance = √((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2)
        let distance = sqrt(
            pow(end.position.x - start.position.x, 2) +
            pow(end.position.y - start.position.y, 2) +
            pow(end.position.z - start.position.z, 2)
        )
        updateText(text: "\(String(format: "%.1f", distance * 100))cm", atPosition: end.position)
    }
    
    func updateText(text: String, atPosition position: SCNVector3) {
        let textGeometry = SCNText(string: ("\(text)cm"), extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.red
        textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(position.x, position.y + 0.01, position.z)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        sceneView.scene.rootNode.addChildNode(textNode)
    }
}
