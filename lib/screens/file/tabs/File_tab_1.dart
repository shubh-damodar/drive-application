import 'package:file/bloc_patterns/file/tabs_bloc/file_bloc.dart';
import 'package:file/models/file.dart';
import 'package:file/network/user_connect.dart';
import 'package:file/screens/file/module/docs.view.dart';
import 'package:file/screens/file/module/photo_view.dart';
import 'package:file/screens/file/module/video_player.dart';
import 'package:file/utils/navigation_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:file/utils/widgets_collection.dart';

class FilesTab extends StatefulWidget {
  method() => createState().dataReload();
  FilesTab({Key key}) : super(key: key);

  @override
  _FilesTabState createState() => _FilesTabState();
}

class _FilesTabState extends State<FilesTab> {
  WidgetsCollection _widgetsCollection;
  NavigationActions _navigationActions;
  FileBloc _fileBloc = FileBloc();

  @override
  void initState() {
    _widgetsCollection = WidgetsCollection(context);
    _navigationActions = NavigationActions(context);
    _fileBloc.getAllFileList();
    super.initState();
  }

  dataReload() {
    _fileBloc.getAllFileList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _fileBloc.fileListStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<FileInfo>> asyncSnapshot) {
          return asyncSnapshot.data == null
              ? Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                )
              : AnimationLimiter(
                  child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          shrinkWrap: false,
                          itemCount: asyncSnapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: Duration(milliseconds: 375),
                              columnCount: 2,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        "${asyncSnapshot.data[index].extention}" ==
                                                ".jpg"
                                            ? _navigationActions.navigateToScreenWidget(
                                                ControllerPhotoViewPage(
                                                    imageUrl:
                                                        "${asyncSnapshot.data[index].accessUrl}"))
                                            : "${asyncSnapshot.data[index].extention}" ==
                                                    ".pdf"
                                                ? _navigationActions
                                                    .navigateToScreenWidget(DocumentsView(
                                                        file:
                                                            "${asyncSnapshot.data[index].accessUrl}"))
                                                : "${asyncSnapshot.data[index].extention}" ==
                                                        ".png"
                                                    ? _navigationActions
                                                        .navigateToScreenWidget(
                                                            ControllerPhotoViewPage())
                                                    : "${asyncSnapshot.data[index].extention}" ==
                                                            ".jfif"
                                                        ? _navigationActions
                                                            .navigateToScreenWidget(
                                                                ControllerPhotoViewPage(
                                                                    imageUrl:
                                                                        "${asyncSnapshot.data[index].accessUrl}"))
                                                        : "${asyncSnapshot.data[index].extention}" ==
                                                                ".mp4"
                                                            ? _navigationActions
                                                                .navigateToScreenWidget(
                                                                    VideoPlayerScreen(
                                                                        mp4Link:
                                                                            "${Connect.filesUrl}${asyncSnapshot.data[index].accessUrl}"))
                                                            : _widgetsCollection
                                                                .showToastMessage(
                                                                    "Format not supported");
                                      },
                                      child: Container(
                                        // decoration: designShadow,
                                        decoration: _widgetsCollection
                                            .designAndShadow(),

                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              child: Image.asset(
                                                "${asyncSnapshot.data[index].extention}" ==
                                                        ".jpg"
                                                    ? 'assets/images/extentions/031-jpg file.png'
                                                    : "${asyncSnapshot.data[index].extention}" ==
                                                            ".pdf"
                                                        ? 'assets/images/extentions/040-pdf file.png'
                                                        : "${asyncSnapshot.data[index].extention}" ==
                                                                ".png"
                                                            ? 'assets/images/extentions/042-png file.png'
                                                            : 'assets/images/extentions/042-png file.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Text(
                                                  "${asyncSnapshot.data[index].fileName}"),
                                            ),
                                            // StreamBuilder(
                                            //     stream:
                                            //         _fileBloc.fileListStream,
                                            //     builder: (BuildContext context,
                                            //         AsyncSnapshot<
                                            //                 List<FileInfo>>
                                            //             asyncSnapshot) {
                                            //       return asyncSnapshot.data ==
                                            //               null
                                            //           ? _dataReload()
                                            //           : Container(
                                            //               height: 0,
                                            //               width: 0,
                                            //             );
                                            //     })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                );
        });
  }
}

class Choice {
  const Choice({this.title, this.index});

  final int index;
  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Edit Profile', index: 0),
  const Choice(title: 'Change Password', index: 1),
  const Choice(title: 'LogOut', index: 2),
];
