import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:msf/core/models/website.dart';
import 'config/Config.dart';

class HttpService {
  String? sessionId;

  Future<void> login(String username, String password) async {
    String url = '${Config.httpAddress}/login';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['login_status'] == 'pending') {
          sessionId = jsonData['id'];
          String otp = jsonData['otp'];
          print("OTP sent: $otp, session id: $sessionId");
        } else {
          print("Unexpected login status: ${jsonData['login_status']}");
        }
      } else {
        print("Login failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during login request: $e");
    }
  }

  Future<bool> verifyOtp(int otp) async {
    String url = '${Config.httpAddress}/verify_otp';
    if (sessionId == null) {
      print("Session ID not found");
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'session_id': sessionId!, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['login_status'] == 'success') {
          print("Login success");
          return true;
        } else {
          print("Unexpected response: ${jsonData['login_status']}");
        }
      } else {
        print("OTP verification failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during OTP verification: $e");
    }
    return false;
  }

  Future<http.Response> uploadFile(String? filePath, String applicationName, List<int> fileBytes) async {
    try {
      final uri = Uri.parse('${Config.httpAddress}/upload');
      final request = http.MultipartRequest('POST', uri);

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: applicationName,
        contentType: MediaType.parse('application/zip'),
      ));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return response;
    } catch (e) {
      throw Exception('Error during file upload: $e');
    }
  }

  Future<http.Response> deployFile(String fileName) async {
    try {
      final url = Uri.parse('${Config.httpAddress}/deploy/$fileName');
      final response = await http.get(url);
      return response;
    } catch (e) {
      throw Exception('Error during deployment request: $e');
    }
  }

  Future<http.Response> getAppList() async {
    try {
      final url = Uri.parse('${Config.httpAddress}/app_list');
      final response = await http.get(url);
      return response;
    } catch (e) {
      throw Exception('Error during app list request: $e');
    }
  }
  Future<List<Website>> fetchAppList() async {
    try {
      final url = Uri.parse('${Config.httpAddress}/app_list');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> apps = jsonDecode(response.body)['applications'];
        return apps.map((data) => Website.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch applications');
      }
    } catch (e) {
      throw Exception('Error fetching applications: $e');
    }
  }

}
