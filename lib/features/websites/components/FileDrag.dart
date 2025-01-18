//The old widget:
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get.dart';
// import 'package:msf/features/controllers/websites/uploads/UploadController.dart';
// import 'package:msf/features/controllers/websites/website/websiteController.dart';
//
// class FileDrag extends StatefulWidget {
//   final double width;
//   final double height;
//   final ValueChanged<String?> onFileSelected;
//   final WebsiteController websiteController;
//
//   const FileDrag({
//     Key? key,
//     required this.width,
//     required this.height,
//     required this.onFileSelected,
//     required this.websiteController,
//   }) : super(key: key);
//
//   @override
//   _FileDragState createState() => _FileDragState();
// }
//
// class _FileDragState extends State<FileDrag> with SingleTickerProviderStateMixin {
//   bool isDragging = false;
//
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//   Future<void> pickFile() async {
//     if (kIsWeb) {
//       // Web-specific file picker logic
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['zip'],
//       );
//
//       if (result != null) {
//         final webFile = result.files.single;
//
//         // Get the file as bytes for web upload
//         List<int> fileBytes = webFile.bytes!;
//
//         // Here, you could upload the fileBytes directly or process them
//         String temporaryFilePath = webFile.name;  // You can use the file name
//
//         // Example: Call an upload method (make sure to modify it to support file bytes)
//         widget.onFileSelected(temporaryFilePath);  // Send the file name or other metadata
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: pickFile,
//       onTapDown: (_) => _controller.forward(),
//       onTapCancel: () => _controller.reverse(),
//       onTapUp: (_) => _controller.reverse(),
//       child: SizedBox(
//         width: widget.width,
//         height: widget.height,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             DragTarget<String>(
//               onWillAccept: (data) {
//                 setState(() {
//                   isDragging = true;
//                 });
//                 return true;
//               },
//               onAccept: (data) {
//                 pickFile();
//                 setState(() {
//                   isDragging = false;
//                 });
//               },
//               onLeave: (_) {
//                 setState(() {
//                   isDragging = false;
//                 });
//               },
//               builder: (context, candidateData, rejectedData) {
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: isDragging ? widget.width : widget.width * 0.9,
//                   height: isDragging ? widget.height : widget.height * 0.9,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: isDragging ? Colors.blue : Colors.transparent,
//                       width: 2,
//                     ),
//                   ),
//                   child: Center(
//                     child: const Text(
//                       'Drag Here or Tap',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
