import Foundation
import UIKit

//String Concatenation - выполнение кода, заключенного между строковыми значениями
print("I want \(3+9) cucumbers")
print("The result of (5+3)/4^2 is \((5+3)/4^2)")

//Variable Challenge. Как поменять местами значения переменных
var a = "Igor"
var b = "Tanya"

var c = a //Igor
a = b //Tanya
b = c //Igor

print(a)
print (b)

//Array Challenge. Как вызвать определенные значения из массива и провести с ними манипуляции
var numbers = [45,73,195,53]

var computedNumbers = [numbers[0]*numbers[1],numbers[1]*numbers[2],numbers[2]*numbers[3],numbers[3]*numbers[0]]

print (computedNumbers)

//Double Randomisation. Использование рандомизации с типом данных Double и Half Open Range оператором. Конечное число не включает 3
let randomNumber = Double.random(in: 1..<3)

//Password Challenge. Использование массива со строковыми значениями с применением рандомизации для создания пароля
let numbersInArray = ["a","b","c","d","e","f","g","h","i","j"]

let superPassword = numbersInArray[Int.random(in: 0...9)]+numbersInArray[Int.random(in: 0...9)]+numbersInArray[Int.random(in: 0...9)]+numbersInArray[Int.random(in: 0...9)]+numbersInArray[Int.random(in: 0...9)]

print(superPassword)

//Functions. Создание функции, её вызов
func greeting() {
    print("Hello")
}
greeting()

//Scope (границы,рамки). Describes when function can be accessed or used
func greeting1() {
    print("Hello")
    
    func greeting2() {
        print("Heia")
    }
}

//Type Inference. Capability of SWIFT to infer Data Type based on data put into variable
var myName = "Igor"
myName = "Jack"
//myName = 12 Error: Cannot assign value of type 'Int' to type 'String'

//Assign the data type instead of infer
var myFavNumber: Int = 3

//Function with Input
func sayHelloTo(whoToGreet: String){
    print("Welcome \(whoToGreet)")
}

sayHelloTo(whoToGreet: "Kirill")
sayHelloTo(whoToGreet: "Vityok")

//Function with Outputs
func greetingParty(name: String) -> Bool {
    
    if name == "Igor" || name == "Polina" {
        return true
    } else {
        return false
    }
}

var letInside = greetingParty(name: "Igor")
print(letInside)

//Conditionals. If/Else Statement
func loveCalculator(){
    
    let loveScore:Int = Int.random(in: 0...100)
 //если        больше   то
    if loveScore > 80 {
        print("You love each other like Kanye loves Kanye.")
    }
 //если            больше   и    меньше либо равен
    else if loveScore > 40 && loveScore <= 80 {
        print("You go together like Coke and Mentos")
    }
 //в других случаях
    else {
        print("You will be forever alone")
    }
    
}
loveCalculator()

//Conditionals. Switch Statement
func loveCalculator2(){
    
    let loveScore:Int = Int.random(in: 0...100)
    
    switch loveScore {
    case 80...100 :
        print("You love each other like Kanye loves Kanye.")
    case 40..<80 :
        print("You go together like Coke and Mentos")
    case ...39 :
        print("You will be forever alone")
    default:
        print("You did something wrong")
    }
}
loveCalculator2()

//Leap Year Challenge
func isLeap(year: Int) {
//% - remainder operator (оператор остатка), && - and/или, || - or/или
    if year % 4 == 0 && year % 100 != 0 || year % 400 == 0 {
        print("YES")
    }else {
        print("NO")
     }
}

isLeap(year: 2000)

//Switch Statement Challenge
func dayOfTheWeek(day: Int){
    
    switch day {
    case 1:
        print("Monday")
    case 2:
        print("Tuesday")
    case 3:
        print("Wednesday")
    case 4:
        print("Thursday")
    case 5:
        print("Friday")
    case 6:
        print("Saturday")
    case 7:
        print("Sunday")
    default:
        print("Oppps,seems you're drunk coz it's 7 days in a week")
        
    }
}

