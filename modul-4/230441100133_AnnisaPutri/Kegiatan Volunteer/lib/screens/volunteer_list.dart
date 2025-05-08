import 'package:flutter/material.dart';
import '../models/volunteer.dart';
import '../services/volunteer_service.dart';
import 'volunteer_detail.dart';
import 'volunteer_form.dart';

class VolunteerList extends StatefulWidget {
  const VolunteerList({super.key});

  @override
  State<VolunteerList> createState() => _VolunteerListState();
}

class _VolunteerListState extends State<VolunteerList> {
  final service = VolunteerService();
  late Future<List<Volunteer>> futureVolunteers;

  @override
  void initState() {
    super.initState();
    futureVolunteers = service.getAllVolunteers();
  }

  void refresh() {
    setState(() {
      futureVolunteers = service.getAllVolunteers();
    });
  }

  void openDetailPage(Volunteer volunteer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VolunteerDetailPage(volunteer: volunteer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Kegiatan Volunteer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refresh,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<Volunteer>>(
          future: futureVolunteers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final v = data[i];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => openDetailPage(v),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.teal.shade100,
                              child: Icon(
                                Icons.volunteer_activism,
                                color: Colors.teal.shade800,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    v.namaKegiatan,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 16, color: Colors.teal),
                                      SizedBox(width: 4),
                                      Text(v.lokasi),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 16, color: Colors.teal),
                                      SizedBox(width: 4),
                                      Text(v.tanggal),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => VolunteerForm(volunteer: v),
                                      ),
                                    );
                                    refresh();
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    await service.deleteVolunteer(v.id!);
                                    refresh();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => VolunteerForm()),
          );
          refresh();
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}
