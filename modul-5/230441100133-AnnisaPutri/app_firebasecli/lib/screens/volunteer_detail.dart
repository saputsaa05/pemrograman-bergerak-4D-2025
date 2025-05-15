import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerDetailPage extends StatelessWidget {
  final String id;
  VolunteerDetailPage({required this.id});

  // Fungsi untuk konversi manual dari DateTime ke format: 14 Mei 2025
  String formatTanggal(dynamic tanggalData) {
    if (tanggalData == null) return '-';

    try {
      DateTime date;
      if (tanggalData is Timestamp) {
        date = tanggalData.toDate();
      } else if (tanggalData is String) {
        date = DateTime.tryParse(tanggalData) ?? DateTime.now();
      } else {
        return tanggalData.toString();
      }

      const bulan = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];

      return '${date.day} ${bulan[date.month - 1]} ${date.year}';
    } catch (e) {
      return tanggalData.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final docRef =
        FirebaseFirestore.instance.collection('volunteer').doc(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kegiatan"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: docRef.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Terjadi kesalahan."));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Data tidak ditemukan."));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Card(
                margin: const EdgeInsets.all(20),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(Icons.volunteer_activism,
                            size: 60, color: Colors.teal),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data['nama_kegiatan'] ?? '-',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.teal),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              data['lokasi'] ?? '-',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.teal),
                          const SizedBox(width: 8),
                          Text(
                            formatTanggal(data['tanggal']),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Deskripsi:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['deskripsi'] ?? '-',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
