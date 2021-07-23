import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/models/file.dart';
import 'package:file/network/action_connect.dart';
import 'package:file/network/file_connect.dart';
import 'package:file/network/list_connect.dart';
import 'package:file_picker/file_picker.dart';


class DocBloc {
  ListConnect _listConnect = ListConnect();
  ActionConnect _actionConnect = ActionConnect();
  int lastTimeStamp;
  List<FileInfo> _docList = List<FileInfo>();
  FileConnect _fileConnect = FileConnect();

  StreamController<List<FileInfo>> _docListStreamController =
      StreamController<List<FileInfo>>.broadcast();

  StreamSink<List<FileInfo>> get docListStreamSink =>
      _docListStreamController.sink;

  Stream<List<FileInfo>> get docListStream => _docListStreamController.stream;

  void getAllDocList() async {
    _docList = List<FileInfo>();
    Map<String, dynamic> mapBody = Map<String, dynamic>();
    mapBody['type'] = "document";
    _actionConnect
        .sendActionPost(mapBody, ActionConnect.fileList)
        .then((dynamic mapResponse) {
      List<dynamic> dynamicList = mapResponse as List<dynamic>;
      dynamicList.map((i) => _docList.add(FileInfo.docJSON(i))).toList();
      docListStreamSink.add(_docList);
    });
  }

  void dispose() {
    _docListStreamController.close();
  }
}
