import 'package:file/models/file.dart';

class MailSubjectShortTextListDetails {
  List<FileInfo> fileSearchList;

  MailSubjectShortTextListDetails({this.fileSearchList});

  Future<List<FileInfo>> getSuggestions(
      String mailSubjectShortTextLetter) async {
    List<FileInfo> matchedFileList = List<FileInfo>();

    for (FileInfo fineInfo in fileSearchList) {
      //print(
      //    '~~~ 1st getSuggestions: $mailSubjectShortTextLetter ${fineInfo.fromUser.address} ${fineInfo.fromUser.name}');

      if ((fineInfo.fileName
          .toLowerCase()
          .contains(mailSubjectShortTextLetter.toLowerCase()))) {
        //print('~~~ matched ${fineInfo.fromUser.name} ');
        matchedFileList.add(fineInfo);
      }
    }
    return matchedFileList;
  }
}
