enum EmployeeType {
  Boss,
  Worker,
  HR,
}

abstract class Employee {
  void work();
  // 1-way to implement factory pattern
  // factory Employee(String type) {
  //   switch (type) {
  //     case 'Worker':
  //       return Worker();
  //     case 'HR':
  //       return HR();
  //     case 'Boss':
  //       return Boss();
  //     default:
  //       throw Exception();
  //   }
  // }
}

class Worker implements Employee {
  @override
  void work() {
    print("Worker is working");
  }
}

class HR implements Employee {
  @override
  void work() {
    print("HR is not Working");
  }
}

class Boss implements Employee {
  @override
  void work() {
    print("Boss is working");
  }
}

class EmployeeFactory {
  static Employee getEmployee(EmployeeType type) {
    switch (type) {
      case EmployeeType.Worker:
        return Worker();
      case EmployeeType.HR:
        return HR();
      case EmployeeType.Boss:
        return Boss();
    }
  }
}
