

import 'package:flutter_application_1/root_bloc/root_event.dart';
import 'package:flutter_application_1/root_bloc/root_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootBloc extends Bloc<RootEvent, RootState>{
  RootBloc() : super(RootStateInit()){
    on<ChangeThemeEvent>(onChangeTheme);
  }


  void onChangeTheme(ChangeThemeEvent event , Emitter<RootState> emit){
      emit(ChangeThemeState(themeName: event.themeName));
  } 
  

}