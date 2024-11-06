import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/edit_image/bloc/edit_image_bloc.dart';
import 'package:flutter_application_1/bloc_test/edit_image/bloc/edit_image_event.dart';
import 'package:flutter_application_1/bloc_test/edit_image/bloc/edit_image_state.dart';
import 'package:flutter_application_1/bloc_test/edit_image/models/dragable_child_widget.dart';
import 'package:flutter_application_1/bloc_test/edit_image/widgets/add_text_layout.dart';
import 'package:flutter_application_1/bloc_test/edit_image/widgets/dragable_widget.dart';
import 'package:flutter_application_1/bloc_test/edit_image/widgets/edit_photo_widget.dart';
import 'package:flutter_application_1/bloc_test/edit_image/widgets/menu_icon_widget.dart';
import 'package:flutter_application_1/bloc_test/home_image/models/photo_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPhotoScreen extends StatelessWidget {
  const EditPhotoScreen({super.key, required this.mPhoto});
  final Photo mPhoto;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditImageBloc(),
      child: EditPhotoLayout(
        photo: mPhoto,
      ),
    );
  }
}

class EditPhotoLayout extends StatefulWidget {
  const EditPhotoLayout({super.key, required this.photo});
  final Photo photo;
  @override
  State<EditPhotoLayout> createState() => _EditPhotoLayoutState();
}

class _EditPhotoLayoutState extends State<EditPhotoLayout> {
  late Photo photo;
  // ScreenshotController screenshotController = ScreenshotController();

  @override
  void didChangeDependencies() {
    // photo = ModalRoute.of(context)?.settings.arguments as Photo;
    photo = widget.photo;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    photo = widget.photo;
    print(widget.photo.alt);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditImageBloc, EditImageState>(
      builder: (context, state) => Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            ///
            // Screenshot(
            //   controller: screenshotController,
            //   child: EditPhotoWidget(photo: photo),
            // ),
            EditPhotoWidget(photo: photo),

            ///
            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              child: MenuIconWidget(
                onTap: () async {
                  Navigator.pop(context);
                  // final result = await showDialog(
                  //   context,
                  //   title: "Discard Edits",
                  //   desc:
                  //       "Are you sure want to Exit ? You'll lose all the edits you've made",
                  // );
                  // if (result == null) return;

                  // if (result) {
                  //   if (!mounted) return;
                  //   Navigator.pop(context);
                  // }
                },
                icon: Icons.arrow_back_ios_new_rounded,
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).padding.top + 20,
              right: 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MenuIconWidget(
                    onTap: () async {
                      // context
                      //     .read<EditImageBloc>()
                      //     .changeDownloadStatus(DownloadStatus.downloading);

                      // final image = await screenshotController.capture(
                      //   delay: const Duration(milliseconds: 200),
                      // );
                      // if (!mounted) return;
                      // context.read<EditPhotoCubit>().downloadImage(image);
                    },
                    icon: CupertinoIcons.cloud_download,
                  ),
                  const SizedBox(width: 16),
                  MenuIconWidget(
                    onTap: () async {
                      // context
                      //     .read<EditPhotoCubit>()
                      //     .changeShareStatus(DownloadStatus.downloading);

                      // final image = await screenshotController.capture(
                      //   delay: const Duration(milliseconds: 200),
                      // );
                      // if (!mounted) return;
                      // context.read<EditPhotoCubit>().shareImage(image);
                    },
                    icon: CupertinoIcons.share,
                  ),
                ],
              ),
            ),

            Positioned(
              left: 20,
              bottom: MediaQuery.of(context).padding.bottom + 20,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<EditImageBloc, EditImageState>(
                        buildWhen: (p, c) {
                          return p.editState != c.editState ||
                              p.opacityLayer != c.opacityLayer;
                        },
                        builder: (context, state) {
                          return Visibility(
                            visible: state.editState == EditState.layering,
                            maintainState: true,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Slider(
                                  value: state.opacityLayer,
                                  min: 0,
                                  max: 1,
                                  onChanged: (value) => context
                                      .read<EditImageBloc>()
                                      .add(ChangeOpacityLayer(v: value)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      MenuIconWidget(
                        onTap: () async {
                          final curentState =
                              context.read<EditImageBloc>().state.editState;

                          if (curentState == EditState.layering) {
                            context.read<EditImageBloc>().add(
                                ChangeEditEvent(editState: EditState.idle));
                          } else {
                            context.read<EditImageBloc>().add(
                                ChangeEditEvent(editState: EditState.layering));
                          }
                        },
                        icon: Icons.layers,
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  MenuIconWidget(
                    onTap: () async {
                      context.read<EditImageBloc>().add(
                          ChangeEditEvent(editState: EditState.addingText));

                      final result = await addText(context);

                      if (result == null ||
                          result is! DragableWidgetTextChild) {
                        if (!mounted) return;
                        context
                            .read<EditImageBloc>()
                            .add(ChangeEditEvent(editState: EditState.idle));
                        return;
                      }

                      final widget = DragableWidget(
                        widgetId: DateTime.now().millisecondsSinceEpoch,
                        child: result,
                        onPress: (id, widget) async {
                          if (widget is DragableWidgetTextChild) {
                            context.read<EditImageBloc>().add(ChangeEditEvent(
                                editState: EditState.addingText));

                            final result = await addText(
                              context,
                              widget,
                            );

                            if (result == null ||
                                result is! DragableWidgetTextChild) {
                              if (!mounted) return;
                              context.read<EditImageBloc>().add(
                                  ChangeEditEvent(editState: EditState.idle));
                              return;
                            }

                            if (!mounted) return;
                            context.read<EditImageBloc>().add(
                                EditWidgetEvent(widgetId: id, widget: result));
                          }
                        },
                        onLongPress: (id) async {
                          // final result = await showConfirmationDialog(
                          //   context,
                          //   title: "Delete Text ?",
                          //   desc: "Are you sure want to Delete this text ?",
                          //   rightText: "Delete",
                          // );
                          // if (result == null) return;

                          // if (result) {
                          //   if (!mounted) return;
                          //   context.read<EditPhotoCubit>().deleteWidget(id);
                          // }
                        },
                      );

                      if (!mounted) return;
                      context
                          .read<EditImageBloc>()
                          .add(AddWidgetEvent(widget: widget));
                    },
                    icon: Icons.text_fields_rounded,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
