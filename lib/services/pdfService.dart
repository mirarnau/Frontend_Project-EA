
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/pages/pdfViewerPage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PDFService {

  Future<String> loadFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);
  }

  static Future<String> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await DownloadsPathProvider.downloadsDirectory;
    final downloadsFolder = dir!.path + '/$filename';

    var status = await Permission.storage.status;
      if (status.isGranted) {
        await Permission.storage.request();
        try {
          await Dio().download(
              url, 
              downloadsFolder,
              onReceiveProgress: (received, total) {
                  if (total != -1) {
                      print((received / total * 100).toStringAsFixed(0) + "%");
                      //you can build progressbar feature too
                  }
                });
            print("File is saved to download folder.");  
        } on DioError catch (e) {
          print(e.message);
        }
      }
      else{
        print ('No permissions');
      }

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return downloadsFolder;
  }

  void openPDF(BuildContext context, String file) 
    => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PDFViewerPage(pdfFile: file))
    ); 


  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf']
    );

    if (result == null) return null;
    return File(result.paths.first as String);

  }
}

