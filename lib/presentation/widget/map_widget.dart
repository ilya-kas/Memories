import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memories/presentation/bloc/map_bloc/map_bloc.dart';
import 'package:memories/resource/values.dart';

final CustomInfoWindowController infoWindowController = CustomInfoWindowController(); //controller for hits above markers. DO NOT RECREATE
late GoogleMapController controller;    //controller for google maps api

class MapWidget extends StatelessWidget{
  final CameraPosition _initCameraPosition = CameraPosition(
      target: LatLng(53, 27),
      zoom: 4
  );

  final Function _eventRaiser;
  final LoadedState _state;

  MapWidget(this._eventRaiser, this._state);

  @override
  Widget build(BuildContext context) {
    if (_state is WithInfoPanel)
      _showImage((_state as WithInfoPanel).id);
    else
      try{
        infoWindowController.hideInfoWindow!(); //trying to close
      }catch (e){}  //there were nothing to close
    return Stack(
      children: [
        GoogleMap(
            initialCameraPosition: _initCameraPosition,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onLongPress: (coordinates) => _eventRaiser(AddMarkerEvent(coordinates)),
            markers: _getMarkers(),

            onTap: (position) => _eventRaiser(HideMarkerDescriptionEvent()),
            onCameraMove: (position) => infoWindowController.onCameraMove!(),
            onMapCreated: (GoogleMapController controller) async {
              controller = controller;
              infoWindowController.googleMapController = controller;
            }
        ),
        CustomInfoWindow(
          controller: infoWindowController,
          height: 170,
          width: 170,
          offset: 50,
        ),
      ],
    );
  }

  Set<Marker> _getMarkers(){
    Set<Marker> markers = Set();
    _state.memories.forEach((element) {
      int id = markers.length;
      markers.add(Marker(
        markerId: MarkerId(id.toString()),
        onTap: () => _eventRaiser(ShowMarkerDescriptionEvent(id)),
        position: _state.memories[id].position,
      )
    );} );
    if (_state is HasATempMemory)
      markers.add(Marker(
        markerId: MarkerId(markers.length.toString()),
        position: (_state as HasATempMemory).tempMemory.position,
      ));
    if ((_state is WithInfoPanel) && ((_state as WithInfoPanel).coveredState is HasATempMemory))
      markers.add(Marker(
        markerId: MarkerId(markers.length.toString()),
        position: ((_state as WithInfoPanel).coveredState as HasATempMemory).tempMemory.position,
      ));
    return markers;
  }

  void _showImage(int id){
    LatLng coordinates = _state.memories[id].position;
    infoWindowController.addInfoWindow!(Container(
      decoration: BoxDecoration(
        color: c_main,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Image(
            image: _state.memories[id].image!,
            fit: BoxFit.fitHeight,
            width: 150,
            height: 150,
          ),
      ),
    ),
      coordinates,
    );
  }
}