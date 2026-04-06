//          for loop    //

var arr=[20,10,30,70]
var temp:Int=0

for i in 0..<arr.count-1{
    if(arr[i]<arr[i+1]){
        temp=arr[i];
        arr[i]=arr[i+1]
        arr[i+1]=temp;
    }
}


for i in 0..<arr.count{
    print(arr[i]);
}


// while loop 

var i=0
while i<=10{
    print(i)
    i+=1
}   