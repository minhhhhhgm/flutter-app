 import 'package:flutter_application_1/bloc_test/edit_image/bloc/edit_image_state.dart';
import 'package:flutter_application_1/bloc_test/edit_image/models/dragable_child_widget.dart';
import 'package:flutter_application_1/bloc_test/edit_image/widgets/dragable_widget.dart';

abstract class EditImageEvent {}


 class EditWidgetEvent extends EditImageEvent{
    final int widgetId;
    final DragableWidgetChild widget;
    EditWidgetEvent({required this.widgetId , required this.widget});
 }

 class AddWidgetEvent extends EditImageEvent{
  final DragableWidget widget;
  AddWidgetEvent({required this.widget});
 }

 class DeleteWidgetEvent extends EditImageEvent{
   final int widgetId;
   DeleteWidgetEvent({required this.widgetId});
 }

 class ChangeEditEvent extends EditImageEvent{
   final EditState editState;
   ChangeEditEvent({required this.editState});
 }

  class ChangeOpacityLayer extends EditImageEvent{
   final double v;
   ChangeOpacityLayer({required this.v});
 }