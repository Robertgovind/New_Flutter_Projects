class Student{
  late String name;
  String? roll;

  Student(this.name,this.roll){}

  void display(){
    print(name);
    print(roll);
  }
}

class Animal{
  String? animalName;
  Animal(this.animalName){}
  void displayAnimal(){
    print("I am an animal");
    print("I am a $animalName");
  }
  
}

class Dog extends Animal{
  Dog(): super("Dog"); //super 
  void display(){
    print("I am a dog");
  }
}

void  main(){
  Student st = new Student("Govind kr Yadav", "WRC078BEI015");
  st.display();

  Dog d = new Dog();
  d.displayAnimal();
  d.display();
}