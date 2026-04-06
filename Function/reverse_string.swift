// to reverse a string

func rev_str(n:String)->String{
    var temp=""
    for i in 0...n.count-1{
        temp=n[i]+temp
        print(temp) 
        

    }
    return temp

}
print(rev_str(n:"kartik"))