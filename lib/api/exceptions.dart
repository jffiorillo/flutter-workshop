class HackerNewsApiError extends Error {
  final String message;

  HackerNewsApiError(this.message);
}

class HackerNewsApiException implements Exception {
  final int statusCode;
  final String message;

  const HackerNewsApiException({this.statusCode, this.message});
}