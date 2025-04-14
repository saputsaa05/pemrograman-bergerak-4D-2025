dynamic studentInfo() {
  var name = "Annisa Putri";  
  var favNumber = 7;          
  var isPraktikan = true;

  return [name, favNumber, isPraktikan];

  // End of TODO 1
  return [name, favNumber, isPraktikan];
}

dynamic circleArea(num r) {
  if (r < 0) {
    return 0.0;
  } else {
    const double pi = 3.1415926535897932;
    return pi * r * r;
  }
}

    // End of TODO 2

int? parseAndAddOne(String? input) {
  // Periksa apakah input null
  if (input == null) {
    return null;
  }

  try {
    // Konversi input ke integer dan tambahkan 1
    int number = int.parse(input);
    return number + 1;
  } catch (e) {
    // Jika terjadi error, lempar Exception dengan pesan yang sesuai
    throw Exception('Input harus berupa angka');
  }
}

  // End of TODO 3