
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:path/path.dart';

import '../models/owner.dart';

class PDFViewerPage extends StatefulWidget {
    final File pdfFile;

  const PDFViewerPage({Key? key,  required this.pdfFile}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {


  @override
  void initState() { 
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text (widget.pdfFile.path),
      ),
      body: PDFView(
        filePath: widget.pdfFile.path

      ),
    );
  }
  
}
