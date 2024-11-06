import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/detail_image/detail_image_screen.dart';
import 'package:flutter_application_1/bloc_test/home_image/bloc/home_image_bloc.dart';
import 'package:flutter_application_1/bloc_test/home_image/bloc/home_image_event.dart';
import 'package:flutter_application_1/bloc_test/home_image/bloc/home_image_state.dart';
import 'package:flutter_application_1/bloc_test/home_image/photo_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeImageScreen extends StatelessWidget {
  const HomeImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeImageBloc(),
      child: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    context.read<HomeImageBloc>().add(GetPhotoEvent(page: 1, perPage: 10));
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        header: CustomHeader(
          builder: (context, mode) {
            if (mode == RefreshStatus.idle) {
              return const SizedBox();
            }
            return const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        footer: CustomFooter(
          builder: (context, mode) {
            if (mode == LoadStatus.idle) {
              return const SizedBox();
            }
            return const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        enablePullUp: true,
        onRefresh: () {
          refreshController.refreshCompleted();
          // context.read<HomeCubit>().getCollection(showLoading: false);
          // context.read<HomeCubit>().getPhotos(showLoading: false);
        },
        // enablePullDown: true,
        onLoading: () {
          if (context.read<HomeImageBloc>().hasLoadMore) {
            context
                .read<HomeImageBloc>()
                .add(GetPhotoEvent(page: 1, perPage: 10, loadMore: true));
          } else {
            return;
          }
           refreshController.loadComplete();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // forceElevated : true,
              scrolledUnderElevation: 0,
              // forceMaterialTransparency: true,
              floating: true,
              centerTitle: false,
              title: Text(
                "Discovers",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              // backgroundColor: Theme.of(context).backgroundColor,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(76),
                child: Container(
                  height: 76,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailImageScreen(photo: photo),));
                    },
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add_ic_call,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Search keyword, nature",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SliverPersistentHeader(
            //   pinned: true,
            //   delegate: CollectionWidget(),
            // ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Popular Images",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: PhotosWidget(),
              // sliver: SliverFillRemaining(child: PhotosWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
