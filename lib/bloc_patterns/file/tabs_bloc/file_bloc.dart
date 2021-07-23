import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file/models/file.dart';
import 'package:file/network/action_connect.dart';
import 'package:file/network/file_connect.dart';
import 'package:file/network/list_connect.dart';
import 'package:file/network/user_connect.dart';
import 'package:file_picker/file_picker.dart';

class FileBloc {
  ListConnect _listConnect = ListConnect();
  ActionConnect _actionConnect = ActionConnect();
  // List<FileInfo> emailsList = List<FileInfo>();
  int lastTimeStamp;
  List<FileInfo> _fileList = List<FileInfo>();
  FileConnect _fileConnect = FileConnect();

  StreamController<List<FileInfo>> _fileListStreamController =
      StreamController<List<FileInfo>>.broadcast();

  StreamSink<List<FileInfo>> get fileListStreamSink =>
      _fileListStreamController.sink;

  Stream<List<FileInfo>> get fileListStream => _fileListStreamController.stream;

  Map _jsonMap = {
    "file": ["originalname : originalName[0]"],
    "type": 'type',
    "fileName": "name",
    "fileType": "Type"
  };

  void takePicture() async {
    File fileImage = await FilePicker.getFile(type: FileType.ANY);

    // File fileImage = await img;
    String filePath = fileImage.path, fileName, fileExtension;

    fileName = filePath.substring(
        filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));

    fileExtension = filePath.substring(filePath.lastIndexOf('.') + 1);

    print("------------------$fileName ---------------$fileExtension");

    Map<String, dynamic> mapResponseGetDownloadUrl,
        mapResponseConfirm,
        updateMapResponse;
    // mapResponseGetDownloadUrl = await _fileConnect.sendFileGet(
    //     '${FileConnect.uploadFileGetDownloadUrl}?type=general&fileName=$fileName&fileType=image/$fileExtension');
    Map<String, dynamic> mapBody = Map<String, dynamic>();

    // mapBody["basic"] = {
    //   "type": 'type',
    //   "fileName": 'fileName',
    //   'fileType': 'fileType'
    // };

    Map<String, String> mapXXX = Map<String, String>();
    mapXXX["type"] = "type";
    mapXXX["fileName"] = "fileName";
    mapXXX["fileType"] = "Type";

    // mapXXX = {
    //   "file": "",
    //   "type": "type",
    //   "fileName": 'fileName',
    //   "fileType": 'fileType',
    // };

    

    mapBody["basic"] = {
      "file": {"originalname : originalName[0]"},
      "type": 'type',
      "fileName": "name",
      "fileType": "Type"
    };
    // mapBody["file"] = {"originalname : originalName[0]"};
    // mapBody["type"] = "type";
    // mapBody["fileName"] = "name";
    // mapBody["fileType"] = "type";

    // mapBody["basic"] = {
    //   "file": ["originalname : originalName[0]"],
    //   "type": 'type',
    //   "fileName": "name",
    //   "fileType": "Type"
    // };

    // mapBody['basic'] =[];
    // mapBody['file']= {};

    // mapBody['basic'] = {'fileName': 'images (1).jpg'};

    // print(mapXXX);
    // print(mapBody);
    // mapBody["basic"] = mapXXX;

    mapResponseGetDownloadUrl = await _fileConnect.sendFilePostWithHeaders(
        mapBody, FileConnect.uploadFileGetDownloadUrl);

    // int statusCode = await _fileConnect.uploadFile(
    //     mapResponseGetDownloadUrl['content']['signedUrl'],
    //     'image/$fileExtension',
    //     filePath);

    // mapResponseConfirm = await _fileConnect.sendFileGet(
    //     '${FileConnect.uploadConfirmUploadToken}${mapResponseGetDownloadUrl['content']['uploadToken']}');

    // articleImageStreamSink.add(
    //     '${Connect.filesUrl}${mapResponseConfirm['content']['accessUrl']}');

    // articleImageAccessUrlStreamSink
    //     .add(mapResponseConfirm['content']['accessUrl']);
  }

  void postFile() async {
    _fileList = List<FileInfo>();

    Map<String, dynamic> mapBody = Map<String, dynamic>();
    mapBody['type'] = "File";
    _actionConnect
        .sendActionPost(mapBody, ActionConnect.fileList)
        .then((dynamic mapResponse) {
      List<dynamic> dynamicList = mapResponse as List<dynamic>;
      dynamicList.map((i) => _fileList.add(FileInfo.fromJSON(i))).toList();
      fileListStreamSink.add(_fileList);
    });
  }

  void getAllFileList() async {
    _fileList = List<FileInfo>();
    Map<String, dynamic> mapBody = Map<String, dynamic>();
    mapBody['type'] = "File";
    _actionConnect
        .sendActionPost(mapBody, ActionConnect.fileList)
        .then((dynamic mapResponse) {
          print("-------file filter-------------$mapResponse");
      List<dynamic> dynamicList = mapResponse as List<dynamic>;
      dynamicList.map((i) => _fileList.add(FileInfo.fromJSON(i))).toList();
      fileListStreamSink.add(_fileList);
    });
  }

  void dispose() {
    _fileListStreamController.close();
  }
}
