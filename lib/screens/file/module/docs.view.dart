import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file/network/user_connect.dart';
import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class DocumentsView extends StatefulWidget {
  String file;
  DocumentsView({this.file});
  @override
  _DocumentsViewState createState() => _DocumentsViewState();
}

class _DocumentsViewState extends State<DocumentsView> {
  String path;
  @override
  initState() {
    super.initState();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;
    return file.writeAsBytes(stream);
  }

  Future<Uint8List> fetchPost() async {
    final response = await http.get("${Connect.filesUrl}${widget.file}");
    final responseJson = response.bodyBytes;
    return responseJson;
  }

  loadPdf() async {
    writeCounter(await fetchPost());
    path = (await _localFile).path;
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Name'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              if (path != null)
                Container(
                  height: 600.0,
                  child: PdfViewer(
                    filePath: path,
                  ),
                )
              else
                Text("Pdf is not Loaded"),
              RaisedButton(
                child: Text("Load pdf"),
                onPressed: loadPdf,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
