class Volunteer {
  String? id;
  String namaKegiatan;
  String deskripsi;
  String lokasi;
  String tanggal;

  Volunteer({
    this.id,
    required this.namaKegiatan,
    required this.deskripsi,
    required this.lokasi,
    required this.tanggal,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json, String id) {
    return Volunteer(
      id: id,
      namaKegiatan: json['nama_kegiatan'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      lokasi: json['lokasi'] ?? '',
      tanggal: json['tanggal'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kegiatan': namaKegiatan,
      'deskripsi': deskripsi,
      'lokasi': lokasi,
      'tanggal': tanggal,
    };
  }
}
