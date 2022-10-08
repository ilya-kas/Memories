import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories/presentation/bloc/gallery_bloc/gallery_bloc.dart';

class GalleryPage extends StatelessWidget{
  final GalleryBloc _bloc;

  GalleryPage(this._bloc);

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          switch (state.runtimeType){
            case Hidden:
              _sendEvent(context, LoadGalleryEvent());
              return Text("Hidden");
            case Loading:
              return Text("Loading"); //no need in loading circle, cause data is cached locally
            case Loaded:
              return GridView.count(
                crossAxisCount: 2,
                children: _getImages(state as Loaded, context),
              );
            default:
              return Text("Gallery");
          }
        },
      ),
    );
  }

  List<Widget> _getImages(Loaded state, BuildContext context){
    List<Widget> result = [];
    for (int i=0; i < state.memories.length; i++)
      result.add(GestureDetector(
        child: Column(
          children: [Container(
              margin: EdgeInsets.only(left:5, top:5,right:5,bottom:5),
              child: Image(
                image: state.memories[i].image!,
                fit: BoxFit.fitHeight,
                width: 150,
                height: 150,
              ),
          ),
            Text(i.toString())],
        ),
        onTap: () => {
          _bloc.args.bundle["selected image"] = i,  //buffer selected picture number
          _sendEvent(context, SelectImageEvent(i))
        },
      ));
    return result;
  }

  void _sendEvent(BuildContext context, GalleryEvent event){
    BlocProvider.of<GalleryBloc>(context).add(event);
  }
}