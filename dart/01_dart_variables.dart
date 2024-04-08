//Dart variables
void main(){
  var name = "Govind";   
  print(name);
  int n = 5;
  print(n);

  final num = 5;
  //num=2;   can't be assigned a new value 

  const num1=0;
  //num2=9;  can't be assigned a new value once assigned

  String? str; //to say compilier that value will be given later for null safety
  late String names; //for null safety
  str = "govind";
  names = "ram,sita,siva";
  print(str);
  print(name);
}