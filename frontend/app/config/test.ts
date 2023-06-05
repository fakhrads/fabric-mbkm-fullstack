interface Person {
  name: string;
  age: number;
}

class Student implements Person {
  name: string;
  age: number;
  grade: string;

  constructor(name: string, age: number, grade: string) {
    this.name = name;
    this.age = age;
    this.grade = grade;
  }

  displayDetails(): void {
    console.log(`Name: ${this.name}`);
    console.log(`Age: ${this.age}`);
    console.log(`Grade: ${this.grade}`);
  }

  celebrateBirthday(): void {
    this.age++;
    console.log(`${this.name} is now ${this.age} years old.`);
  }
}

const student1: Student = new Student("John", 16, "10th");
student1.displayDetails();
student1.celebrateBirthday();