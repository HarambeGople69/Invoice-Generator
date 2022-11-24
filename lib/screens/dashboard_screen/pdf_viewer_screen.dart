import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFviewerScreen extends StatefulWidget {
  final File file;
  final String url;
  final bool value;
  const PDFviewerScreen(
      {super.key, required this.file, required this.value, required this.url});

  @override
  State<PDFviewerScreen> createState() => _PDFviewerScreenState();
}

class _PDFviewerScreenState extends State<PDFviewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: widget.value == false
            ? SfPdfViewer.file(widget.file)
            : SfPdfViewer.network(
                widget.url,
              ),
      ),
    );
  }
}
