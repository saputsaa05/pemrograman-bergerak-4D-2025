import 'package:flutter/material.dart';
import '../models/volunteer.dart';

class VolunteerDetailPage extends StatelessWidget {
  final Volunteer volunteer;

  const VolunteerDetailPage({Key? key, required this.volunteer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Kegiatan'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                volunteer.namaKegiatan,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.location_on, color: Colors.teal),
                        title: Text('Lokasi'),
                        subtitle: Text(volunteer.lokasi),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.calendar_today, color: Colors.teal),
                        title: Text('Tanggal'),
                        subtitle: Text(volunteer.tanggal),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Deskripsi Kegiatan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[700],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  volunteer.deskripsi,
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
