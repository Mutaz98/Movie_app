import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavBarState { TVANDMOVIES, Favorites, TopRated }

class NavigationCubit extends Cubit<BottomNavBarState> {
  NavigationCubit() : super(BottomNavBarState.TVANDMOVIES);

  void changeTab(int index) {
    emit(BottomNavBarState.values[index]);
  }
}
