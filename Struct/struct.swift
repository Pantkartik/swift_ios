// struct is a datatype used for the declaration of closures 
struct Person{
    var name:String
}

var p1=Person(name:"KARTIK")
var p2=p1
p2.name="Pant"

print(p1.name)
print(p2.name)