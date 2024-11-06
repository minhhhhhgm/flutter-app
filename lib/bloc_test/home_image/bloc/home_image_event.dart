
abstract class HomeImageEvent {}

class GetPhotoEvent extends HomeImageEvent{
  final int page;
  final int perPage;
  final bool? loadMore;

  GetPhotoEvent({required this.page , required this.perPage , this.loadMore});


}