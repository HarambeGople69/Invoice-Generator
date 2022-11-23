import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFviewerScreen extends StatefulWidget {
  final File file;
  const PDFviewerScreen({super.key, required this.file});

  @override
  State<PDFviewerScreen> createState() => _PDFviewerScreenState();
}

class _PDFviewerScreenState extends State<PDFviewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: SfPdfViewer.file(widget.file),
      ),
    );
  }
}