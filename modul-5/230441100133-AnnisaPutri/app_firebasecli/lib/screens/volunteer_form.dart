import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerForm extends StatefulWidget {
  @override
  _VolunteerFormState createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Kegiatan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ...['nama_kegiatan', 'lokasi', 'tanggal', 'deskripsi'].map((field) {
                return TextFormField(
                  decoration: InputDecoration(labelText: field),
                  onSaved: (val) => formData[field] = val,
                  validator: (val) => val == null || val.isEmpty ? 'Wajib diisi' : null,
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await FirebaseFirestore.instance
                        .collection('kegiatan_volunteer')
                        .add(formData);
                    Navigator.pop(context);
                  }
                },
                child: Text("Simpan"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
