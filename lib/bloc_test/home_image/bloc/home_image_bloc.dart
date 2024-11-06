import 'package:flutter_application_1/bloc_test/home_image/bloc/home_image_event.dart';
import 'package:flutter_application_1/bloc_test/home_image/bloc/home_image_state.dart';
import 'package:flutter_application_1/bloc_test/home_image/models/photo_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeImageBloc extends Bloc<HomeImageEvent, HomeImageState> {
  int page = 1;
  bool hasLoadMore = true;
  List<Photo> photos = [];

  HomeImageBloc() : super(InitialState()) {
    on<GetPhotoEvent>(handleGetPhoto);
  }

  void handleGetPhoto(GetPhotoEvent event, Emitter<HomeImageState> emit) async {
    if (event.loadMore == true) {
      page += 1;
    }
    print(page);
    try {
      final url = Uri.https('api.pexels.com', '/v1/curated',
          {'page': '$page', 'per_page': '${event.perPage}'});

      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization":
            "LKXKfxwS5goqhKw43mFoVmK4KXBsrpzgWB4LLv7lr8yqL6xXTHbdSAHu"
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final photoRes = PhotoResponse.fromJson(jsonData);
        if(event.loadMore == true){
         photos.addAll(photoRes.photos);
        }else{
          photos = photoRes.photos;
        }
        if (photoRes.photos.isEmpty) {
          hasLoadMore = false;
          return;
        }
        emit(GetImagePhotoState(listPhoto: photos));
      }
    } catch (e) {
      print(e);
    }
  }
}
