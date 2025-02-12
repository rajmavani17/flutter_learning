class Singleton {
  static Singleton? _instance;
  Singleton._internal();

  static Singleton getInstance() {
    if (_instance == null) {
      _instance ??= Singleton._internal();
    }
    return _instance!;
  }
}

class Singleton2 {
  static Singleton2? _instance;

  Singleton2._internal();

  static get instance {
    _instance ??= Singleton2._internal();
    return _instance;
  }
}

class Singleton3 {
  static Singleton3? _instance;

  Singleton3._internal();

  factory Singleton3() {
    if (_instance == null) {
      _instance = Singleton3._internal();
    }
    return _instance!;
  }
}
