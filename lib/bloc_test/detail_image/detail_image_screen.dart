import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/bloc_test/edit_image/edit_image_screen.dart';
import 'package:flutter_application_1/bloc_test/home_image/models/photo_response.dart';

class DetailImageScreen extends StatelessWidget {
  const DetailImageScreen({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          splashRadius: 20,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).textTheme.headlineLarge?.color,
          ),
        ),
        centerTitle: false,
        title: Text(
          "Detail Photo",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // context.read<DetailPhotoCubit>().sharePhoto(photo.src.large);
            },
            splashRadius: 20,
            icon: Icon(
              CupertinoIcons.share,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.66,
            child: Image(
              image: NetworkImage(
                photo.src?.original ?? '',
              ),
              // fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              },
              // loadingBuilder: (_, widget, progress) {
              //   if (progress == null) {
              //     return widget;
              //   }

              //   return Image(
              //     image: NetworkImage(photo.src?.portrait ??''),
              //     fit: BoxFit.cover,
              //     loadingBuilder: (context, child, loadingProgress) {
              //       if (loadingProgress == null) {
              //         return child;
              //       }
              //       return Center(
              //         child: CircularProgressIndicator(
              //           value: loadingProgress.expectedTotalBytes != null
              //               ? loadingProgress.cumulativeBytesLoaded /
              //                   loadingProgress.expectedTotalBytes!
              //               : null,
              //         ),
              //       );
              //     },
              //     errorBuilder: (_, __, ___) {
              //       return const Center(
              //         child: Icon(
              //           Icons.broken_image_sharp,
              //           color: Colors.blueGrey,
              //         ),
              //       );
              //     },
              //   );
              // },
              errorBuilder: (_, __, ___) {
                return const Center(
                  child: Icon(
                    Icons.broken_image_rounded,
                    // color: AppColor.primaryColor,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          photo.photographer ?? '',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        if (photo.alt != null &&
                            photo.alt?.isNotEmpty == true) ...[
                          Text(
                            photo.alt ?? "",
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 2,
                          ),
                          const SizedBox(height: 16),
                        ],
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                photo.avgColor ?? '',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.pushNamed(
                            //   context,
                            //   AppRouteName.editPhoto,
                            //   arguments: photo,
                            // );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditPhotoScreen(mPhoto: photo),));
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Edit Photo",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () {
                            // context
                            //     .read<DetailPhotoCubit>()
                            //     .downloadPhoto(photo.src.original);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: Icon(
                            CupertinoIcons.cloud_download,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.color,
                          ),
                          label: Text(
                            "Download",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
