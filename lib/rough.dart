// import 'package:file/bloc_patterns/file/image_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:file/screens/file/module/photo_view.dart';
// import 'package:file/utils/navigation_actions.dart';

// class ImageTab extends StatefulWidget {
//   ImageTab({Key key}) : super(key: key);

//   @override
//   _ImageTabState createState() => _ImageTabState();
// }


// class _ImageTabState extends State<ImageTab> {
//   var designShadow = BoxDecoration(
//       color: Colors.white,
//       borderRadius: new BorderRadius.only(
//         topRight: const Radius.circular(10.0),
//         topLeft: const Radius.circular(10.0),
//         bottomRight: const Radius.circular(10.0),
//       ),
//       boxShadow: [
//         new BoxShadow(
//           color: Colors.black12,
//           blurRadius: 4.1,
//         ),
//       ]);

//   var clipRReactDesign = new BorderRadius.only(
//     topRight: const Radius.circular(10.0),
//     topLeft: const Radius.circular(10.0),
//     bottomRight: const Radius.circular(10.0),
//   );

//   NavigationActions _navigationActions;
//   ImageBloc _imageBloc = ImageBloc();

//   @override
//   void initState() {
//     _navigationActions = NavigationActions(context);
//     _imageBloc.getAllImagesList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimationLimiter(
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 5,
//             right: 5,
//           ),
//           child: GridView.count(
//             shrinkWrap: true,
//             crossAxisSpacing: 0,
//             mainAxisSpacing: 0,
//             crossAxisCount: 2,
//             children: List.generate(
//               10,
//               (int index) {
//                 return AnimationConfiguration.staggeredGrid(
//                   position: index,
//                   duration: const Duration(milliseconds: 375),
//                   columnCount: 2,
//                   child: ScaleAnimation(
//                     child: FadeInAnimation(
//                       child: Padding(
//                         padding:
//                             const EdgeInsets.only(left: 10, right: 10, top: 20),
//                         child: GestureDetector(
//                           onTap: () {
//                             _navigationActions.navigateToScreenWidget(
//                                 ControllerPhotoViewPage());
//                           },
//                           child: SizedBox(
//                             height: 10,
//                             child: Container(
//                               // margin: EdgeInsets.only(top: 30, bottom: 30),
//                               decoration: designShadow,
//                               child: Container(
//                                 decoration: new BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: clipRReactDesign,
//                                   boxShadow: [
//                                     new BoxShadow(
//                                       color: Colors.black12,
//                                       blurRadius: 4.1,
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: clipRReactDesign,
//                                   child: Image.asset(
//                                     'assets/images/hotel_2.png',
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
