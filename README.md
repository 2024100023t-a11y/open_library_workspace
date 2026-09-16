[Uploading README.md…]()
# Open Library Workspace

A small Dart [pub workspace](https://dart.dev/tools/pub/workspaces) containing a command-line book cataloguer built on top of the [Open Library](https://openlibrary.org/developers/api) API.

The workspace is made up of three packages:

| Package | Type | Description |
|---|---|---|
| [`open_library_cli`](open_library_cli) | Application | Interactive terminal app for searching books and looking up ISBNs |
| [`open_library_api`](open_library_api) | Library | HTTP client for the Open Library REST API |
| [`terminal_colors`](terminal_colors) | Library | Lightweight ANSI color helpers for terminal output |

## Features

- 🔍 **Search** the Open Library catalog by title or author
- 📖 **ISBN lookup** for full book metadata (title, authors, publish date, page count)
- 🎨 Colorized terminal output (headers, success, warnings, errors)
- ⏱️ Built-in request timeouts and structured error handling via a single `OpenLibraryException`

## Getting Started

### Prerequisites

- [Dart SDK](https://dart.dev/get-dart) `^3.8.1`

### Install dependencies

From the workspace root:

```bash
dart pub get
```

### Run the CLI

```bash
cd open_library_cli
dart run bin/main.dart
```

## Usage

Once running, the CLI accepts the following commands:

| Command | Description | Example |
|---|---|---|
| `search <QUERY>` | Search books by title or author | `search dune frank herbert` |
| `isbn <NUMBER>` | Look up a book by its ISBN | `isbn 9780441013593` |
| `exit` | Quit the application | `exit` |

### Example session

```
=====================================
    OPEN LIBRARY CATALOGUER CLI     
=====================================
Commands:
  search <QUERY>  - Search books by title or author
  isbn <NUMBER>   - Lookup exact book by ISBN
  exit            - Quit application

[cataloguer] > search dune
Searching Open Library for "dune"...

--- SEARCH RESULTS ---
1. Dune
   Author(s): Frank Herbert
   First Published: 1965
-----------------------

[cataloguer] > isbn 9780441013593

--- LITERARY METADATA RECORD ---
Title:         Dune
Author(s):     Frank Herbert
Publish Date:  1990
Page Count:    535
--------------------------------

[cataloguer] > exit
Exiting Cataloguer application...
```

## Project Structure

```
open_library_workspace/
├── pubspec.yaml                # Workspace root — lists member packages
├── open_library_cli/           # The CLI application
│   ├── bin/main.dart           # Entry point / REPL loop
│   └── pubspec.yaml
├── open_library_api/           # Open Library HTTP client
│   ├── lib/
│   │   ├── open_library_api.dart
│   │   └── src/
│   │       ├── client.dart     # OpenLibraryApiClient
│   │       ├── models.dart     # BookSearchResult, BookMetadata
│   │       └── exceptions.dart # OpenLibraryException
│   └── pubspec.yaml
└── terminal_colors/             # ANSI color helper library
    ├── lib/
    │   ├── terminal_colors.dart
    │   └── src/ansi.dart        # TerminalColor, Colorizer extension
    └── pubspec.yaml
```

## Package Details

### `open_library_api`

Exposes `OpenLibraryApiClient`, a thin wrapper around two Open Library endpoints:

- `searchBooks(query, {limit})` → `GET /search.json` → `List<BookSearchResult>`
- `fetchByIsbn(isbn)` → `GET /api/books` → `BookMetadata`

All network, timeout, and parsing failures are surfaced as a single `OpenLibraryException` so callers only need to handle one error type.

```dart
import 'package:http/http.dart' as http;
import 'package:open_library_api/open_library_api.dart';

final client = OpenLibraryApiClient(http.Client());
final results = await client.searchBooks('the hobbit');
```

### `terminal_colors`

A tiny extension on `String` for ANSI-colored terminal output:

```dart
import 'package:terminal_colors/terminal_colors.dart';

print('Success!'.styleSuccess);
print('Warning!'.styleWarning);
print('Error!'.styleError);
print('== Header =='.styleHeader);
```

### `open_library_cli`

The application entry point. Wires `terminal_colors` and `open_library_api` together into an interactive REPL for searching and looking up books.

## Running Tests

```bash
dart test
```

(run from the workspace root, or inside an individual package directory)

## Dependencies

- [`http`](https://pub.dev/packages/http) — HTTP requests
- [`logging`](https://pub.dev/packages/logging) — structured logging
- [`lints`](https://pub.dev/packages/lints) / `dart test` — linting and testing (dev only)

## License

_Add a license for this project (e.g. MIT) if you intend to publish it._
