// check the largest of 3 number 


func check_largest(n1:Int,n2:Int,n3:Int)->String{
    if n1>n2 && n1>n2{
        return "n1 is the largest ",n1;
    }
    else if n2>n1 && n2>n3{
        return "n2 is the largest ",n2;
    }
    else {
        return "n3 is the largest ",n3;
    }
}

print(check_largest(n1:20,n2:50,n3:9))