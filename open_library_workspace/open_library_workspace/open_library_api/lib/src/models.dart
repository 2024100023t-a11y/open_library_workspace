import 'exceptions.dart';

class BookSearchResult {
  final String title;
  final List<String> authors;
  final int? firstPublishYear;
  final String key;

  BookSearchResult({
    required this.title,
    required this.authors,
    this.firstPublishYear,
    required this.key,
  });

  factory BookSearchResult.fromJson(Map<String, dynamic> json) {
    return BookSearchResult(
      title: json['title'] as String? ?? 'Unknown Title',
      authors:
          (json['author_name'] as List<dynamic>?)
              ?.whereType<String>()
              .toList() ??
          ['Unknown Author'],
      firstPublishYear: json['first_publish_year'] as int?,
      key: json['key'] as String? ?? '',
    );
  }
}

class BookMetadata {
  final String title;
  final List<String> authors;
  final String publishDate;
  final int? numberOfPages;

  BookMetadata({
    required this.title,
    required this.authors,
    required this.publishDate,
    this.numberOfPages,
  });

  factory BookMetadata.fromJson(Map<String, dynamic> json) {
    try {
      final title = json['title'] as String? ?? 'Unknown Title';

      List<String> authorsList = [];
      if (json.containsKey('authors') && json['authors'] is List) {
        authorsList = (json['authors'] as List)
            .map((a) => a['name']?.toString() ?? 'Unknown Author')
            .toList();
      }

      final publishDate = json['publish_date'] as String? ?? 'N/A';
      final numberOfPages = json['number_of_pages'] as int?;

      return BookMetadata(
        title: title,
        authors: authorsList.isEmpty ? ['Unknown Author'] : authorsList,
        publishDate: publishDate,
        numberOfPages: numberOfPages,
      );
    } catch (e) {
      throw OpenLibraryException('Failed to parse book metadata payload.', e);
    }
  }
}
