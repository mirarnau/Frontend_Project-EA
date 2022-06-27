
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';



class PDFViewerPage extends StatefulWidget {
    final String pdfFile;

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
    final name = basename(widget.pdfFile);
    final text = '${indexPage + 1} of $pages';
    String errorMessage = "";
    return Scaffold(
      appBar: AppBar(
        title: Text (name),
        actions: [
          Center(child: Text(text))
        ],
      ),
      body: 
    
      PDFView(
          filePath: widget.pdfFile,
          onRender: (pages) => setState(() => this.pages = pages!),
          onViewCreated: (controller) =>
            setState(() => this.controller = controller),
          onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
          onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
          
        ),      
    );
  }
  
}
