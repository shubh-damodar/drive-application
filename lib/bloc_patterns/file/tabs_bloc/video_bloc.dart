import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/models/file.dart';
import 'package:file/network/action_connect.dart';
import 'package:file/network/file_connect.dart';
import 'package:file/network/list_connect.dart';
import 'package:file_picker/file_picker.dart';


class VideosBloc {
  ListConnect _listConnect = ListConnect();
  ActionConnect _actionConnect = ActionConnect();
  // List<FileInfo> emailsList = List<FileInfo>();
  int lastTimeStamp;
  List<FileInfo> _videoList = List<FileInfo>();
  FileConnect _fileConnect = FileConnect();

  StreamController<List<FileInfo>> _videoListStreamController =
      StreamController<List<FileInfo>>.broadcast();

  StreamSink<List<FileInfo>> get videoListStreamSink =>
      _videoListStreamController.sink;

  Stream<List<FileInfo>> get videoListStream =>
      _videoListStreamController.stream;

  void getAllVideosList() async {
    _videoList = List<FileInfo>();
    Map<String, dynamic> mapBody = Map<String, dynamic>();
    mapBody['type'] = "videos";
    _actionConnect
        .sendActionPost(mapBody, ActionConnect.fileList)
        .then((dynamic mapResponse) {
      List<dynamic> dynamicList = mapResponse as List<dynamic>;
      dynamicList.map((i) => _videoList.add(FileInfo.videoJSON(i))).toList();
      videoListStreamSink.add(_videoList);
    });
  }

  void dispose() {
    _videoListStreamController.close();
  }
}
