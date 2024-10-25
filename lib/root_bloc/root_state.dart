
abstract class RootState {}

class RootStateInit extends RootState{
  
}

class ChangeThemeState extends RootState{
  final String themeName;
  ChangeThemeState({required this.themeName});
}