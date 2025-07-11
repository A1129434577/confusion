///生成30个不需要导入任何库的dart类并加上@pragma('vm:entry-point')注解
@pragma('vm:entry-point')
class APerson {
  final String name;
  final int age;

  APerson(this.name, this.age);
}

@pragma('vm:entry-point')
class APoint {
  final double x;
  final double y;

  APoint(this.x, this.y);
}

@pragma('vm:entry-point')
class ARectangle {
  final double width;
  final double height;

  ARectangle(this.width, this.height);

  double get area => width * height;
}

@pragma('vm:entry-point')
class ACalculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
}

@pragma('vm:entry-point')
class ACar {
  String make;
  String model;
  int year;

  ACar(this.make, this.model, this.year);
}

@pragma('vm:entry-point')
class ABook {
  final String title;
  final String author;

  ABook(this.title, this.author);
}

@pragma('vm:entry-point')
class AStudent {
  String name;
  int grade;

  AStudent(this.name, this.grade);
}

@pragma('vm:entry-point')
class ACircle {
  final double radius;

  ACircle(this.radius);

  double get area => 3.14159 * radius * radius;
}

@pragma('vm:entry-point')
class AAnimal {
  String name;

  AAnimal(this.name);

  void makeSound() {}
}

@pragma('vm:entry-point')
class ADog extends AAnimal {
  ADog(String name) : super(name);

  @override
  void makeSound() {}
}

@pragma('vm:entry-point')
class ACat extends AAnimal {
  ACat(String name) : super(name);

  @override
  void makeSound() {}
}

@pragma('vm:entry-point')
class ABankAccount {
  double balance = 0;

  void deposit(double amount) => balance += amount;
  void withdraw(double amount) => balance -= amount;
}

@pragma('vm:entry-point')
class ATemperature {
  double celsius;

  ATemperature(this.celsius);

  double get fahrenheit => celsius * 9 / 5 + 32;
}

@pragma('vm:entry-point')
class AProduct {
  final String id;
  final String name;
  final double price;

  AProduct(this.id, this.name, this.price);
}

@pragma('vm:entry-point')
class AShoppingCart {
  final List<AProduct> items = [];

  void addItem(AProduct product) => items.add(product);
  double get total => items.fold(0, (sum, item) => sum + item.price);
}

@pragma('vm:entry-point')
class AUser {
  String username;
  String email;

  AUser(this.username, this.email);
}

@pragma('vm:entry-point')
class AAddress {
  final String street;
  final String city;
  final String zipCode;

  AAddress(this.street, this.city, this.zipCode);
}

@pragma('vm:entry-point')
class AEmployee {
  final String name;
  final String position;
  final double salary;

  AEmployee(this.name, this.position, this.salary);
}

@pragma('vm:entry-point')
class ADate {
  final int day;
  final int month;
  final int year;

  ADate(this.day, this.month, this.year);
}

@pragma('vm:entry-point')
class ATime {
  final int hour;
  final int minute;
  final int second;

  ATime(this.hour, this.minute, this.second);
}

@pragma('vm:entry-point')
class AContact {
  final String name;
  final String phone;

  AContact(this.name, this.phone);
}

@pragma('vm:entry-point')
class AMessage {
  final String content;
  final DateTime timestamp;

  AMessage(this.content, this.timestamp);
}

@pragma('vm:entry-point')
class AColor {
  final int red;
  final int green;
  final int blue;

  AColor(this.red, this.green, this.blue);
}

@pragma('vm:entry-point')
class AFraction {
  final int numerator;
  final int denominator;

  AFraction(this.numerator, this.denominator);
}

@pragma('vm:entry-point')
class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

@pragma('vm:entry-point')
class AQueue<T> {
  final List<T> _items = [];

  void enqueue(T item) => _items.add(item);
  T dequeue() => _items.removeAt(0);
}

@pragma('vm:entry-point')
class AStack<T> {
  final List<T> _items = [];

  void push(T item) => _items.add(item);
  T pop() => _items.removeLast();
}

@pragma('vm:entry-point')
class ACounter {
  int _count = 0;

  int get count => _count;
  void increment() => _count++;
  void reset() => _count = 0;
}

@pragma('vm:entry-point')
class ALogger {
  void log(String message) {}
}

@pragma('vm:entry-point')
class AConfig {
  static const String appName = "MyApp";
  static const String version = "1.0.0";
}

@pragma('vm:entry-point')
class AMathUtils {
  static int max(int a, int b) => a > b ? a : b;
  static int min(int a, int b) => a < b ? a : b;
}