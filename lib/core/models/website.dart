import 'package:get/get.dart';

class Website {
  final String name;
  final String url;
  final String author;
  RxString status;
  final bool initStatus;
  final String zipPath;

  Website({
    required this.name,
    required this.url,
    required this.author,
    required String status,
    required this.initStatus,
    required this.zipPath,
  }) : status = status.obs;

  factory Website.fromJson(Map<String, dynamic> json) {
    return Website(
      name: json['name'],
      url: json['application'],
      author: "admin",
      status: json['status'] ?? 'Unknown',
      initStatus: json['init_status'] ?? false,
      zipPath: '',
    );
  }
}
