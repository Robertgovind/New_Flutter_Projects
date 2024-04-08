//operators: + - * / %
void main(){
  int num1 = 12;
  double num2 = 2.333;
  var res = num1+num2;
  print(res);

  //parsing a number
  var n = num.parse('123');
  var d = num.parse('123.333');
  print(d);
  print(n);

  print(n.isFinite);
}