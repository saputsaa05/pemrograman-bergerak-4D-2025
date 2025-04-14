dynamic oddOrEven(int number) {
  // Cek apakah bilangan genap atau ganjil
  return (number % 2 == 0) ? "Genap" : "Ganjil";
}
  // End of TODO 1


dynamic createListOneToX(int x) {
  final List<int> list = [];

  if (x < 1) {
    return list; // Mengembalikan list kosong jika x < 1
  }

  for (int i = 1; i <= x; i++) {
    list.add(i);
  }

  return list;
}


  // TODO 2

  // End of TODO 2

String getStars(int n) {
  var result = '';

  // Loop dari n ke 1
  for (int i = n; i > 0; i--) {
    result += '*' * i + '\n';
  }

  return result;
}
  // TODO 3

  // End of TODO 3