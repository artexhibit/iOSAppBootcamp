
/* let myOptional: String?

 
1.Force Unwrapping
 
In that case we should think about there is a case we could be unwrapping it or it could be a nil value stored.
 
myOptional = nil
let text: String = myOptional! */


/* 2.Check for nil value
 
Slightly better way but have minuses:
 - it's wordy;
 - we should unwrap value with ! mark even if we already know it's not equal to nil.
 
myOptional = nil
if myOptional != nil {
    let text: String = myOptional!
    let text2: String = myOptional!
} else {
    print("myOptional was found to be nil")
} */


/* 3.Optional Binding

This way let us skip the force unwrapping of our value. With safeOptional constant we can check what is inside myOptional constant. If it's nil then perform block else, if it's not nil - we put the value inside myOptional, then equal it to safeOptional and work with this value inside the if block.
 
myOptional = "Igor"
if let safeOptional = myOptional {
    let text: String = safeOptional
    let text2: String = safeOptional
    print(safeOptional)
} else {
    print("myOptional was found to be nil")
} */


/* 4. Nil Coalescing Operator

It checks if the optional is nil then we can set a default value to it. If it's not nil then we can use that value.

myOptional = nil
let text: String = myOptional ?? "I am the default value"
print(text) */


/*5. Optional Chaining
 
Works when a data type of our constant is not just a String or Int but the whole Struct. ? mark mean that if this optional is not equal to nil then we can access it's property or methods, but if it's nil then it won't be equal to anything.
 
struct MyOptionalStruct {
    var property = 123
    func method() {
        print("I am the struct's method")
    }
}
 
let myOptional: MyOptionalStruct?
myOptional = MyOptionalStruct()
myOptional?.method() */