dayOfTheWeek(day: 7)

//Optionals
/* var player1Username: String = nil
 You'll get an error coz we can't simply give a container no data */
var player1Username: String? = nil

player1Username = "igorIsAwesome"
player1Username = nil

if player1Username != nil {
   print(player1Username!)
}

//Structures
//Defining a structure
struct Town {
    let name = "Angelaland"
    var citizens = ["Angela", "Jack Bauer"]
    var resources = ["Grain": 100, "Ore": 42, "Wool": 75]

//Method (func associated with a struct)
    func fortify() {
    print("Defences increased!")
    }
}

//Using struct properties
var myTown = Town()

print(myTown.citizens)
print("\(myTown.name) has \(myTown.resources["Grain"]!) bags of grain.")
print("\(myTown.citizens[0]) is a mayor of \(myTown.name).")

//.append - add a new item to array
myTown.citizens.append("Keanu Reeves")
myTown.resources["Grain"] = 99

print(myTown.citizens.count)
print(myTown.resources["Grain"]!)

//Initializers
struct City {
    let name: String
    var citizens: [String] //array
    var resources: [String:Int] //dictionary
    
//Creating initializer
    init(name: String, citizens: [String], resources: [String: Int]) {
//Struct property name = input parameter (local let/var)
        self.name = name
        self.citizens = citizens
        self.resources = resources
    }
    
    func fortify() {
    print("Defences increased!")
    }
    
//Immutability
//Keyword which let mutating from within a structure
//self.mutating func harvestRise() { - we can't change self. because it's auto created as let
    mutating func harvestRise() {
        resources["Rise"] = 100
    }
}

//Using initializers
var anotherCity = City(name: "Nameless Island", citizens: ["Tom Hanks"], resources: ["Coconuts": 100])
var ghostCity = City(name: "Ghosty McGhostface", citizens: [], resources: ["Tumbleweed": 1])

anotherCity.citizens.append("Wilson")

//Calling a struct method
ghostCity.harvestRise()
print(ghostCity.resources)

// Using function as an Input
func calculator (n1: Int, n2: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(n1, n2)
}

// Using Closure as an Input
calculator(n1: 5, n2: 10, operation: { (no1: Int, no2: Int) -> Int in
    return no1*no2
})

/* We can make above code much shorter
1.Type Inference - we can delete no1/no2 data type coz compilator will understand their data type after passing n1/n2 into the closure */
calculator(n1: 5, n2: 10, operation: { (no1, no2) -> Int in
    return no1*no2
})

/* 2. Type Inference - we can delete -> Int because we have an operation inside closure and based on that get compilator infer output data type */
calculator(n1: 5, n2: 10, operation: { (no1, no2) in
    return no1*no2
})

/* 3. Use implicit return. Remove keyword. Because we are inside a closure and have an operation, compilator can infer that we want something to be returned */
calculator(n1: 5, n2: 10, operation: { (no1, no2) in no1*no2 })

 /* 4. Closures can provide anonymous parameter names: $0 - first parameter name, $1 - second parameter name and so on. It reads as first parameter multiplied by second parameter */
calculator(n1: 5, n2: 10, operation: {$0*$1})

/* 5. Swift rule - if the last parameter of func is closure, you can omit the last parameter name. And have closure trailing at the end */
calculator(n1: 5, n2: 10) {$0*$1}

// Swift has functions called .map, .reduce, .filter
let array = [6,2,3,9,4,1]
print(array.map{$0+1})

let newArray = array.map{"\($0)"}
print(newArray)

