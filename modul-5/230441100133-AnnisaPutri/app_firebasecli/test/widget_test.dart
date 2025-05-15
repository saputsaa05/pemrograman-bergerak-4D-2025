import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_firebasecli/screens/volunteer_list.dart';

void main() {
  testWidgets('VolunteerList is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: VolunteerList(),
      ),
    );

    // Periksa apakah AppBar dengan teks 'Daftar Kegiatan' muncul
    expect(find.text('Daftar Kegiatan'), findsOneWidget);
  });
}
