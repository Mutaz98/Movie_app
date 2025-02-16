import 'package:get_it/get_it.dart';
import 'package:movie_app/core/utils/data_base_helper.dart';
import 'package:movie_app/core/utils/helpers.dart';
import 'package:movie_app/features/auth/data/remote/data_sources/auth_api_interface.dart';
import 'package:movie_app/features/auth/data/remote/data_sources/auth_remote_data_source.dart';
import 'package:movie_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movie_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:movie_app/features/auth/domain/use_cases/create_session_use_case.dart';
import 'package:movie_app/features/auth/domain/use_cases/get_request_token_use_case.dart';
import 'package:movie_app/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:movie_app/features/auth/presentation/manager/auth_cubit.dart';
import 'package:movie_app/features/detail/data/remote/data_sources/detail_api_interface.dart';
import 'package:movie_app/features/detail/data/remote/data_sources/detail_remote_data_source.dart';
import 'package:movie_app/features/detail/data/repositories/detail_repository_impl.dart';
import 'package:movie_app/features/detail/domain/repositories/detail_repository.dart';
import 'package:movie_app/features/detail/domain/use_cases/get_details_tv_use_case.dart';
import 'package:movie_app/features/detail/domain/use_cases/get_details_use_case.dart';
import 'package:movie_app/features/detail/presentation/manager/detail_cubit.dart';
import 'package:movie_app/features/discover/data/remote/data_sources/discover_api_interface.dart';
import 'package:movie_app/features/discover/data/remote/data_sources/discover_remote_data_source.dart';
import 'package:movie_app/features/discover/data/repositories/discover_repository_impl.dart';
import 'package:movie_app/features/discover/domain/repositories/discover_repository.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_discover_movies_use_case.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_discover_tv_use_case.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_search_moive_use_case.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_search_tv_use_case.dart';
import 'package:movie_app/features/discover/presentation/manager/discover_cubit.dart';
import 'package:movie_app/features/favourite/data/local/fav_local_data_source.dart';
import 'package:movie_app/features/favourite/data/repositories/discover_repository_impl.dart';
import 'package:movie_app/features/favourite/domain/repositories/favorites_repository.dart';
import 'package:movie_app/features/favourite/presentation/manager/cubit.dart';
import 'package:movie_app/features/main/navigation_cubit.dart';
import 'package:movie_app/features/toprated/data/remote/data_sources/top_rated_api_interface.dart';
import 'package:movie_app/features/toprated/data/remote/data_sources/top_rated_remote_data_source.dart';
import 'package:movie_app/features/toprated/data/repositories/top_reated_repository_impl.dart';
import 'package:movie_app/features/toprated/domain/repositories/top_reated_repository.dart';
import 'package:movie_app/features/toprated/domain/use_cases/get_search_top_rated_use_case.dart';
import 'package:movie_app/features/toprated/domain/use_cases/get_top_rated_tv_use_case.dart';
import 'package:movie_app/features/toprated/presentation/manager/top_rated_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(
    () => AuthBloc(
      getRequestToken: sl(),
      createSession: sl(),
      logout: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => TopRatedCubit(
      getDiscoverTopRatedUseCase: sl(),
      getSearchMoviesTopRatedUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => DetailCubit(
      getDetailsMoviesUseCase: sl(),
      getDetailsTvsUseCase: sl(),
    ),
  );
  // sl.registerLazySingleton(
  //   () => AddToFavoritesEvent(
  //     sl(),
  //   ),
  // );
  sl.registerLazySingleton(
    () => MovieFavoriteBloc(localDataSource: FavoritesLocalDataSource(sl())),
  );
  sl.registerLazySingleton(
    () => NavigationCubit(),
  );
  sl.registerLazySingleton(
    () => DiscoverCubit(
      getDiscoverMoviesUseCase: sl(),
      getDiscoverTvShowsUseCase: sl(),
      getSearchMoviesUseCase: sl(),
      getSearchTvUseCase: sl(),
    ),
  );

  //Use Cases

  sl.registerLazySingleton(() => CreateSession(sl()));
  sl.registerLazySingleton(() => GetRequestTokenUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => GetDiscoverMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetDiscoverTvShowsUseCase(sl()));
  sl.registerLazySingleton(() => GetSearchMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetSearchTvUseCase(sl()));
  sl.registerLazySingleton(() => GetDiscoverTopRatedUseCase(sl()));
  sl.registerLazySingleton(() => GetSearchMoviesTopRatedUseCase(sl()));
  sl.registerLazySingleton(() => GetDetailsMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetDetailsTvsUseCase(sl()));

  //Repositories

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<DetailRepository>(
    () => DetailRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<TopRatedRepository>(
    () => TopRatedRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<DiscoverRepository>(
    () => DiscoverRepositoryImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<DetailRemoteDataSource>(
    () => DetailRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<TopRatedRemoteDataSource>(
    () => TopRatedRemoteDataSourceImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<DiscoverRemoteDataSource>(
    () => DiscoverRemoteDataSourceImpl(
      sl(),
    ),
  );

  //! External

  final dio = appDio;
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => AuthAPIInterface(sl()));
  sl.registerLazySingleton(() => DiscoverAPIInterface(sl()));
  sl.registerLazySingleton(() => TopRatedAPIInterface(sl()));
  sl.registerLazySingleton(() => DetailAPIInterface(sl()));
  // Register DatabaseHelper
  sl.registerLazySingleton(() => DatabaseHelper());
}
