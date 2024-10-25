
import 'package:flutter_application_1/models/post_response.dart';

abstract class HomeState {}

class HomeStateInit extends HomeState{}

class ListHomeLoading extends HomeState{}

class ListHomeState extends HomeState{
  final List<PostResponse> post;

  ListHomeState({required this.post});
}