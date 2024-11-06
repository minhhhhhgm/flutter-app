import 'package:flutter_application_1/bloc_test/home/bloc/home_event.dart';
import 'package:flutter_application_1/bloc_test/home/bloc/home_state.dart';
import 'package:flutter_application_1/models/post_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late List<PostResponse> listForm;
  late int page;
  bool hasMoreData = true;

  HomeBloc() : super(HomeStateInit()) {
    listForm = [];
    page = 1;
    on<GetHomeList>(getHomeList);
  }

  void getHomeList(GetHomeList event, Emitter<HomeState> emit) async {
    if (event.isLoadmore == true) {
      page += 1;
    } else {
      page = 1;
      // hasMoreData = true;
    }

    try {
      final url = Uri.http('10.22.20.8:4000', '/post/getAllPost',
          {'page': '$page', 'size': '3'});
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDhjZmY3M2MwM2YwZDJiZmMwMDgxNyIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCR4Rnk5NWJoTkNFUjB3a01ZOG5DeHplZkplcmg0Q3hBZXAvM1ZvWmtVLnM5NWxFOXFTbS53UyIsImVtYWlsIjoib2MzQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbXSwiZm9sbG93aW5nIjpbXSwiY3JlYXRlZEF0IjoiMjAyNC0xMC0xMVQwNzoxMjo1NS42NTdaIiwidXBkYXRlZEF0IjoiMjAyNC0xMC0xMVQwOTo1NDo0NC4wODZaIiwiX192IjowfSwiaWF0IjoxNzMwNzA3ODYzLCJleHAiOjE3MzE1NzE4NjN9.QiBjBeGdnmjDF5y167MvNk0XUxUQFA1V9ywpb1QSwRQ"
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        final posts =
            jsonData.map((json) => PostResponse.fromJson(json)).toList();

        if (posts.isEmpty) {
          hasMoreData = false; // Set flag if no more data is returned
          emit(ListHomeState(post: listForm)); // Emit current data
          return;
        }

        if (event.isLoadmore == false) {
          listForm = posts;
        } else {
          listForm.addAll(posts);
        }

        emit(ListHomeState(post: listForm));
      } else {
        throw Exception(
            'Failed to load posts with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
