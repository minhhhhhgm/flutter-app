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
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDhjZmY3M2MwM2YwZDJiZmMwMDgxNyIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCR4Rnk5NWJoTkNFUjB3a01ZOG5DeHplZkplcmg0Q3hBZXAvM1ZvWmtVLnM5NWxFOXFTbS53UyIsImVtYWlsIjoib2MzQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbXSwiZm9sbG93aW5nIjpbXSwiY3JlYXRlZEF0IjoiMjAyNC0xMC0xMVQwNzoxMjo1NS42NTdaIiwidXBkYXRlZEF0IjoiMjAyNC0xMC0xMVQwOTo1NDo0NC4wODZaIiwiX192IjowfSwiaWF0IjoxNzMwNzA3ODYzLCJleHAiOjE3MzE1NzE4NjN9.QiBjBeGdnmjDF5y167MvNk0XUxUQFA1V9ywpb1QSwRQ"
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
