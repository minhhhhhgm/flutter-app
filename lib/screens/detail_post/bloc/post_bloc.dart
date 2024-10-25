import 'dart:async';
import 'package:flutter_application_1/screens/detail_post/bloc/post_event.dart';
import 'package:flutter_application_1/screens/detail_post/bloc/post_state.dart';
import 'package:flutter_application_1/screens/detail_post/model/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostBloc {
  var postState = StreamController<PostState>();
  var postEvent = StreamController<PostEvent>();

  PostBloc() {
    postEvent.stream.listen((event) async {
      if (event is GetPostDetail) {
        try {
          final url =
              Uri.parse('http://10.22.20.8:4000/post/getDetailPost?id=${event.id}');
          final response = await http.get(url, headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDY0MTkxN2Y4OTAwMTUxODcyMTc3ZSIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCQxQmlJV21LOUZhMGZxWmVIeFgzN3Uubmxyb245dEU3REhMRk1pQ3F6QkU4RmJOZ1pTMnNCVyIsImVtYWlsIjoib2MxQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbIjY3MDY1N2ZhN2Y4OTAwMTUxODcyMTc5OCJdLCJmb2xsb3dpbmciOltdLCJjcmVhdGVkQXQiOiIyMDI0LTEwLTA5VDA4OjQwOjQ5LjgyMloiLCJ1cGRhdGVkQXQiOiIyMDI0LTEwLTExVDEwOjA2OjIyLjY0OVoiLCJfX3YiOjB9LCJpYXQiOjE3Mjk0OTE1MjQsImV4cCI6MTczMDM1NTUyNH0.Vuaovk9qV8fDgS3aVly6agUCb1HIy7wUCcFJrDSHHZE"
          });

          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final postRes = Post.fromJson(data);
            var state = PostState(post: postRes);
            postState.sink.add(state);
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void dispose(){
    postEvent.close();
    postState.close();
  }
}
