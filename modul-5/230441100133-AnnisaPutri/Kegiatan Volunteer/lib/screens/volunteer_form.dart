import 'package:flutter/material.dart';
import '../models/volunteer.dart';
import '../services/volunteer_service.dart';

class VolunteerForm extends StatefulWidget {
  final Volunteer? volunteer;
  const VolunteerForm({super.key, this.volunteer});

  @override
  State<VolunteerForm> createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaKegiatanController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _tanggalController = TextEditingController();

  final service = VolunteerService();

  @override
  void initState() {
    super.initState();
    if (widget.volunteer != null) {
      _namaKegiatanController.text = widget.volunteer!.namaKegiatan;
      _deskripsiController.text = widget.volunteer!.deskripsi;
      _lokasiController.text = widget.volunteer!.lokasi;
      _tanggalController.text = widget.volunteer!.tanggal;
    }
  }

  @override
  void dispose() {
    _namaKegiatanController.dispose();
    _deskripsiController.dispose();
    _lokasiController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final volunteer = Volunteer(
        id: widget.volunteer?.id,
        namaKegiatan: _namaKegiatanController.text,
        deskripsi: _deskripsiController.text,
        lokasi: _lokasiController.text,
        tanggal: _tanggalController.text,
      );
      if (widget.volunteer == null) {
        await service.addVolunteer(volunteer);
      } else {
        await service.updateVolunteer(volunteer);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.volunteer != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Kegiatan Volunteer' : 'Tambah Kegiatan Volunteer',
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal[50], // Latar belakang dengan warna teal muda
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaKegiatanController,
                decoration: InputDecoration(
                  labelText: 'Nama Kegiatan',
                  prefixIcon: Icon(Icons.work_outline, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  prefixIcon: Icon(Icons.description, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _lokasiController,
                decoration: InputDecoration(
                  labelText: 'Lokasi',
                  prefixIcon: Icon(Icons.location_on, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _tanggalController,
                decoration: InputDecoration(
                  labelText: 'Tanggal',
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors
                          .teal, // Mengganti 'primary' dengan 'backgroundColor'
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isEditing ? 'Update' : 'Simpan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
