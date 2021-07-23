import 'package:file/screens/file/shared_page.dart';
import 'package:flutter/material.dart';
import 'package:file/models/user.dart';
import 'package:file/network/user_connect.dart';
import 'package:file/screens/file/archive_page.dart';
import 'package:file/screens/file/favourite_page.dart';
import 'package:file/screens/file/inbox_page.dart';
import 'package:file/screens/file/sent_page.dart';
import 'package:file/screens/file/trash_page.dart';
import 'package:file/screens/idm/login_page.dart';
import 'package:file/screens/profile_screens/edit_profile_screens/profile_page.dart';
import 'package:file/utils/navigation_actions.dart';
import 'package:file/utils/shared_pref_manager.dart';
import 'package:file/utils/widgets_collection.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key key,
    @required double screenWidth,
    @required List<User> usersList,
    @required WidgetsCollection widgetsCollection,
    @required NavigationActions navigationActions,
  })  : _screenWidth = screenWidth,
        _usersList = usersList,
        _widgetsCollection = widgetsCollection,
        _navigationActions = navigationActions,
        super(key: key);

  final double _screenWidth;
  final List<User> _usersList;
  final WidgetsCollection _widgetsCollection;
  final NavigationActions _navigationActions;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._screenWidth * 0.90,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                color: Colors.grey.withOpacity(0.25),
                child: ListView(
                  // shrinkWrap: true,
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget._usersList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: widget._widgetsCollection
                              .getDrawerProfileImage(
                                  45.0, widget._usersList[index]),
                          onTap: () {
                            setState(
                              () {
                                SharedPrefManager.switchCurrentUser(
                                        widget._usersList[index])
                                    .then(
                                  (value) {
                                    widget._navigationActions
                                        .navigateToScreenWidget(
                                      ProfilePage(
                                        userId: Connect.currentUser.userId,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      padding: EdgeInsets.all(0.5),
                      width: 45.0,
                      height: 45.0,
                      child: Center(
                        child: ClipOval(
                          child: IconButton(
                            icon: Icon(Icons.person_add),
                            onPressed: () {
                              // widget._navigationActions.navigateToScreenWidget(
                              //   LoginPage(previousScreen: 'file_page'),
                              // );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Drawer(
              elevation: 1.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
//                        shrinkWrap: true,
                children: <Widget>[
                  DrawerHeader(
                    child: Image.asset(
                      'assets/images/mesbro.png',
                      width: widget._screenWidth * 0.4,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.star_border),
                    title: Text(
                      'Inbox',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      widget._navigationActions.navigateToScreenWidget(
                        InboxPage(),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.scatter_plot),
                    title: Text(
                      'Sent',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      widget._navigationActions.navigateToScreenWidget(
                        SentPage(),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.phone_android),
                    title: Text(
                      'Archive',
                    ),
                    onTap: () {
                      widget._navigationActions.navigateToScreenWidget(
                        ArchivePage(),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.room_service),
                    title: Text(
                      'Trash',
                    ),
                    onTap: () {
                      widget._navigationActions.navigateToScreenWidget(
                        TrashPage(),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.room_service),
                    title: Text(
                      'Favourite',
                    ),
                    onTap: () {
                      widget._navigationActions.navigateToScreenWidget(
                        FavouritePage(),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text(
                      'Shared',
                    ),
                    onTap: () {
                      widget._navigationActions.navigateToScreenWidget(
                        SharedPage(),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Log Out'),
                    onTap: () {
                      SharedPrefManager.removeAll().then(
                        (bool value) {
                          widget._navigationActions.navigateToScreenWidgetRoot(
                            LoginPage(),
                          );
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Version: 0.0.8',
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
