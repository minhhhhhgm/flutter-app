import 'package:flutter_application_1/bloc_test/edit_image/widgets/dragable_widget.dart';


enum EditState {
  idle,
  layering,
  addingText,
}

abstract class EditImageStateRoot{}

class EditImageStateInit extends EditImageState{}

class EditImageState extends EditImageStateRoot{
  final EditState editState;
  final double opacityLayer;
  final List<DragableWidget> widgets;


  EditImageState({
    this.editState = EditState.idle,
    this.opacityLayer = 0.0,
    this.widgets = const [],
  });

  // Copy method to replicate the behavior of Freezed's copyWith
  EditImageState copyWith({
    EditState? editState,
    double? opacityLayer,
    List<DragableWidget>? widgets,
   
  }) {
    return EditImageState(
      editState: editState ?? this.editState,
      opacityLayer: opacityLayer ?? this.opacityLayer,
      widgets: widgets ?? this.widgets,
    );
  }
}
