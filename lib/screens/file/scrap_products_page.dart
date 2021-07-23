import 'dart:collection';
import 'package:file/bloc_patterns/file/tabs_bloc/file_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:file/bloc_patterns/edit_profile_bloc_patterns/profile_bloc.dart';
import 'package:file/models/user.dart';
import 'package:file/network/user_connect.dart';
import 'package:file/screens/file/search_page.dart';
import 'package:file/utils/date_category.dart';
import 'package:file/utils/messages_actions.dart';
import 'package:file/utils/navigation_actions.dart';
import 'package:file/utils/network_connectivity.dart';
import 'package:file/utils/shared_pref_manager.dart';
import 'package:file/utils/widgets_collection.dart';

class ScrapFilePage extends StatefulWidget {
  _ScrapFilePageState createState() => _ScrapFilePageState();
}

class _ScrapFilePageState extends State<ScrapFilePage> {
  DateTime currentBackPressDateTime;

  bool _isMessageRead, _areMessagesSelected = false;
  DateCategory _dateCategory = DateCategory();
  Map _jsonMap = {
    "type": ["INBOX"]
  };

  NavigationActions _navigationActions;
  final FileBloc _fileBloc = FileBloc();
  final ProfileBloc _profileBloc = ProfileBloc();
  double _screenWidth, _screenHeight;
  final ScrollController _scrollController = ScrollController();
  List<String> _selectedConversationIdsList = List<String>();
  LinkedHashMap<String, String> _settingsRouteLinkedHashMap =
      LinkedHashMap<String, String>();

  List<User> _usersList = List<User>();
  WidgetsCollection _widgetsCollection;

  void initState() {
    super.initState();
    _profileBloc.getAllUserDetails(Connect.currentUser.userId);
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      NetworkConnectivity.of(context).checkNetworkConnection();
      //print('~~~ scedulebind');
    });
    _getAllUsers();
    _navigationActions = NavigationActions(context);
    _widgetsCollection = WidgetsCollection(context);
  }

  void dispose() {
    super.dispose();
    // _inboxBloc.dispose();
    _scrollController.dispose();
  }

  Future<void> _getAllUsers() async {
    await SharedPrefManager.getAllUsers().then((List<User> user) {
      setState(() {
        _usersList = user;
      });
    });
  }

  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Scrap Files',
          style: TextStyle(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                // _navigationActions.navigateToScreenWidget(
                //   SearchPage(
                //       // emailsList: _inboxBloc.emailsList,
                //       // mailType: 'input',
                //       // jsonMap: _jsonMap,
                //       ),
                // );
              });
            },
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.black54,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int) {
          return GestureDetector(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.pink),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'I am Sexy and I know it, Would you love me',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        onTap: () {
                                          print("Printed on Edit Button");
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '★★★★★',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 19.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text("Scrap")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Price ',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        '200',
                                        style: TextStyle(fontSize: 13.0),
                                      )
                                    ],
                                  ),
                                  Row(
                                    // mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Min Order ',
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '500 Pices',
                                            style: TextStyle(fontSize: 13),
                                          )
                                        ],
                                      ),
                                      Text("India")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
