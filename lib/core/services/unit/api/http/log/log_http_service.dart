import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:msf/core/services/unit/api/HttpService.dart';
import '../../config/Config.dart';

class LogHttpService {

  //Fixing error late init..
  late HttpService _httpService;
  void setHttpService(HttpService service) {
    _httpService = service;
  }
  Future<bool> clearAuditLogs() async {
    String url = '${Config.httpAddress}/waf/clear_audit_logs/';
    try {
      final headers = _getHeaders();
      print('Clearing audit logs with headers: $headers');
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      print('Clear audit logs response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData['status'] == 'success';
      } else {
        print("Failed to clear audit logs: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error clearing audit logs: $e");
      return false;
    }
  }
  Map<String, String> _getHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (_httpService.accessToken != null) headers['Authorization'] = 'Bearer ${_httpService.accessToken}';
    return headers;
  }
  Future<List<Map<String, dynamic>>> fetchNginxLogs() async {
    String url = '${Config.httpAddress}/nginx_log';
    try {
      final headers = _getHeaders();
      print('Fetching Nginx logs with headers: $headers');
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      print('Fetch Nginx logs response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(jsonData['logs'] ?? []);
      } else {
        print("Failed to fetch Nginx logs: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching Nginx logs: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchNginxLogSummary() async {
    String url = '${Config.httpAddress}/summery';
    try {
      final headers = _getHeaders();
      print('Fetching Nginx log summary with headers: $headers');
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print('Fetch Nginx log summary response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Map<String, dynamic>.from(jsonData['summary'] ?? {});
      } else {
        print("Failed to fetch Nginx log summary: ${response.body}");
        return {};
      }
    } catch (e) {
      print("Error fetching Nginx log summary: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchDailyTraffic() async {
    String url = '${Config.httpAddress}/traffic';
    try {
      final headers = _getHeaders();
      print('Fetching daily traffic with headers: $headers');
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print('Fetch daily traffic response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Map<String, dynamic>.from(jsonData['traffic'] ?? {});
      } else {
        print("Failed to fetch daily traffic: ${response.body}");
        return {};
      }
    } catch (e) {
      print("Error fetching daily traffic: $e");
      return {};
    }
  }
  Future<List<Map<String, dynamic>>> fetchAppLogs() async {
    try {
      final url = Uri.parse('${Config.httpAddress}/logs/app');
      final headers = _getHeaders();
      print('Fetching app logs with headers: $headers');
      final response = await http.get(
        url,
        headers: headers,
      );
      print('Fetch app logs response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(List<Map<String, dynamic>>.from(jsonData['logs'] ?? []));
        return List<Map<String, dynamic>>.from(jsonData['logs'] ?? []);
      } else {
        print("Failed to fetch app logs: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching app logs: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchLoginLogs() async {
    try {
      final url = Uri.parse('${Config.httpAddress}/logs/login');
      final headers = _getHeaders();
      print('Fetching login logs with headers: $headers');
      final response = await http.get(
        url,
        headers: headers,
      );
      print('Fetch login logs response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print(List<Map<String, dynamic>>.from(jsonData['logs'] ?? []));
        return List<Map<String, dynamic>>.from(jsonData['logs'] ?? []);
      } else {
        print("Failed to fetch login logs: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching login logs: $e");
      return [];
    }
  }

  Future<List<dynamic>> fetchWafLogs() async {
    String url = '${Config.httpAddress}/waf/show_audit_logs/';
    try {
      final headers = _getHeaders();
      print('Fetching WAF logs with headers: $headers');
      final response = await http.get(Uri.parse(url), headers: headers);
      print('Fetch WAF logs response: ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        var logs = jsonData['logs'] ?? [];
        if (logs is String) {
          return jsonDecode(logs);
        } else if (logs is List) {
          return logs;
        }
      }
      return [];
    } catch (e) {
      print("Error fetching WAF logs: $e");
      return [];
    }
  }

}