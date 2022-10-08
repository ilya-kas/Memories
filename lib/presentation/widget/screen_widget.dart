import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories/presentation/bloc/gallery_bloc/gallery_bloc.dart';
import 'package:memories/presentation/page/gallery/gallery_page.dart';
import 'package:memories/presentation/page/map/map_page.dart';
import 'package:memories/presentation/widget/bottom_bar.dart';
import 'package:memories/resource/values.dart';
import 'package:memories/util/injection_container.dart';

class ScreenWidget extends StatefulWidget {
  const ScreenWidget({Key? key}) : super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  int _pageIndex = 0;
  GalleryBloc currentGalleryBloc = sl<GalleryBloc>();

  @override
  Widget build(BuildContext context) {
    currentGalleryBloc.stream.listen((event) { //listen for events from gallery
      if (event is SwitchState) {
        _switchPage(0);  //switch to map
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Memories",
          style: TextStyle(
            color: c_text,
            fontSize: 35.0,
            fontFamily: 'Italianno',
          ),
        ),
        backgroundColor: c_main,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: _getScreen(),
      bottomNavigationBar: BottomBar(
          (pageIndex) =>
              {currentGalleryBloc = sl<GalleryBloc>(), _switchPage(pageIndex)},
          _pageIndex),
    );
  }

  Widget _getScreen() {
    switch (_pageIndex) {
      case 0:
        return MapPage();
      case 1:
        return GalleryPage(currentGalleryBloc);
      default:
        return Text("Loaded");
    }
  }

  void _switchPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }
}
