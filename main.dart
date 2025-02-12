// import 'adapter_pattern.dart';
// import 'event_bus.dart';
// import 'factory_pattern.dart';
// import 'prototype_pattern.dart';
// import 'singleton_pattern.dart';


// import 'dart:async';


// void main() {
//   final eventBus1 = EventBus();
//   final eventBus2 = EventBus();

//   eventBus1.stream.listen((event) => print("Listener 1: $event"));
//   eventBus1.stream.listen((event) => print("Listener 2: $event"));

//   eventBus1.emit("Hello, Flutter!");

//   eventBus.stream.listen((event) {
//     print("Observer 1 received: $event");
//   });

//   // Observer 2
//   eventBus.stream.listen((event) {
//     print("Observer 2 received: $event");
//   });

//   // Emit events
//   eventBus.emit("Event A");
//   eventBus.emit("Event B");

//   // Employee obj1 = EmployeeFactory.getEmployee(EmployeeType.Worker);
//   // Employee obj2 = EmployeeFactory.getEmployee(EmployeeType.HR);
//   // Employee obj3 = EmployeeFactory.getEmployee(EmployeeType.Boss);
//   // obj1.work();
//   // obj2.work();
//   // obj3.work();

//   // Singleton obj4 = Singleton.getInstance();
//   // Singleton obj5 = Singleton.getInstance();
//   // print(obj4.hashCode);
//   // print(obj5.hashCode);

//   // Singleton2 obj6 = Singleton2.instance;
//   // Singleton2 obj7 = Singleton2.instance;

//   // print(obj6.hashCode);
//   // print(obj7.hashCode);

//   // Singleton3 obj8 = Singleton3();
//   // Singleton3 obj9 = Singleton3();

//   // print(obj8.hashCode);
//   // print(obj9.hashCode);

//   // Prototype p1 =
//   //     Prototype(name: 'Azure', age: 25, address: 'Ethernal', number: '2');

//   // Prototype p2 = p1.copyWith(name:'dragon');
//   // print(p1.name);
//   // print(p2.name);
//   // print(p1.age);
//   // print(p2.age);

  
//   // final PostApi api = PostApi();
  
//   // print(api.getPosts());
// }



void main() {
  Bulb bulb = LedBulb();
  bulb.turnOFF();
  bulb.turnON();
}

abstract interface class Bulb {
  void turnON();
  void turnOFF();
}


class IncandescentBulb implements Bulb {
  @override
  void turnOFF() {
    print("Incandesent Bulb Turn Off");
  }

  @override
  void turnON() {
    print("Incandescent bulb turn on");
  }
}

class LedBulb implements Bulb {
  @override
  void turnOFF() {
    print("Led bulb turn off");
  }

  @override
  void turnON() {
    print("Led bulb turn on");
  }
}
