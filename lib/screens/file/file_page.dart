import 'dart:collection';
import 'dart:io';
import 'package:file/bloc_patterns/file/tabs_bloc/doc_bloc.dart';
import 'package:file/bloc_patterns/file/tabs_bloc/file_bloc.dart';
import 'package:file/bloc_patterns/file/tabs_bloc/image_bloc.dart';
import 'package:file/bloc_patterns/file/tabs_bloc/video_bloc.dart';
import 'package:flutter/material.dart';
import 'package:file/bloc_patterns/edit_profile_bloc_patterns/profile_bloc.dart';
import 'package:file/models/user.dart';
import 'package:file/network/user_connect.dart';
import 'package:file/screens/file/search_page.dart';
import 'package:file/screens/file/tabs/Document_tab_4.dart';
import 'package:file/screens/file/tabs/File_tab_1.dart';
import 'package:file/screens/file/tabs/Image_tab_2.dart';
import 'package:file/screens/file/tabs/Video_tab_3.dart';
import 'package:file/utils/drawer_widget.dart';
import 'package:file/utils/navigation_actions.dart';
import 'package:file/utils/widgets_collection.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';

class FilePage extends StatefulWidget {
  _FilePageState createState() => _FilePageState();
}

class _FilePageState extends State<FilePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime currentBackPressDateTime;
  bool areMessagesSelected = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: true);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _fileBloc.getAllFileList();
      FilesTab();
    });

    return null;
  }

  NavigationActions _navigationActions;
  final FileBloc _fileBloc = FileBloc();
  VideosBloc _videosBloc = VideosBloc();
  ImageBloc _imageBloc = ImageBloc();
  DocBloc _docBloc = DocBloc();
  final ProfileBloc _profileBloc = ProfileBloc();
  double _screenWidth, _screenHeight;
  final ScrollController _scrollController = ScrollController();
  List<String> _selectedConversationIdsList = List<String>();
  LinkedHashMap<String, String> _settingsRouteLinkedHashMap =
      LinkedHashMap<String, String>();

  List<User> _usersList = List<User>();
  WidgetsCollection _widgetsCollection;
  TabController _tabController;
  File image;

  void initState() {
    super.initState();
    // _profileBloc.getAllUserDetails(Connect.currentUser.userId);
    // SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
    //   NetworkConnectivity.of(context).checkNetworkConnection();
    //   //print('~~~ scedulebind');
    // });
    // _getAllUsers();
    _navigationActions = NavigationActions(context);
    _widgetsCollection = WidgetsCollection(context);
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  List<String> actions = ['View', 'Query', 'Edit'];

  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // Future<void> _getAllUsers() async {
  //   await SharedPrefManager.getAllUsers().then((List<User> user) {
  //     setState(() {
  //       _usersList = user;
  //     });
  //   });
  // }

  _dataReload() {
    setState(() {
      _fileBloc.getAllFileList();
    });
  }

  void _navigateAndRefresh(Widget widget) {
    Navigator.of(context, rootNavigator: false)
        .push(
          MaterialPageRoute(builder: (context) => widget),
        )
        .then((dynamic) {});
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressDateTime == null ||
        now.difference(currentBackPressDateTime) > Duration(seconds: 2)) {
      currentBackPressDateTime = now;
      _widgetsCollection.showToastMessage('Press once again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  FilesTab __filesTabState = FilesTab();

  takePicture() async {
    // File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // image = img;
    _fileBloc.takePicture();

    setState(() {
      // _fileBloc.takePicture(image);
    });
  }

  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: areMessagesSelected
            ? AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      areMessagesSelected = false;
                      _selectedConversationIdsList = List<String>();
                    });
                  },
                ),
                title: Text(
                  '${_selectedConversationIdsList.length} selected',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    onSelected: (String choice) {
                      // var x = ;
                      switch (choice) {
                        case '':
                          {
                            print("object1");
                            takePicture();
                          }
                          break;
                        case '':
                          {
                            print("object2");
                          }
                          break;
                        case '':
                          {
                            print("object3");
                          }
                          break;
                        default:
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return actions.map((String choice) {
                        return PopupMenuItem<String>(
                            value: choice, child: Text(choice));
                      }).toList();
                    },
                  ),
                ],
              )
            : AppBar(
                leading: IconButton(
                  icon: Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                    setState(() {});
                  },
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  'Mesbro File',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          // _fileBloc.getAllFileList();

                          _navigationActions.navigateToScreenWidget(
                            SearchPage(
                                // articleList: _inboxBloc.emailsList,
                                // mailType: 'input',
                                ),
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      _fileBloc.takePicture();
                      // __filesTabState.dataReload();
                      // _FilesTabState
                      // _dataReload();
                      // setState(() {
                      //   _fileBloc.getAllFileList();
                      //   _videosBloc.getAllVideosList();
                      //   _imageBloc.getAllImagesList();
                      //   _docBloc.getAllDocList();
                      //   super.initState();
                      // });
                    },
                  )
                ],
                bottom: TabBar(
                  controller: _tabController,
                  labelColor: Colors.red,
                  indicatorColor: Colors.red,
                  labelStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black38,
                  isScrollable: false,
                  tabs: <Widget>[
                    Tab(text: "File"),
                    Tab(text: "Images"),
                    Tab(text: "Videos"),
                    Tab(text: "Docs"),
                  ],
                ),
              ),
        drawer: DrawerWidget(
          screenWidth: _screenWidth,
          usersList: _usersList,
          widgetsCollection: _widgetsCollection,
          navigationActions: _navigationActions,
        ),
        floatingActionButton: AnimatedFloatingActionButton(
          fabButtons: <Widget>[
            Container(
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: () {
                  _widgetsCollection.showToastMessage("Adding File");
                },
                heroTag: "Add File",
                tooltip: 'Add File',
                child: Icon(
                  Icons.file_upload,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              child: FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  _widgetsCollection.showToastMessage("Adding Folder");
                },
                heroTag: "Add Folder",
                tooltip: 'Add Folder',
                child: Icon(Icons.create_new_folder, color: Colors.white),
              ),
            ),
          ],
          colorStartAnimation: Colors.blueAccent,
          colorEndAnimation: Colors.blueAccent,
          animatedIconData: AnimatedIcons.menu_close,
        ),
        // drawer:
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            RefreshIndicator(
              child: FilesTab(),
              onRefresh: refreshList,
              key: refreshKey,
            ),
            ImageTab(),
            VideoTab(),
            DocumentTab(),
          ],
        ),
      ),
    );
  }
}
