import 'package:cached_network_image/cached_network_image.dart';
import 'package:file/bloc_patterns/file/tabs_bloc/image_bloc.dart';
import 'package:file/models/file.dart';
import 'package:file/network/user_connect.dart';
import 'package:file/utils/widgets_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:file/screens/file/module/photo_view.dart';
import 'package:file/utils/navigation_actions.dart';

class ImageTab extends StatefulWidget {
  ImageTab({Key key}) : super(key: key);

  @override
  _ImageTabState createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab> {
  WidgetsCollection _widgetsCollection;
  NavigationActions _navigationActions;
  ImageBloc _imageBloc = ImageBloc();

  @override
  void initState() {
    _navigationActions = NavigationActions(context);
    _widgetsCollection = WidgetsCollection(context);
    _imageBloc.getAllImagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _imageBloc.imagesListStream,
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
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, bottom: 10),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            itemCount: (asyncSnapshot.data != null
                                ? asyncSnapshot.data.length
                                : 0),
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                columnCount: 2,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          _navigationActions
                                              .navigateToScreenWidget(
                                                  ControllerPhotoViewPage(
                                            imageUrl: asyncSnapshot
                                                .data[index].accessUrl,
                                          ));
                                        },
                                        child: SizedBox(
                                          height: 10,
                                          child: Container(
                                            // decoration: designShadow,
                                            decoration: _widgetsCollection
                                                .designAndShadow(),
                                            child: Container(
                                              decoration: new BoxDecoration(
                                                color: Colors.white,
                                                // borderRadius: clipRReactDesign,
                                                borderRadius: _widgetsCollection
                                                    .clipRReactDesign(),
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4.1,
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                // borderRadius: clipRReactDesign,
                                                borderRadius: _widgetsCollection
                                                    .clipRReactDesign(),
                                                // child: Image.asset(
                                                //   'assets/images/hotel_2.png',
                                                //   fit: BoxFit.fill,
                                                // ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "${Connect.filesUrl}${asyncSnapshot.data[index].accessUrl}",
                                                  fit: BoxFit.cover,
                                                ),
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
                          ))));
        });
  }
}
