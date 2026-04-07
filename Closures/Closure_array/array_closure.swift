// to double the number in a array and return the array 

var arr=[1,2,3,4,5]

let double=arr.map{$0*2}


print(double)
// here we used the short $0 becasue there is only one parameter 


// to sort the array using the closure and short handing that 


var arr1=[90,89,56,23,12]

let sorted=arr1.sorted{$0<$1}

print(sorted)




// sort a array using closure 

var arr3=[90,28,4444,011,34,4]
let sort=arr3.sorted{$0<$1}
print(sort)