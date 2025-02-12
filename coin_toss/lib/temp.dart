
Future<String> func() {

  return Future.delayed(Duration(microseconds: 5), () {
    return 'Hello';
  });
}
void main() {
  print(func());
  for(int i = 0; i < 10; i++) {
    print(i);
  }

}