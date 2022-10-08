import 'package:flutter/material.dart';
import 'package:memories/resource/values.dart';

class BottomBar extends StatelessWidget{
  final TextStyle _textStyle = TextStyle(
    color: c_text,
    fontSize: 15.0
  );

  final Function _raiser;
  final int _pageIndex;

  BottomBar(this._raiser, this._pageIndex);

  @override
  Widget build(BuildContext _) {
    return BottomNavigationBar(
      selectedItemColor: c_text,
      selectedLabelStyle: _textStyle,
      unselectedLabelStyle: _textStyle,
      unselectedItemColor: c_alt,
      onTap: (pageNum) => {_raiser(pageNum)},
      currentIndex: _pageIndex,

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "Map",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image),
          label: "Images",
        ),
      ],
      backgroundColor: c_main,
    );
  }
}