// optionals

var name:String?="kartik"
name=nil


print(name!)

// this will not work we need to wrap it 

// 1. we can use the ! after the variable name but it is not recommended to do that



// 2.. use of let safename==name

if let safename = name{
    print(safename)
}   // only runs if the value exist 