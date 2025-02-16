import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/app_bloc_observer.dart';
import 'package:movie_app/di/injector.dart' as di;
import 'package:movie_app/features/auth/presentation/manager/auth_cubit.dart';
import 'package:movie_app/features/detail/presentation/manager/detail_cubit.dart';
import 'package:movie_app/features/discover/presentation/manager/discover_cubit.dart';
import 'package:movie_app/features/favourite/presentation/manager/cubit.dart';
import 'package:movie_app/features/main/main_pages.dart';
import 'package:movie_app/features/main/navigation_cubit.dart';
import 'package:movie_app/features/toprated/presentation/manager/top_rated_cubit.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  await di.init();
  await dotenv.load(fileName: ".envSercert");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MovieFavoriteBloc>(
        create: (_) => di.sl<MovieFavoriteBloc>(),
      ),
      BlocProvider<AuthBloc>(
        create: (_) => di.sl<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => di.sl<NavigationCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<DiscoverCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<TopRatedCubit>(),
      ),
      BlocProvider(
        create: (context) => di.sl<DetailCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movie App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const MainPage(),
          );
        });
  }
}
