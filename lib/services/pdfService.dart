import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/config.dart';
import 'package:flutter_tutorial/models/dish.dart';
import 'package:flutter_tutorial/pages/pdfViewerPage.dart';
import 'package:http/http.dart' as http;

class PDFService {

  void openPDF(BuildContext context, File file) 
    => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PDFViewerPage(pdfFile: file))
    ); 


  Future<File> loadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf']
    );

    //if (result == null) return null;
    return File(result?.paths.first as String);

  }
}

