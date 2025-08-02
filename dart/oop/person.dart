mixin Area {
  getArea();
}

abstract class Perimeter {
  getPerimeter();
}

class Circle extends Perimeter with Area {
  int radius;
  Circle(this.radius);

  @override
  getArea() {
    print('Area of circle is ${3.14 * radius * radius}');
  }

  @override
  getPerimeter() {
    print('Perimeter of circle is ${2 * 3.14 * radius}');
  }
}
