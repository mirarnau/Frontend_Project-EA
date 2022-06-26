
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_tutorial/models/restaurant.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:flutter_tutorial/widgets/restaurantWidget.dart';
import 'package:flutter_tutorial/services/ownerService.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



class PDFViewerPage extends StatefulWidget {
    final File pdfFile;

  const PDFViewerPage({Key? key,  required this.pdfFile}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  void initState() { 
  }

  @override
  Widget build(BuildContext context) { 
    final name = basename(widget.pdfFile.path);
    final text = '${indexPage + 1} of $pages';
    return Scaffold(
      appBar: AppBar(
        title: Text (name),
        actions: [
          Center(child: Text(text))
        ],
      ),
      body: 
      
      /*
      PDFView(
          filePath: widget.pdfFile.path,
          onRender: (pages) => setState(() => this.pages = pages!),
          onViewCreated: (controller) =>
            setState(() => this.controller = controller),
          onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
        ),
        */
    
      
      Container(
        child: SfPdfViewer.network('http://udltreball.udl.cat/export/sites/UdLTreball/ca/.galleries/Documents/p80.pdf')
      )
      
    );
  }
  
}
