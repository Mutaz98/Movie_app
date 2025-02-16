import 'package:movie_app/core/utils/data_base_helper.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesLocalDataSource {
  static const String _tableName = 'favorites';

  final DatabaseHelper databaseHelper;

  FavoritesLocalDataSource(this.databaseHelper);

  Future<void> addMovieToFavorites(MovieModelLocal movie) async {
    final db = await databaseHelper.database;
    await db.insert(
      _tableName,
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeMovieFromFavorites(int movieId) async {
    final db = await databaseHelper.database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [movieId],
    );
  }

  Future<bool> isFavorite(int movieId) async {
    final db = await databaseHelper.database;
    final result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [movieId],
    );
    return result.isNotEmpty;
  }

  Future<List<MovieModelLocal>> getFavorites() async {
    final db = await databaseHelper.database;
    final result = await db.query(_tableName);
    return result.map((e) => MovieModelLocal.fromMap(e)).toList();
  }
}
