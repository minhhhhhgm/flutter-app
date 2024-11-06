import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/detail_image/detail_image_screen.dart';
import 'package:flutter_application_1/bloc_test/home_image/bloc/home_image_bloc.dart';
import 'package:flutter_application_1/bloc_test/home_image/bloc/home_image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class PhotosWidget extends StatelessWidget {
  const PhotosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeImageBloc, HomeImageState>(
      builder: (context, state) {
        if (state is GetImagePhotoState) {
          if (state.listPhoto.isEmpty) {
            return const PhotosLoading();
          }

          return SliverGrid(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: const [
                QuiltedGridTile(2, 1),
                QuiltedGridTile(1, 1),
              ],
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   AppRouteName.detailPhoto,
                    //   arguments: state.listPhoto[index],
                    // );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailImageScreen(photo: state.listPhoto[index]),));

                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        state.listPhoto[index].src?.portrait ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image_rounded,
                              // color: AppColor.primaryColor,
                            ),
                          );
                        },
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Text(
                          state.listPhoto[index].photographer ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: state.listPhoto.length,
            ),
          );
        } else {
          return const PhotosLoading();
        }
      },
    );
  }
}

class PhotosLoading extends StatelessWidget {
  const PhotosLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 1),
          QuiltedGridTile(1, 1),
        ],
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              color: Colors.white,
            ),
          );
        },
        childCount: 4,
      ),
    );
  }
}
