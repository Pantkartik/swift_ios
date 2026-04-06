// same as function in javascript 

func greet(name:String){
    print("Hello this is a greeting function in swift ")
}

greet(name:"kartik") // function call 

func calc(n1:Int,n2:Int){
    print("The sum : ",n1+n2)
}

calc(n1:10,n2:20)


func arrow(n1:String,n2:String)->String{
    return n1+" "+n2;
}

print(arrow(n1:"kartik",n2:"pant"))
