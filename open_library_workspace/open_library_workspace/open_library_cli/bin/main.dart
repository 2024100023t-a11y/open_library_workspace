import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:terminal_colors/terminal_colors.dart';
import 'package:open_library_api/open_library_api.dart';

void main() async {
  final httpClient = http.Client();
  final apiClient = OpenLibraryApiClient(httpClient);

  print('====================================='.styleHeader);
  print('    OPEN LIBRARY CATALOGUER CLI     '.styleHeader);
  print('====================================='.styleHeader);
  print('Commands:');
  print('  search <QUERY>  - Search books by title or author');
  print('  isbn <NUMBER>   - Lookup exact book by ISBN');
  print('  exit            - Quit application\n');

  try {
    while (true) {
      stdout.write('[cataloguer] > ');
      final input = stdin.readLineSync();

      if (input == null || input.trim().toLowerCase() == 'exit') {
        print('Exiting Cataloguer application...'.styleWarning);
        break;
      }

      final trimmed = input.trim();
      if (trimmed.isEmpty) continue;

      final parts = trimmed.split(RegExp(r'\s+'));
      final command = parts.first.toLowerCase();

      if (command == 'search' && parts.length > 1) {
        final query = parts.sublist(1).join(' ');
        print('Searching Open Library for "$query"...');

        try {
          final results = await apiClient.searchBooks(query, limit: 10);

          if (results.isEmpty) {
            print('No books found for "$query".'.styleWarning);
            continue;
          }

          print('\n--- SEARCH RESULTS ---'.styleHeader);
          for (var i = 0; i < results.length; i++) {
            final book = results[i];
            print('${i + 1}. ${book.title}'.styleSuccess);
            print('   Author(s): ${book.authors.join(', ')}');
            print('   First Published: ${book.firstPublishYear ?? 'N/A'}');
          }
          print('-----------------------\n'.styleHeader);
        } on OpenLibraryException catch (e) {
          print('\nSearch Error: ${e.message}\n'.styleError);
        }
      } else if (command == 'isbn' && parts.length > 1) {
        final targetIsbn = parts.sublist(1).join('');
        try {
          final book = await apiClient.fetchByIsbn(targetIsbn);
          print('\n--- LITERARY METADATA RECORD ---'.styleHeader);
          print('Title:         ${book.title}'.styleSuccess);
          print('Author(s):     ${book.authors.join(', ')}');
          print('Publish Date:  ${book.publishDate}');
          print('Page Count:    ${book.numberOfPages ?? 'Unknown'}');
          print('--------------------------------\n'.styleHeader);
        } on OpenLibraryException catch (e) {
          print('\nLookup Error: ${e.message}\n'.styleError);
        }
      } else {
        print('Invalid syntax. Usage: "search <QUERY>" or "isbn <NUMBER>"'.styleError);
      }
    }
  } finally {
    httpClient.close();
  }
}