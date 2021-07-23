import 'dart:async';

import 'package:file/models/file.dart';
import 'package:file/network/action_connect.dart';
import 'package:file/network/list_connect.dart';
import 'package:file/utils/mail_subject_short_text_list_details.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  MailSubjectShortTextListDetails _fileSubjectShortTextListDetails;
  List<FileInfo> fileSearchList = List<FileInfo>();
  ListConnect _listConnect = ListConnect();
  ActionConnect _actionConnect = ActionConnect();

  List<FileInfo> searchList = List<FileInfo>();
  int lastTimeStamp;

  SearchBloc({this.fileSearchList}) {
    fileListFoundStreamSink.add(fileSearchList);
    _fileSubjectShortTextListDetails =
        MailSubjectShortTextListDetails(fileSearchList: fileSearchList);
  }
  final BehaviorSubject<String> _fileSubjectShortTextBehaviorSubject =
      BehaviorSubject<String>();
  final StreamController<List<FileInfo>> _fileListFoundStreamController =
      StreamController<List<FileInfo>>();

  StreamSink<String> get fileSubjectShortTextStreamSink =>
      _fileSubjectShortTextBehaviorSubject.sink;
  StreamSink<List<FileInfo>> get fileListFoundStreamSink =>
      _fileListFoundStreamController.sink;

  Stream<String> get fileSubjectShortTextStream =>
      _fileSubjectShortTextBehaviorSubject.stream;
  Stream<List<FileInfo>> get fileListFoundStream =>
      _fileListFoundStreamController.stream;

  void searchBox(String query) async {
    searchList = List<FileInfo>();
    Map<String, dynamic> mapBody = Map<String, dynamic>();
    mapBody['type'] = query;
    _actionConnect
        .sendActionPost(mapBody, ActionConnect.fileList)
        .then((dynamic mapResponse) {
      print("------------------------${mapResponse}");
      List<dynamic> dynamicList = mapResponse as List<dynamic>;
      dynamicList.map((i) => searchList.add(FileInfo.fromJSON(i))).toList();
      fileListFoundStreamSink.add(searchList);
    });
  }

  void dispose() {
    _fileSubjectShortTextBehaviorSubject.close();
    _fileListFoundStreamController.close();
  }
}
