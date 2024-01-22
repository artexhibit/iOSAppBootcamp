
//Initialising the Class
let skeleton1 = Enemy(health: 100, attackStrength: 10)

//Access to properties and methods of the Class
print(skeleton1.health)
skeleton1.move()

//Initialising more objects with the same properties from the Class
let skeleton2 = Enemy(health: 120, attackStrength: 40)

//Initialising an object from Enemy SubClass "Dragon"
let dragon = Dragon(health: 200, attackStrength: 20)

//Access to all SuperClass(Enemy) properties from SubClass and uniquely created already from Dragon
dragon.wingSpan = 5
dragon.attackStrength = 15
dragon.talk(speech: "My teeth are swords!")
dragon.move()
dragon.attack()

/*Classes are passed by reference. In below case we didn't create a new object in skeleton3 but just made a reference to skeleton1. Every action with skeleton 1 or 3 will affect on both of them equally*/
 
let skeleton3 = skeleton1
skeleton1.takeDamage(amount: 10)
skeleton3.takeDamage(amount: 10)

print(skeleton1.health)

/*If you want to create a new object then you should fully initialise it:
let skeleton1 = Enemy(health: 100, attackStrength: 10)
let skeleton3 = Enemy(health: 100, attackStrength: 10)*/
