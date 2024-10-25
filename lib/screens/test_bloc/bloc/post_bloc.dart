import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/screens/test_bloc/bloc/post_event.dart';
import 'package:flutter_application_1/screens/test_bloc/bloc/post_state.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPosts>(onFetchPost);
  }

  void onFetchPost(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await _fetchPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError("Failed to fetch posts"));
    }
  }

  Future<List<Post>> _fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
        
    if (response.statusCode == 200) {
      final List<dynamic> postJson = json.decode(response.body);
      return postJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