/*Extensions
First example */
extension UIButton {
    func makeCircular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
button.backgroundColor = .red
button.makeCircular()

//Second Example
extension Double {
    func round(to places: Int) -> Double {
        let precisionNumber = pow(10, Double(places))
        var n = self
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}

var myDouble = 3.14159
myDouble.round(to: 1)

// Extend Protocols with it's methods default implementation
protocol CanDrinkBeer {
    func drinkBeer(name: String)
}

extension CanDrinkBeer {
    func drinkBeer(name: String) {
        print("\(name) drink a lot of Beer after.")
    }
}

class Human: CanDrinkBeer {
    func eatHotDogs(amount: Int, name: String) {
        print("\(name) wants to eat \(amount) Hot Dogs.")
    }
}

class Hobbit {
    func eatHotDogs(amount: Int, name: String) {
        print("Hobbit \(name) want to eat \(amount) Hot Dogs.")
    }
}

let human = Human()
let hobbit = Hobbit()
human.eatHotDogs(amount: 5, name: "Pete")
human.drinkBeer(name: "Pete")
hobbit.eatHotDogs(amount: 8, name: "Rafa")

//Loops
//Set - type of collection similar to Array, but it's not guarantee the order of this items. Result will be delivered in most efficient way
let fruits: Set = ["Apple", "Pear", "Orange"]
let contacts = ["Adam": 123445, "James": 4553224, "Amy": 5532355]
let word = "supercalifragilisticexpialidocious"
let halfOpenRange = 1..<5
let closedRange = 1...5

//For in Loops
//fruit is the name which is going to be assigned to each element in the array fruits
for fruit in fruits {
    print(fruit)
}

for person in contacts {
    print(person.value)
}

for letter in word {
   print(letter)
}

for number in halfOpenRange {
    print(number)
}

for number in closedRange {
    print(number)
}

// if we want to repeat a certain block of code a number of times we use _:
for _ in halfOpenRange {
    print("Hello")
}

//While Loops
//Working with conditions (if 8>5 or Igor is the best). If condition are true - the loop will uncontinuously run until this condition comes false. When using while loop you should be confident that at some point the condition can turn false.

var now = Date().timeIntervalSince1970
let oneSecondFromNow = now + 1
while now < oneSecondFromNow {
    now = Date().timeIntervalSince1970
    print("waiting...")
}

//Fibonacci Challenge Solution (For In Loops Challenge)
func fibonacci(n: Int) {
    var n1 = 0
    var n2 = 1
    var array = [n1, n2]
    
    if n < 1 {
        print("0 elements")
    } else {
    for _ in 1...n {
        n1 = n1 + n2
        n2 = n1 + n2
        array.append(n1)
        array.append(n2)
    }
    print(array.prefix(n))
    }
}
fibonacci(n: 5)

//Another Challenge Solution
func fibonacciN (n: Int) {
    var a1 = 0
    var b2 = 1
    var arrayF = [a1,b2]
    
    if n == 0 {
        print("Error")
    } else if n == 1 {
        print("[0]")
    } else {
        for _ in 2..<n {
            let c3=a1+b2
            a1=b2
            b2=c3
            arrayF.append(c3)
        }
        print(arrayF)
    }
}
fibonacciN(n: 3)

//Type Casting
class Animal {
    var name: String
    
