import 'package:open_library_api/open_library_api.dart';

void main() {
  final book = BookMetadata.fromJson({
    'title': 'The Little Prince',
    'authors': [
      {'name': 'Antoine de Saint-Exupery'},
    ],
    'publish_date': '1943',
  });
  print('${book.title} by ${book.authors.join(', ')}');
}
