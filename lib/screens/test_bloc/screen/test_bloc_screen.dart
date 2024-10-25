import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/test_bloc/bloc/post_bloc.dart';
import 'package:flutter_application_1/screens/test_bloc/bloc/post_event.dart';
import 'package:flutter_application_1/screens/test_bloc/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestBlocScreen extends StatelessWidget {
  const TestBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: BlocProvider(
        create: (context) => PostBloc(),
        child: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Post> listPost = [];

  @override
  void initState() {
    context.read<PostBloc>().add(FetchPosts());
    super.initState();
  }

  void listener(BuildContext context , PostState state){
    if(state is PostLoading){
      showDialog(context: context, builder: (BuildContext context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
    }

    if (state is PostLoaded){
      Navigator.pop(context);
      listPost = state.posts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: listener,
      builder: (context, state) {
      return ListView.builder(
        itemCount: listPost.length,
        itemBuilder: (context, index) {
          final post = listPost[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
          );
        },
      );
    });
  }
}
