import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/models/file.dart';
import 'package:file/network/action_connect.dart';
import 'package:file/network/file_connect.dart';
import 'package:file/network/list_connect.dart';
import 'package:file_picker/file_picker.dart';

import '../../models/email.dart';

class FevBloc {
  ListConnect _listConnect = ListConnect();
  ActionConnect _actionConnect = ActionConnect();
  int lastTimeStamp;
  List<FileInfo> _fevList = List<FileInfo>();
  FileConnect _fileConnect = FileConnect();

  StreamController<List<FileInfo>> _fevListStreamController =
      StreamController<List<FileInfo>>.broadcast();

  StreamSink<List<FileInfo>> get fevListStreamSink =>
      _fevListStreamController.sink;

  Stream<List<FileInfo>> get fevListStream => _fevListStreamController.stream;

  void getAllFevList() async {
    _fevList = List<FileInfo>();
    Map<String, dynamic> mapBody = Map<String, dynamic>();
    mapBody["basic"] = {"application": 'business', "component": 'filemanager'};
    _actionConnect
        .sendActionPost(mapBody, ActionConnect.fevList)
        .then((dynamic mapResponse) {
      List<dynamic> dynamicList = mapResponse as List<dynamic>;
      dynamicList.map((i) => _fevList.add(FileInfo.fevList(i))).toList();
      fevListStreamSink.add(_fevList);
    });
  }

  void dispose() {
    _fevListStreamController.close();
  }
}
