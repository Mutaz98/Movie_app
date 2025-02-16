class MovieModelLocal {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;

  // Constructor
  MovieModelLocal({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
  });

  // Method to convert MovieModel to Map (for saving in the database)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'overview': overview,
    };
  }

  // Method to create MovieModel from a Map (for reading from the database or JSON)
  factory MovieModelLocal.fromMap(Map<String, dynamic> map) {
    return MovieModelLocal(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      releaseDate: map['releaseDate'],
      overview: map['overview'],
    );
  }

  // Method to create MovieModel from JSON (usually from an API response)
  factory MovieModelLocal.fromJson(Map<String, dynamic> json) {
    return MovieModelLocal(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      overview: json['overview'],
    );
  }

  // Method to convert MovieModel to JSON (to send to an API or save as JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'overview': overview,
    };
  }
}
