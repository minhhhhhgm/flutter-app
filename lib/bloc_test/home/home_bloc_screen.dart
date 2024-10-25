import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/home/bloc/home_bloc.dart';
import 'package:flutter_application_1/bloc_test/home/bloc/home_event.dart';
import 'package:flutter_application_1/bloc_test/home/bloc/home_state.dart';
import 'package:flutter_application_1/bloc_test/setting/setting_bloc_screen.dart';
import 'package:flutter_application_1/db/hive_config.dart';
import 'package:flutter_application_1/models/post_response.dart';
import 'package:flutter_application_1/root_bloc/root_bloc.dart';
import 'package:flutter_application_1/root_bloc/root_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBlocScreen extends StatefulWidget {
  const HomeBlocScreen({super.key});

  @override
  State<HomeBlocScreen> createState() => _HomeBlocScreenState();
}

class _HomeBlocScreenState extends State<HomeBlocScreen> {
  int index = 0;

  final screens = [
    BlocProvider(
        create: (BuildContext context) {
          return HomeBloc();
        },
        child: const Home()),
    const SettingBlocScreen()
  ];

  void onChangeIndex(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      builder: (context, state) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: onChangeIndex,
            currentIndex: index,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
            ]),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Home Page' , style: Theme.of(context).textTheme.bodySmall,),
        ),
        body: IndexedStack(
          index: index,
          children: screens,
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostResponse> posts = [];
  final RefreshController refreshController = RefreshController();
  void showDialogComment() {
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 30),
            child: const SizedBox(
              width: double.infinity,
              child: Column(
                children: [],
              ),
            ),
          );
        });
  }

  void listener(BuildContext context, HomeState state) {
    // if (state is HomeStateInit) {
    //   showDialog(
    //       barrierDismissible: false,
    //       context: context,
    //       builder: (BuildContext context) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       });
    // }
    if (state is ListHomeState) {
      // Navigator.of(context).pop();
      posts = state.post;
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(GetHomeList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    refreshController.dispose();
  }

  void testPut() {
    box.put('cc', 'ss');
  }

  void testGet() {
    var x = box.get('cc');
    print('cc $x');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: listener,
        builder: (BuildContext context, state) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Expanded(
                    child: SmartRefresher(
                  onLoading: () {
                    if (context.read<HomeBloc>().hasMoreData) {
                      context
                          .read<HomeBloc>()
                          .add(GetHomeList(isLoadmore: true));
                    } else {
                      print('object');
                      refreshController.loadNoData();
                    }
                  },
                  onRefresh: (){
                    print('onRefresh');
                    refreshController.refreshCompleted();
                  },
                  header: const WaterDropHeader(
                    complete: SizedBox(),
                    refresh: SizedBox(),
                  ),
                  enablePullDown: true,
                  enablePullUp: true,
                  physics: const BouncingScrollPhysics(),
                  footer: CustomFooter(
                    loadStyle: LoadStyle.ShowWhenLoading,
                    builder: (context, mode) {
                      return const Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          CircularProgressIndicator(),
                        ],
                      );
                    },
                  ),
                  controller: refreshController,
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = posts[index];
                      return PostItem(
                        t1: testPut,
                        t2: testGet,
                        post: post,
                        showDialogComment: (id) => showDialogComment(),
                      );
                    },
                  ),
                ))
              ],
            ),
          ));
        });
  }
}

class PostItem extends StatelessWidget {
  const PostItem(
      {super.key,
      required this.post,
      this.showDialogComment,
      required this.t1,
      required this.t2});
  final PostResponse post;
  final Function(String)? showDialogComment;
  final Function() t1;
  final Function() t2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.network(post.image ?? ''),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: t1,
                  child: const Icon(
                    Icons.heart_broken_sharp,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                InkWell(
                  onTap: t2,
                  child: const Icon(
                    Icons.mode_comment_outlined,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                InkWell(
                  onTap: () {
                    showDialogComment!('sss');
                  },
                  child: const Icon(
                    Icons.share_outlined,
                    size: 30,
                  ),
                )
              ],
            ),
            const Icon(
              Icons.bookmark_add_outlined,
              size: 30,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        RichText(
          text: TextSpan(
              text: 'Id ',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                    text: post.id ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w400))
              ]),
        ),
        const SizedBox(
          height: 8,
        ),
        RichText(
          text: TextSpan(
              text: post.author?.name ?? '',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                    text: post.content ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w400))
              ]),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
