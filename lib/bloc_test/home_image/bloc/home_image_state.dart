
import 'package:flutter_application_1/bloc_test/home_image/models/photo_response.dart';

abstract class HomeImageState {}

class InitialState extends HomeImageState{

}

class GetImagePhotoState extends HomeImageState{
    final List<Photo> listPhoto;
    GetImagePhotoState({required this.listPhoto});
}