import 'package:flutter_application_1/bloc_test/edit_image/bloc/edit_image_event.dart';
import 'package:flutter_application_1/bloc_test/edit_image/bloc/edit_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditImageBloc extends Bloc<EditImageEvent, EditImageState> {
  EditImageBloc() : super(EditImageStateInit()) {
    on<EditWidgetEvent>(onEditWidget);
    on<AddWidgetEvent>(onAddWidget);
    on<ChangeEditEvent>(onChangeEdit);
    on<ChangeOpacityLayer>(onChangeOpacity);
  }

  void onEditWidget(EditWidgetEvent event, Emitter<EditImageStateRoot> emit) {
    var index = state.widgets.indexWhere((e) => e.widgetId == event.widgetId);
    if (index == -1) return;
    state.widgets[index].child = event.widget;

    emit(state.copyWith(
      editState: EditState.idle,
      widgets: List.from(state.widgets),
    ));
  }

  void onAddWidget(AddWidgetEvent event, Emitter<EditImageStateRoot> emit) {
    emit(state.copyWith(
      editState: EditState.idle,
      widgets: List.from(state.widgets)..add(event.widget),
    ));
  }

  void onChangeEdit(ChangeEditEvent event, Emitter<EditImageStateRoot> emit) {
    emit(state.copyWith(editState: event.editState));
  }

  void onChangeOpacity(
      ChangeOpacityLayer event, Emitter<EditImageStateRoot> emit) {
    emit(state.copyWith(opacityLayer: event.v));
  }
}
