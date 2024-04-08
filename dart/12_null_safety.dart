class Animal{
  String name = "Dog";

  void display(){
    print(name);
  }
}

void main(){
  String? name ;
  print(name); // This doesnot work if (String name) is used

  Animal an  = new Animal();
  print(an.name);  // This doesnot work if (Animal an) is used, it must be assigned with new Animal()
  Animal? animal;
  print(animal!.name); //This works '!' says animal can never be null in future
  //To make nullable variable we use : ?, late 
}