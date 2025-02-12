
class Prototype {
  String name;
  int age;
  String address;
  String number;
  Prototype({
    required this.name,
    required this.age,
    required this.address,
    required this.number,
  });
  Prototype clone() =>
      copyWith(name: name, age: age, address: address, number: number);

  Prototype copyWith({
    String? name,
    int? age,
    String? address,
    String? number,
  }) {
    return Prototype(
      name: name ?? this.name,
      age: age ?? this.age,
      address: address ?? this.address,
      number: number ?? this.address,
    );
  }
}
