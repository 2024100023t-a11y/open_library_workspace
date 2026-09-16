import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'exceptions.dart';
import 'models.dart';

class OpenLibraryApiClient {
  final http.Client _client;
  final Logger _logger = Logger('OpenLibraryApiClient');
  static const String _authority = 'openlibrary.org';

  // Open Library asks API consumers to send a custom User-Agent header
  static const Map<String, String> _headers = {
    'User-Agent': 'OpenLibraryCataloguerCLI/1.0 (learning_project)',
    'Accept': 'application/json',
  };

  OpenLibraryApiClient(this._client);

  /// Search books by query using Open Library's search.json endpoint
  Future<List<BookSearchResult>> searchBooks(String query, {int limit = 10}) async {
    _logger.info('Searching Open Library books for query: $query');

    final uri = Uri.https(_authority, '/search.json', {
      'q': query,
      'limit': limit.toString(),
      'fields': 'title,author_name,first_publish_year,key',
    });

    try {
      // Increased timeout to 15 seconds
      final response = await _client.get(uri, headers: _headers).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw OpenLibraryException('Server returned error HTTP ${response.statusCode}');
      }

      final decoded = json.decode(response.body) as Map<String, dynamic>;
      if (!decoded.containsKey('docs') || decoded['docs'] is! List) {
        return [];
      }

      final docs = decoded['docs'] as List;
      return docs
          .map((doc) => BookSearchResult.fromJson(doc as Map<String, dynamic>))
          .toList();
    } on TimeoutException {
      throw OpenLibraryException('Request timed out. The Open Library server is taking too long to respond.');
    } on http.ClientException catch (e) {
      _logger.severe('Network error occurred.', e);
      throw OpenLibraryException('Network failure while connecting to Open Library.', e);
    } catch (e) {
      _logger.severe('Unexpected exception intercepted.', e);
      rethrow;
    }
  }

  /// Fetch book details by ISBN
  Future<BookMetadata> fetchByIsbn(String isbn) async {
    _logger.info('Querying Open Library for ISBN: $isbn');
    final formattedIsbn = isbn.replaceAll(RegExp(r'[\s\-]'), '');
    final bibKey = 'ISBN:$formattedIsbn';

    final uri = Uri.https(_authority, '/api/books', {
      'bibkeys': bibKey,
      'format': 'json',
      'jscmd': 'data',
    });

    try {
      final response = await _client.get(uri, headers: _headers).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw OpenLibraryException('Server returned error HTTP ${response.statusCode}');
      }

      final decoded = json.decode(response.body) as Map<String, dynamic>;
      if (!decoded.containsKey(bibKey)) {
        throw OpenLibraryException('No record found for ISBN: $isbn');
      }

      return BookMetadata.fromJson(decoded[bibKey] as Map<String, dynamic>);
    } on TimeoutException {
      throw OpenLibraryException('Request timed out while searching for ISBN.');
    } on http.ClientException catch (e) {
      _logger.severe('Network error occurred.', e);
      throw OpenLibraryException('Network failure while connecting to Open Library.', e);
    } catch (e) {
      _logger.severe('Unexpected exception intercepted.', e);
      rethrow;
    }
  }
}