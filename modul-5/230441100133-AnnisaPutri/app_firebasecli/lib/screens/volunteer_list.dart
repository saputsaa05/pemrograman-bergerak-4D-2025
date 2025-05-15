import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'volunteer_detail.dart';
import 'volunteer_form.dart';

class VolunteerList extends StatefulWidget {
  const VolunteerList({super.key});

  @override
  State<VolunteerList> createState() => _VolunteerListState();
}

class _VolunteerListState extends State<VolunteerList> {
  final CollectionReference _volunteerRef =
      FirebaseFirestore.instance.collection('volunteer');

  void openDetailPage(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VolunteerDetailPage(id: id),
      ),
    ).then((_) => setState(() {})); // Refresh ketika kembali
  }

  void deleteVolunteer(String id) async {
    try {
      await _volunteerRef.doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil menghapus data')),
      );
      setState(() {}); // Refresh setelah hapus
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Kegiatan Volunteer (Firestore)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          // Stream real-time data dari Firestore
          stream: _volunteerRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Saat loading data
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              // Jika terjadi error
              return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              // Jika data kosong
              return const Center(
                child: Text(
                  'Belum ada data kegiatan volunteer.',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              );
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, i) {
                final doc = docs[i];
                final data = doc.data()! as Map<String, dynamic>;
                final id = doc.id;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => openDetailPage(id),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
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
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['nama_kegiatan'] ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 16, color: Colors.teal),
                                    const SizedBox(width: 4),
                                    Text(data['lokasi'] ?? '-'),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16, color: Colors.teal),
                                    const SizedBox(width: 4),
                                    Text(data['tanggal']?.toString() ?? '-'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  // Jika ingin edit, sebaiknya pakai VolunteerForm dengan id (buat update)
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => VolunteerForm(),
                                    ),
                                  );
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteVolunteer(id);
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
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => VolunteerForm()),
          );
          setState(() {}); // Refresh saat kembali dari form
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
