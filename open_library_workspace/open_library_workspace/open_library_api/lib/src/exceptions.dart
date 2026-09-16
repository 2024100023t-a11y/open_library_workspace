class OpenLibraryException implements Exception {
  final String message;
  final Object? cause;

  OpenLibraryException(this.message, [this.cause]);

  @override
  String toString() => 'OpenLibraryException: $message';
}
