int sum(int a , int b)  {
  return a+b;
}
void printName(String fname, {String? mName }){
  var str = "$fname $mName Yadav";
  print(str);
}

void main(){
  int a =4, b = 6;
  var c = sum(a,b);
  print(c);
  printName("Govind",mName:"Kumar");
}