import 'package:open_library_api/open_library_api.dart';
import 'package:test/test.dart';

void main() {
  test('parses book metadata', () {
    final book = BookMetadata.fromJson({
      'title': 'The Little Prince',
      'authors': [
        {'name': 'Antoine de Saint-Exupery'},
      ],
      'publish_date': '1943',
      'number_of_pages': 96,
    });

    expect(book.title, 'The Little Prince');
    expect(book.authors, ['Antoine de Saint-Exupery']);
    expect(book.publishDate, '1943');
    expect(book.numberOfPages, 96);
  });
}
