import 'package:flutter_application_1/root_bloc/root_event.dart';
import 'package:flutter_application_1/root_bloc/root_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  late int index;
  bool isExpand = false;
  RootBloc() : super(RootStateInit()) {
    index = -1;
    on<ChangeThemeEvent>(onChangeTheme);
  }

  void onChangeTheme(ChangeThemeEvent event, Emitter<RootState> emit) {
    index = event.index ?? -1;
    if (event.isExpand == true) {
      isExpand = !isExpand;
      emit(ChangeThemeState(themeName: event.themeName));
      print('event.themeName ${event.themeName}');
    } else {
      isExpand = false;

      emit(ChangeThemeState(themeName: event.themeName));
    }
  }
}
