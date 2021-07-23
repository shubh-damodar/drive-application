import 'package:cached_network_image/cached_network_image.dart';
import 'package:file/network/user_connect.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ControllerPhotoViewPage extends StatefulWidget {
  String imageUrl;

  ControllerPhotoViewPage({this.imageUrl});
  @override
  _ControllerPhotoViewPageState createState() =>
      _ControllerPhotoViewPageState();
}

class _ControllerPhotoViewPageState extends State<ControllerPhotoViewPage> {
  PhotoViewController photoViewController;

  @override
  void initState() {
    super.initState();
    photoViewController = PhotoViewController();
  }

  @override
  void dispose() {
    super.dispose();
    //! Don't forget to dispose of the controller!
    photoViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.imageUrl}",
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        // title: Text('Controller Photo View'),
      ),
      // Stack puts widgets "on top" of each other
      body: Center(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: '${Connect.filesUrl}${widget.imageUrl}',
          placeholder: (BuildContext context, String url) {
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  PhotoView _buildPhotoView(BuildContext context) {
    return PhotoView(
      controller: photoViewController,
      imageProvider: NetworkImage(
        '${Connect.filesUrl}${widget.imageUrl}',
      ),
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      loadingChild: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  StreamBuilder<PhotoViewControllerValue> _buildScaleInfo() {
    return StreamBuilder(
      stream: photoViewController.outputStateStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<PhotoViewControllerValue> snapshot,
      ) {
        if (!snapshot.hasData) return Container();
        return Center(
          child: Text(
            'Scale compared to the original: \n${snapshot.data.scale}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  RaisedButton _buildResetScaleButton() {
    return RaisedButton(
      child: Text('Reset Scale'),
      onPressed: () {
        photoViewController.scale = photoViewController.initial.scale;
      },
    );
  }
}
