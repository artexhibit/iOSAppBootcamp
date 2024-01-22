
import Foundation

class AClass {
    
    //Global variables, also called class properties.
    private var aPrivateProperty = "private property"
    fileprivate var aFilePrivateProperty = "fileprivate property"
    var anInternalProperty = "internal property"
    
    func methodA () {
        var aLocalVariable = "local variable"
        
        //Step 1. Try to print aLocalVariable Here - Possible
        //print("\(aLocalVariable) printed from methodA in AClass")
        
        //Step 3. Try to print aPrivateProperty Here - Possible
        //print("\(aPrivateProperty) printed from AClass in methodA")
        
        //Step 6. Try to print aFilePrivateProperty Here - Possible
        //print("\(aFilePrivateProperty) printed from AClass in methodA)")
        
        //Step 9. Try to print anInternalProperty Here - Possible
        //print("\(anInternalProperty) printed from AClass in methodA")
    }
    
    func methodB () {
        
        //Step 2. Try to print aLocalVariable Here - Not Possible
    
        //Step 4. Try to print aPrivateProperty Here - Possible
        //print("\(aPrivateProperty) printed from AClass in methodB")
    }
    
}

class AnotherClassInTheSameFile {
    let aClass = AClass()
    
    init() {
        
        //Step 5. Try to print aPrivateProperty Here - Not Possible
        
        //Step 7. Try to print aFilePrivateProperty Here - Possible
        //print("\(aClass.aFilePrivateProperty) printed from AClass in AnotherCLassInTheSameFile")
        
    }
}
