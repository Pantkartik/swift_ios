// struct is a datatype used for the declaration of closures 
struct Person{
    var name:String
}

var p1=Person(name:"KARTIK")
var p2=p1
p2.name="Pant"

print("unchanged the value of p1",p1.name)
print("p1 template for the person is used for p2",p2.name)


struct Car 