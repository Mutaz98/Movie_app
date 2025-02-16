import 'package:json_annotation/json_annotation.dart';
// part 'api_dto.g.dart';

// @JsonSerializable()
class APIResponse {
  final int page;
  final dynamic results;
  final int totalPages;
  final int totalResults;

  APIResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  /// Factory constructor to deserialize JSON
  factory APIResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return APIResponse(
      page: json['page'] as int,
      results: json['results'] as dynamic,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}

@JsonSerializable()
class APIError {
  String errorType;
  String title;
  int status;
  String traceId;
  String errors;

  APIError(this.errorType, this.title, this.status, this.traceId, this.errors);

  factory APIError.fromJson(Map<String, dynamic> json) => APIError(
        json['errorType'] as String,
        json['title'] as String,
        json['status'] as int,
        json['traceId'] as String,
        json['errors'] as String,
      );
}
