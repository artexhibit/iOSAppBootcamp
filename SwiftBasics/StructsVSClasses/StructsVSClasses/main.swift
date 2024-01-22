
import Foundation

var hero = ClassHero(name: "Iron Man", universe: "Marvel")
var anotherMarvelHero = hero
anotherMarvelHero.name = "The Hulk"

var avengers = [hero, anotherMarvelHero]
avengers[0].name = "Thor"

print(hero.name)
print(anotherMarvelHero.name)
print(avengers[0].name)

let heroOne = StructHero(name: "Snegovik", universe: "Skazki")
//Despite heroOne is a let, it's possible to change its properties because constant only points that we can't reassign it to another ClassHero object, but since ClassHero has variable initialisers we can still change it's properties. In case with structs they have a true immutability which won't let us change anything in a let heroOne properties
//heroOne.name = "Snegurochka"
//Not possible
//heroOne = ClassHero()
print(heroOne.reverseName())
