
abstract class HomeEvent {}

class GetHomeList extends HomeEvent{
  final bool? isLoadmore;
  GetHomeList({this.isLoadmore = false});
}