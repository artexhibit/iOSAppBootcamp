// Protocols Demo
protocol CanFly {
    func fly()
}

class Bird {
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("The bird makes a new bird in a shell.")
        }
    }
}

class Eagle: Bird, CanFly {
    func fly() {
        print("The eagle flaps its wings and lifts off into the sky.")
    }
    
    func soar() {
        print("The eagle glides in the air using air currents.")
    }
}

class Penguin: Bird {
    func swim() {
        print("The penguin paddles through the water.")
    }
}

struct FlyingMuseum {
    func flyingDemo(flyingObject: CanFly) {
        flyingObject.fly()
    }
}

struct Airplane: CanFly {
    func fly() {
        print("The airplane uses its engines to lift off into the air.")
    }
}

let myEagle = Eagle()
let myPenguin = Penguin()
let myPlane = Airplane()
let museum = FlyingMuseum()

museum.flyingDemo(flyingObject: myEagle)

//Protocols And Delegates Demo
protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?
    
    func assessSituation() {
        print("Can you tell me what happened?")
    }
    
    func medicalEmergency() {
        delegate?.performCPR()
    }
    
}

struct Paramedic: AdvancedLifeSupport {
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramedic does chest compressions, 30 per second.")
    }
}

class Doctor: AdvancedLifeSupport {
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The doctor does chest compressions, 30 per second.")
    }
    
    func useStethoscope() {
        print("Listening for heart sounds.")
    }
}

class Surgeon: Doctor {
    override func performCPR() {
        super.performCPR()
        print("Sings staying alive by BeeGees.")
    }
    
    func useElectricDrill() {
        print("Whirr...")
    }
}

let Emilio = EmergencyCallHandler()
let Angela = Surgeon(handler: Emilio)

Emilio.assessSituation()
Emilio.medicalEmergency()
