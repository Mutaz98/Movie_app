import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/discover/presentation/ui/screen/discover_screen.dart';
import 'package:movie_app/features/favourite/presentation/ui/screen/fav_screen.dart';
import 'package:movie_app/features/main/navigation_cubit.dart';
import 'package:movie_app/features/toprated/presentation/ui/screen/top_rated_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _getSelectedPage(state),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            color: Theme.of(context)
                .scaffoldBackgroundColor, // No gradient background
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _navItems.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> item = entry.value;
                bool isSelected = state == BottomNavBarState.values[index];
                return GestureDetector(
                  onTap: () {
                    context.read<NavigationCubit>().changeTab(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          isSelected
                              ? item['activeIcon']
                              : item['inactiveIcon'],
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey, // Color change
                          size: 24, // Smaller icon size
                        ),
                      ),
                      const SizedBox(
                          height: 4), // Smaller space between icon and label
                      Text(
                        item['label'],
                        style: TextStyle(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey, // Matching label color
                          fontSize: 12, // Smaller font size
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Example method to return the selected page
  Widget _getSelectedPage(BottomNavBarState state) {
    switch (state) {
      case BottomNavBarState.TVANDMOVIES:
        return DiscoverPage();
      case BottomNavBarState.Favorites:
        return FavoriteScreen();
      case BottomNavBarState.TopRated:
        return TopRatedScreen();
    }
  }

  final List<Map<String, dynamic>> _navItems = [
    {
      'inactiveIcon': Icons.movie,
      'activeIcon': Icons.movie_outlined,
      'label': 'Movies & TV',
    },
    {
      'inactiveIcon': Icons.favorite_border,
      'activeIcon': Icons.favorite,
      'label': 'Favorites',
    },
    {
      'inactiveIcon': Icons.star_border,
      'activeIcon': Icons.star,
      'label': 'Top Rated',
    },
  ];
}
