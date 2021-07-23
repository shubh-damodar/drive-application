import 'package:file/bloc_patterns/file/tabs_bloc/video_bloc.dart';
import 'package:flutter/material.dart';
import 'package:file/screens/file/module/video_player.dart';
import 'package:file/utils/navigation_actions.dart';
import 'package:file/utils/widgets_collection.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VideoTab extends StatefulWidget {
  VideoTab({Key key}) : super(key: key);

  @override
  _VideoTabState createState() => _VideoTabState();
}

class _VideoTabState extends State<VideoTab> {
  VideosBloc _videosBloc = VideosBloc();

  var designShadow = BoxDecoration(
    color: Colors.white,
    borderRadius: new BorderRadius.only(
      topRight: const Radius.circular(10.0),
      bottomRight: const Radius.circular(10.0),
      topLeft: const Radius.circular(10.0),
    ),
    boxShadow: [
      new BoxShadow(
        color: Colors.black12,
        blurRadius: 4.1,
      ),
    ],
    image: DecorationImage(
      image: NetworkImage(
          "https://images.pexels.com/photos/2577626/pexels-photo-2577626.jpeg"),
      fit: BoxFit.fill,
    ),
  );

  NavigationActions _navigationActions;
  WidgetsCollection _widgetsCollection;

  @override
  void initState() {
    _navigationActions = NavigationActions(context);
    _widgetsCollection = WidgetsCollection(context);
    _videosBloc.getAllVideosList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: GridView.count(
            shrinkWrap: false,
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
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: GestureDetector(
                          onTap: () {
                            _navigationActions
                                .navigateToScreenWidget(VideoPlayerScreen());
                          },
                          child: Container(
                            decoration: designShadow,
                            child: ClipRRect(
                              borderRadius:
                                  _widgetsCollection.clipRReactDesign(),
                              child: Icon(
                                Icons.play_circle_filled,
                                color: Colors.white,
                                size: 45,
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
    );
  }
}
