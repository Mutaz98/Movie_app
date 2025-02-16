import 'package:flutter_dotenv/flutter_dotenv.dart';

const String kBaseUrl = 'https://api.themoviedb.org/3/';
const String kGetJobsEndPoint = 'jobs/api';
String apiKey = '${dotenv.env['TMDB_API_KEY']}';
