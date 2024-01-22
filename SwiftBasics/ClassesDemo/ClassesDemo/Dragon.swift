//Creating a SubClass Dragon from SuperClass Enemy
class Dragon: Enemy {
    
//Creating a uniq properties for SubClass in addition to already existing properties from SuperClass
    var wingSpan = 2
    
    func talk(speech: String) {
        print("Says: \(speech)")
    }
    
//Access to a method from SuperClass and customly change it on what needed with "override" keyword
    override func move() {
        print("Fly forwards.")
    }
    
//We can save SuperClass's method code and add our custom at the same time with a keyword "super."
    override func attack() {
        super.attack()
        print("Spits fire, does 10 damage")
    }
}
