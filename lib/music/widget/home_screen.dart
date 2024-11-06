import 'package:flutter/material.dart';
import 'package:flutter_application_1/music/mixins/ytmusic.dart';
import 'package:flutter_application_1/utils/pprint.dart';

import 'section_item.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final YTMusic ytMusic = YTMusic();
  late ScrollController _scrollController;
  late List chips = [];
  late List sections = [];
  int page = 0;
  String? continuation;
  bool initialLoading = true;
  bool nextLoading = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fetchHome();
    initAudio();
  }

  void initAudio() async {
    try {
      final duration = await player.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
      if (duration == null) {
        print("Unable to load audio. Please check the URL or format.");
      }
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void playAudio() async {
    await player.play();
  }

  _scrollListener() async {
    // print('_scrollListener');
    // if (initialLoading || nextLoading || continuation == null) {
    //   print('run1');
    //   return;
    // }

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('run2');
      await fetchNext();
    }
  }

  fetchHome() async {
    setState(() {
      initialLoading = true;
      nextLoading = false;
    });
    Map<String, dynamic> home = await ytMusic.browse();
    // pprint('HOME : $home');
    // print('Jo : ${home['continuation']}');
    if (mounted) {
      setState(() {
        initialLoading = false;
        nextLoading = false;
        chips = home['chips'];
        sections = home['sections'];
        continuation = home['continuation'];
      });
    }
  }

  refresh() async {
    if (initialLoading) return;
    Map<String, dynamic> home = await ytMusic.browse();
    if (mounted) {
      setState(() {
        initialLoading = false;
        nextLoading = false;
        chips = home['chips'];
        sections = home['sections'];
        continuation = home['continuation'];
      });
    }
  }

  fetchNext() async {
    if (continuation == null) return;
    setState(() {
      nextLoading = true;
    });
    Map<String, dynamic> home =
        await ytMusic.browseContinuation(additionalParams: continuation!);
    List<Map<String, dynamic>> secs =
        home['sections'].cast<Map<String, dynamic>>();
    if (mounted) {
      setState(() {
        sections.addAll(secs);
        continuation = home['continuation'];
        nextLoading = false;
      });
    }
  }

  Widget _horizontalChipsRow(List data) {
    var list = <Widget>[const SizedBox(width: 16)];
    for (var element in data) {
      list.add(
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            playAudio();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(element['title']),
          ),
        ),
      );
      list.add(const SizedBox(
        width: 8,
      ));
    }
    list.add(const SizedBox(
      width: 8,
    ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Material(
            color: Colors.transparent,
            child: LayoutBuilder(builder: (context, constraints) {
              return Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth > 400
                            ? (400)
                            : constraints.maxWidth),
                    child: const TextField(
                      // onTap: () => context.go('/search'),
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      autofocus: false,
                      textInputAction: TextInputAction.search,
                      // fillColor: Platform.isWindows
                      //     ? null
                      //     : Colors.grey.withOpacity(0.3),
                      // contentPadding: const EdgeInsets.symmetric(
                      //     vertical: 2, horizontal: 8),
                      // borderRadius:
                      //     BorderRadius.circular(Platform.isWindows ? 4.0 : 10),
                      // hintText: S.of(context).Search_Gyawun,
                      // prefix: Icon(AdaptiveIcons.search),
                    ),
                  ),
                ],
              );
            }),
          ),
          centerTitle: false,
        ),
      ),
      body: initialLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => refresh(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                controller: _scrollController,
                child: SafeArea(
                  child: Column(
                    children: [
                      _horizontalChipsRow(chips),
                      Column(
                        children: [
                          ...sections.map((section) {
                            return SectionItem(
                              section: section,
                              ytMusic: ytMusic,
                            );
                          }),
                          if (!nextLoading && continuation != null)
                            const SizedBox(height: 50),
                          if (nextLoading)
                            const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator()),

                          // const Padding(
                          // padding: EdgeInsets.all(8.0),
                          // child: Text('alskl')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