    init(n:String) {
        name = n
    }
}

class Humans: Animal {
    func code() {
        print("Typing away...")
    }
}

class Fish: Animal {
    func breatheUnderWater() {
        print("Breathing under water")
    }
}

let angela = Humans(n: "Angela")
let jack = Humans(n: "Jack Bauer")
let nemo = Fish(n: "Nemo")

let neighbours = [angela, jack, nemo]

func findNemo(from animals: [Animal]) {
    for animal in animals {
//keyword is used for Type Checking. We check whether is the object of that Data Type
        if animal is Fish {
            print(animal.name)
//keyword as! used for Forced Downcast. We cast down animal SuperClass to it's SubClass Fish
            let fish = animal as! Fish
            fish.breatheUnderWater()
//keyword as used for Upcast. When we need to raise an object to its SuperClass
            let animalFish = fish as Animal
            animalFish.name = "Stue"
        }
    }
}

//keyword as? used for a safer way of performing down casting. Better use when you're unsure if it will be casted into needed Data Type
if let fish = neighbours[1] as? Fish {
    fish.breatheUnderWater()
} else {
    print("Casting has failed")
}

findNemo(from: neighbours)

//Any, AnyObject, NSObject
let igor = Humans(n: "Igor")
let kirill = Humans(n: "Kirill")
let amount: NSNumber = 13
let wordy: NSString = "OGO"

/* Any allows us to mix classes, structs or any other Data Type. We can't add an amount object to the array because there is no commonality between the object. They have to be with the same Data type.
let friends = [igor, kirill, amount]
We can fix that with specifying an [Any] type to the array: */
let friends: [Any] = [igor, kirill, amount]

/* AnyObject limits the types to those that only came from classes. So if we will change the array type to AnyObject, constant amount will be out of play because Integer is a struct:
 let friends: [AnyObject] = [igor, kirill, amount] */

/* NSObject limits to use classes only from Foundation (created by Apple). So if we will create an amount as "NSNumber" object it can be allowed to store on the NSObject array, but not the igor or kirill, because they have a custom Data Type:
 let friends: [NSObject] = [igor, kirill, amount, wordy]
 */

let defaults = UserDefaults.standard

let lastVisit = "AppLastOpenedByUser"

//Save Data in UserDefaults
defaults.set(0.25, forKey: "Volume")
defaults.set(true, forKey: "MusicOn")
defaults.set("Igor", forKey: "UserName")
defaults.set(Date(), forKey: lastVisit)
let arrayUD = [1,2,3]
defaults.set(array, forKey: "myArray")
let dictionary = ["name": "Igor"]
defaults.set(dictionary, forKey: "myDictionary")

//Retrieve Data from UserDefaults
let volume = defaults.float(forKey: "Volume")
let appLastOpen = defaults.object(forKey: lastVisit)
let myArray = defaults.array(forKey: "myArray") as! [Int]
let myDictionary = defaults.dictionary(forKey: "myDictionary")

//Observed Property
var pizzaInInches : Int = 10 {
    willSet {
        /*Access to old value
         print(pizzaInInches)
         Access to new value
         print(newValue)*/
        print("someone is going to change inches on \(newValue)")
    }
    didSet {
        /*Access to old value
         print(oldValue)
         Access to new value
         print(pizzaInInches)*/
        if pizzaInInches >= 18 {
            print("Invalid size specified, pizzaInInches set to 18.")
            pizzaInInches = 18
        }
    }
}
pizzaInInches = 30

var numberOfPeople: Int = 12
let slicesPerPerson: Int = 4
//Computed Property
var numberOfSlices: Int {
//Full version of a Getter
    get {
        return pizzaInInches - 4
    }
//Full version of a Setter
    set {
        print("numberOfSlices is now has a value of \(newValue)")
    }
}
/*Tap into Getter
 let a = numberOfSlices/2
 Set the value to trigger Setter
 numberOfSlices = 12*/
var numberOfPizza : Int {
    get {
        let numberOfPeopleFedPerPizza = numberOfSlices/slicesPerPerson
        return numberOfPeople/numberOfPeopleFedPerPizza
    }
    set {
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices/slicesPerPerson
    }
}
//Change the value of Computed Property to trigger the Setter
numberOfPizza = 2
print(numberOfPeople)

//Computed Property Challenge (Paint Calculator)
var width: Float = 1.5
var height: Float = 2.3

var bucketsOfPaint: Int {
    get {
        let totalWallSquareMeters: Float = width * height
        let squareMetersPerBucket: Float = 1.5
        let numberOfBuckets = totalWallSquareMeters/squareMetersPerBucket
        let roundedBuckets = ceilf(numberOfBuckets)
        return Int(roundedBuckets)
    }
    set {
        let squareMetersPerBucket = 1.5
        let squareMetersToPaint = Double(newValue) * squareMetersPerBucket
        print("This amount of paint can cover \(squareMetersToPaint) square meters")
    }
}
print(bucketsOfPaint)
bucketsOfPaint = 7

//Tuples
let touple1 = ("Angela", 12)
let touple2 = (name: "Angela", age: 12)
let touple3: (name: String, age: Int)
touple3.name = "Angela"
touple3.age = 13
print(touple3.name)
