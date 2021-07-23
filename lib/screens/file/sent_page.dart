import 'dart:collection';
import 'package:file/screens/file/module/docs.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:file/bloc_patterns/edit_profile_bloc_patterns/profile_bloc.dart';
import 'package:file/models/user.dart';
import 'package:file/network/user_connect.dart';
import 'package:file/utils/date_category.dart';
import 'package:file/utils/navigation_actions.dart';
import 'package:file/utils/network_connectivity.dart';
import 'package:file/utils/shared_pref_manager.dart';
import 'package:file/utils/widgets_collection.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SentPage extends StatefulWidget {
  _SentPageState createState() => _SentPageState();
}

class _SentPageState extends State<SentPage> {
  NavigationActions _navigationActions;
  WidgetsCollection _widgetsCollection;

  void initState() {
    super.initState();
    _navigationActions = NavigationActions(context);
    _widgetsCollection = WidgetsCollection(context);
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sent',
          style: TextStyle(
            color: Colors.black,
          ),
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
                  // _navigationActions.navigateToScreenWidget(
                  //   SearchPage(
                  //       // emailsList: _inboxBloc.emailsList,
                  //       // mailType: 'input',
                  //       // jsonMap: _jsonMap,
                  //       ),
                  // );
                },
              );
            },
          ),
        ],
      ),
      body: AnimationLimiter(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              crossAxisCount: 2,
              children: List.generate(
                10,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _navigationActions
                                .navigateToScreenWidget(DocumentsView());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20),
                            child: GestureDetector(
                              child: SizedBox(
                                height: 10,
                                child: Container(
                                  // margin: EdgeInsets.only(top: 30, bottom: 30),
                                  decoration:
                                      _widgetsCollection.designAndShadow(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                              index == 0
                                                  ? 'assets/images/extentions/001-3gp file.png'
                                                  : index == 1
                                                      ? 'assets/images/extentions/002-7z file.png'
                                                      : index == 2
                                                          ? 'assets/images/extentions/003-after effects.png'
                                                          : index == 3
                                                              ? 'assets/images/extentions/007-avi file.png'
                                                              : index == 4
                                                                  ? 'assets/images/extentions/013-dll file.png'
                                                                  : 'assets/images/extentions/020-fla file.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text("Data.png")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
