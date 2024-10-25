
abstract class PostEvent {}

class GetPostDetail extends PostEvent{
  final String id;
  GetPostDetail({required this.id});
}