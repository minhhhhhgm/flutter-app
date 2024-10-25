
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/detail_post/bloc/post_bloc.dart';
import 'package:flutter_application_1/screens/detail_post/bloc/post_event.dart';
import 'package:flutter_application_1/screens/detail_post/bloc/post_state.dart';

class DetailPostScreen extends StatefulWidget {
  const DetailPostScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

//http://10.22.20.8:4000/post/getDetailPost

class _DetailPostScreenState extends State<DetailPostScreen> {
  final bloc = PostBloc();

  @override
  void initState() {
    bloc.postEvent.sink.add(GetPostDetail(id: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: bloc.postState.stream,
            builder:(BuildContext context , AsyncSnapshot<PostState> snapshot){
              final data = snapshot.data?.post;
              return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(data?.image ?? 'https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/03/anh-meme-hai-2.jpg.webp'),
                const SizedBox(height: 30,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text('Content :'),
                   const SizedBox(width: 15,),
                   Expanded(child: Text(data?.content ?? ''))
                ],
              )
              ],
            );
            } 
          ),
        ),
      ),
    );

    return Scaffold(
      appBar:AppBar(
        title: const Text('data'),
      ) ,
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // width: double.infinity,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
              
            
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.network('https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/03/anh-meme-hai-2.jpg.webp')),
               const Text('kajsdkjsakdjsk'),
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}