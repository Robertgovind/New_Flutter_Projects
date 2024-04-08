//Synchronous programming : executes in instant time
//Aynchronous prohramming : which has delay , it is also called futures or async


Future printFuture()async{
  await Future.delayed(Duration(seconds: 5)).whenComplete(() => print("Future printed"));
}
void main() async{
  
  await printFuture();  //watis until works done
  //Async while fetching data from API it may take some time
  //async, await keywords
  print("My name is Govind"); //instantly

   printFuture();// doesnot waits
}