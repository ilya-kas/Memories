import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories/presentation/bloc/map_bloc/map_bloc.dart';
import 'package:memories/presentation/widget/map_widget.dart';
import 'package:memories/resource/values.dart';
import 'package:memories/util/injection_container.dart';

class MapPage extends StatelessWidget {
  final MapBloc _bloc = sl<MapBloc>();

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
        create: (_) => _bloc,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (_bloc.args.bundle["selected image"] != null &&
                _bloc.args.bundle["selected image"] > -1) { //in case we switched to show concrete memory
              if (!(state is LoadedState))
                _sendEvent(context, LoadMapEvent());
              else {
                _sendEvent(context, ShowMarkerDescriptionEvent(_bloc.args.bundle["selected image"]));
                _bloc.args.bundle["selected image"] = -1;
              }
            }
            switch (state.runtimeType) {
              case Hidden:
                _sendEvent(context, LoadMapEvent());
                return Text("Map");
              case Loading:
                return Text("");
              case NoTempMemory:
              case HasATempMemory:
              case WithInfoPanel:
                return Scaffold(
                  body: MapWidget((event) => {_sendEvent(context, event)},
                      state as LoadedState),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: c_main,
                    foregroundColor: c_text,
                    child: Icon(Icons.add),
                    onPressed: () => _sendEvent(context, SaveMarkerEvent()),
                  ),
                );
              default:
                return Text("Map");
            }
          },
        ));
  }

  void _sendEvent(BuildContext context, MapEvent event) {
    BlocProvider.of<MapBloc>(context).add(event);
  }
}
