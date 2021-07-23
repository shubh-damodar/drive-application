import 'package:file/models/user.dart';

import 'attachment.dart';

class FileInfo {
  String type, id, fileName, accessUrl, streamUrl, extention, fileType;

  FileInfo(
      {this.type,
      this.id,
      this.fileName,
      this.accessUrl,
      this.streamUrl,
      this.fileType,
      this.extention});

  FileInfo.fromJSON(map) {
    accessUrl = map["basic"]["id"] == "5de30f680dd5f223e43ae0f9"
        ? "3/19/5de1f7b371e097002fa73f41/gaurav/5de4b0a521a354002f05f78c.jpg"
        : map["basic"]["accessUrl"];
    type = map["basic"]["type"];
    fileName = map["basic"]["fileName"];
    id = map["basic"]["id"];
    fileType = map["basic"]["fileType"];
    streamUrl =
        map["basic"]["streamUrl"] == null ? "x" : map["basic"]["streamUrl"];
    extention = accessUrl.substring(accessUrl.lastIndexOf('.'));
    print("-----------------File--------------$extention");
    print("-------------------------------------------------------$fileName");
  }

  FileInfo.imageJSON(map) {
    accessUrl = map["basic"]["accessUrl"];
    type = map["basic"]["type"];
    fileName = map["basic"]["fileName"];
    id = map["basic"]["id"];
    streamUrl = map["basic"]["streamUrl"];
    extention = accessUrl.substring(accessUrl.lastIndexOf('.'));
    print("--------image--------$accessUrl");
  }

  FileInfo.videoJSON(map) {
    accessUrl = map["basic"]["accessUrl"];
    type = map["basic"]["type"];
    fileName = map["basic"]["fileName"];
    id = map["basic"]["id"];
    streamUrl = map["basic"]["streamUrl"];
    extention = accessUrl.substring(accessUrl.lastIndexOf('.'));
    print("---------Video-------$accessUrl");
  }

  FileInfo.docJSON(map) {
    accessUrl = map["basic"]["accessUrl"];
    type = map["basic"]["type"];
    fileName = map["basic"]["fileName"];
    id = map["basic"]["id"];
    streamUrl = map["basic"]["streamUrl"];
    extention = accessUrl.substring(accessUrl.lastIndexOf('.'));
    print("---------doc-------$accessUrl");
  }

  FileInfo.searchList(map) {
    accessUrl = map["basic"]["accessUrl"];
    type = map["basic"]["type"];
    fileName = map["basic"]["fileName"];
    id = map["basic"]["id"];
    streamUrl =
        map["basic"]["streamUrl"] == null ? "x" : map["basic"]["streamUrl"];
    extention = accessUrl.substring(accessUrl.lastIndexOf('.'));
    print("---------doc-------$accessUrl");
  }

  FileInfo.fevList(map) {
    accessUrl = map["basic"]["accessUrl"];
    type = map["basic"]["type"];
    fileName = map["basic"]["fileName"];
    id = map["basic"]["id"];
    streamUrl =
        map["basic"]["streamUrl"] == null ? "x" : map["basic"]["streamUrl"];
    extention = accessUrl.substring(accessUrl.lastIndexOf('.'));
    print("---------doc-------$id");
  }
}
