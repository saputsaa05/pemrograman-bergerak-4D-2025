import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/volunteer.dart';

class VolunteerService {
  static const baseUrl = 'http://172.16.14.245/VOLUNTEER_API';

  Future<List<Volunteer>> getAllVolunteers() async {
    final response = await http.get(Uri.parse('$baseUrl/get.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>?;
      if (data == null) return [];
      return data
          .map(
            (e) => Volunteer.fromJson(
              e as Map<String, dynamic>,
              e['id'].toString(),
            ),
          )
          .toList();
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<void> addVolunteer(Volunteer volunteer) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/post.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(volunteer.toJson()),
      );

      // Debug log
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] != true) {
          throw Exception(data['message'] ?? 'Gagal menambah data');
        }
      } else {
        throw Exception('Gagal menghubungi server (${response.statusCode})');
      }
    } catch (e) {
      print('Error saat addVolunteer: $e');
      rethrow; // lempar ulang jika mau ditangani di UI
    }
  }

  Future<void> updateVolunteer(Volunteer volunteer) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/put.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(volunteer.toJson()),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Gagal menghubungi server (${response.statusCode})');
      }

      final data = json.decode(response.body);
      if (data['error'] == true) {
        throw Exception(data['message'] ?? 'Update gagal');
      }
    } catch (e) {
      print('Error saat updateVolunteer: $e');
      rethrow;
    }
  }

  Future<void> deleteVolunteer(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/delete.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );
  }
}
