import 'dart:io';
import 'package:flutter/src/material/time.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter_project/models/appointment.dart';
import 'dart:convert';
import '../models/doctor.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';
  static String? _token;
  
  static var appointment;

  static void setToken(String token) {
    _token = token;
  }

  static Map<String, String> get _headers {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: _headers,
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      setToken(data['token']);
      return data;
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setToken(data['token']);
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }
 static Future<Map<String, dynamic>> doctorSignup(String name, String email, String password, String specialization) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/doctor/register'),
      headers: _headers,
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'specialization': specialization,
        'experience': '5 years',
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      setToken(data['token']);
      return data;
    } else {
      throw Exception('Failed to sign up doctor: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> doctorLogin(String email, String password) async {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/auth/doctor/login'), // Updated to match registration pattern
          headers: _headers, // Use the common headers
          body: json.encode({
            'email': email,
            'password': password,
          }),
        );
  
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
  
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setToken(data['token']);
          return data;
        } else {
          final error = json.decode(response.body);
          throw Exception(error['message'] ?? 'Invalid credentials');
        }
      } catch (e) {
        print('Login error: $e');
        throw Exception('Invalid credentials');
      }
    }

  static Future<List<Map<String, dynamic>>> getDoctorAppointments() async {
    final response = await http.get(
      Uri.parse('$baseUrl/doctor/appointments'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  static Future<List<Map<String, dynamic>>> getDoctors() async {
    final response = await http.get(
      Uri.parse('$baseUrl/doctor/appointments'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  static Future<void> updateAppointmentStatus(
    int appointmentId,
    String newStatus,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/appointments/$appointmentId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update appointment status');
    }
  }

  // Update the bookAppointment method
  static Future<void> bookAppointment(
    int doctorId,
    DateTime appointmentDate,
    String appointmentTime,
    String reason,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/appointments/book'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await getToken()}'
      },
      body: json.encode({
        'doctorId': doctorId,
        'appointmentDate': DateFormat('yyyy-MM-dd').format(appointmentDate),
        'appointmentTime': appointmentTime,
        'reason': reason,
      }),
    );
  
    if (response.statusCode != 201) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Failed to book appointment');
    }
  }
  
  // Add method to fetch user appointments
  static Future<List> getUserAppointments() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/appointments/user-appointments'),
      headers: {
        'Authorization': 'Bearer ${await getToken()}'
      },
    );
  
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['appointments'];
      return data.map((json) => appointment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  static Future<void> updateAppointment(
    int appointmentId,
    DateTime startDateTime,
    DateTime endDateTime,
    String type,
    String? notes,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/appointments/$appointmentId'),
      headers: _headers,
      body: json.encode({
        'startDateTime': startDateTime.toIso8601String(),
        'endDateTime': endDateTime.toIso8601String(),
        'type': type,
        'notes': notes,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update appointment');
    }
  }

  static Future<void> deleteAppointment(int appointmentId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/appointments/$appointmentId'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete appointment');
    }
  }

  static Future<List<Map<String, dynamic>>> getUserappointments(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/appointments/user/$userId'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load appointments');
    }
  }
  static Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['error']);
    }
  }

  static Future<void> resetPassword(String token, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'token': token, 'newPassword': newPassword}),
    );

    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['error']);
    }
  }

  static addDoctorWithImage(
    String text,
    String text2,
    int parse,
    File? imageFile,
  ) {}

  static rescheduleAppointment(int appointmentId, DateTime dateTime, String s) {}

  static cancelAppointment(int id) {}
}

getToken() {
}

class DateFormat {
  DateFormat(String s);
  
  format(DateTime appointmentDate) {}
}
