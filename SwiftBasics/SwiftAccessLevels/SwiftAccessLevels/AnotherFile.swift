
import Foundation

class AnotherClassInAnotherFile {
    let aClass = AClass()
    
    init() {
        
        //Step 8. Try to print aFilePrivateProperty Here - Not Possible
        
        //Step 10. Try to print anInternalProperty Here - Possible
        //print("\(aClass.anInternalProperty) printed in AnotherClassInAnotherFile from AClass")
        
    }
    
}
