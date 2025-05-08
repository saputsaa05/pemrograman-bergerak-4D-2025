import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/volunteer.dart';

class VolunteerService {
  static const baseUrl = 'https://kegiatannvolunteer-default-rtdb.asia-southeast1.firebasedatabase.app/volunteer';

  Future<List<Volunteer>> getAllVolunteers() async {
    final response = await http.get(Uri.parse('$baseUrl.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>?;
      if (data == null) return [];
      return data.entries.map((e) => Volunteer.fromJson(e.value, e.key)).toList();
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<void> addVolunteer(Volunteer volunteer) async {
    await http.post(
      Uri.parse('$baseUrl.json'),
      body: json.encode(volunteer.toJson()),
    );
  }

  Future<void> updateVolunteer(Volunteer volunteer) async {
    await http.put(
      Uri.parse('$baseUrl/${volunteer.id}.json'),
      body: json.encode(volunteer.toJson()),
    );
  }

  Future<void> deleteVolunteer(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id.json'));
  }
}
