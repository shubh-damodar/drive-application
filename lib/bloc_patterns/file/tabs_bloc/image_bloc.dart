import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/models/file.dart';
import 'package:file/network/action_connect.dart';
import 'package:file/network/file_connect.dart';
import 'package:file/network/list_connect.dart';
import 'package:file_picker/file_picker.dart';


class ImageBloc {
  ListConnect _listConnect = ListConnect();
  ActionConnect _actionConnect = ActionConnect();
  // List<FileInfo> emailsList = List<FileInfo>();
  int lastTimeStamp;
  List<FileInfo> _imagesList = List<FileInfo>();
  FileConnect _fileConnect = FileConnect();

  StreamController<List<FileInfo>> _imagesListStreamController =
      StreamController<List<FileInfo>>.broadcast();

  StreamSink<List<FileInfo>> get imagesListStreamSink =>
      _imagesListStreamController.sink;

  Stream<List<FileInfo>> get imagesListStream =>
      _imagesListStreamController.stream;

  void getAllImagesList() async {
    _imagesList = List<FileInfo>();
    Map<String, dynamic> mapBody = Map<String, dynamic>();
    mapBody['type'] = "images";
    _actionConnect
        .sendActionPost(mapBody, ActionConnect.fileList)
        .then((dynamic mapResponse) {
      List<dynamic> dynamicList = mapResponse as List<dynamic>;
      dynamicList.map((i) => _imagesList.add(FileInfo.imageJSON(i))).toList();
      imagesListStreamSink.add(_imagesList);
    });
  }

  void dispose() {
    _imagesListStreamController.close();
  }
}
