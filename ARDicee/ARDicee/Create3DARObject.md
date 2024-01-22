#  How to create a 3D AR Object?

let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
let sphere = SCNSphere(radius: 0.2)
let material = SCNMaterial()
material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
sphere.materials = [material]
let node = SCNNode()
node.position = SCNVector3(0, 0.1, -0.5)
node.geometry = sphere
sceneView.scene.rootNode.addChildNode(node)

