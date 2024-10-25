

abstract class RootEvent {}

class ChangeThemeEvent extends RootEvent {
  final String themeName;
  ChangeThemeEvent({required this.themeName});
}