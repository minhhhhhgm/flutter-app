

abstract class RootEvent {}

class ChangeThemeEvent extends RootEvent {
  final String themeName;
  final int? index;
  final bool? isExpand;
  ChangeThemeEvent({required this.themeName, this.index , this.isExpand});
}