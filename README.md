Open Library Cataloguer

A Dart-based command-line application that retrieves and displays book information using the Open Library API.

Project Description

The Open Library Cataloguer is a command-line application developed using Dart. It connects to the Open Library API to retrieve information about books and presents the data through a simple command-line interface.

The project demonstrates API integration, JSON data processing, object-oriented programming, command-line interaction, error handling, logging, terminal styling, and automated testing.

Objectives

The project aims to:

1. Retrieve book information from the Open Library API.
2. Process and convert JSON responses into Dart objects.
3. Provide a command-line interface for searching and viewing book information.
4. Implement error handling for network and API-related problems.
5. Use terminal colors to improve the command-line interface.
6. Implement logging for application activities and errors.
7. Organize the application using a Dart workspace with multiple packages.
8. Implement automated tests for the project components.

Features

* Search for books using the Open Library API.
* Display book titles, authors, publication information, and other available details.
* Support command-line interaction.
* Handle API and network errors.
* Use terminal colors for improved output.
* Record application errors through logging.
* Convert API JSON data into Dart models.
* Include automated tests.

Technologies Used

* Dart
* Open Library API
* HTTP
* JSON
* Dart Testing Framework
* ANSI Terminal Colors
* Git
* GitHub

Project Structure

Open_Library_Cataloguer_Workspace/
│
├── terminal_colors/
│   ├── lib/
│   │   ├── src/
│   │   │   ├── ansi.dart
│   │   │   └── terminal_colors_base.dart
│   │   ├── terminal_colors.dart
│   │   └── ...
│   ├── test/
│   └── pubspec.yaml
│
├── open_library_api/
│   ├── lib/
│   │   ├── src/
│   │   │   ├── client.dart
│   │   │   ├── exceptions.dart
│   │   │   ├── models.dart
│   │   │   └── open_library_api_base.dart
│   │   ├── open_library_api.dart
│   │   └── ...
│   ├── test/
│   ├── example/
│   └── pubspec.yaml
│
├── library_cli/
│   ├── bin/
│   │   ├── main.dart
│   │   └── library_cli.dart
│   ├── lib/
│   │   ├── src/
│   │   │   ├── search_command.dart
│   │   │   ├── command_base.dart
│   │   │   ├── help_command.dart
│   │   │   ├── logging_config.dart
│   │   │   └── book_command.dart
│   │   └── library_cli.dart
│   ├── test/
│   └── pubspec.yaml
│
├── pubspec.yaml
├── pubspec.lock
└── .gitignore

Package Description

terminal_colors

The "terminal_colors" package provides reusable terminal styling and ANSI color constants for the command-line interface.

open_library_api

The "open_library_api" package handles communication with the Open Library API. It also contains the book data models, API client, and exception handling.

library_cli

The "library_cli" package provides the command-line interface of the application. It handles user commands, book searches, help commands, logging, and formatted output.

Requirements

Before running the project, make sure the following are installed:

* Dart SDK 3.8.1 or later
* Git
* Internet connection

Installation

Clone the repository:

git clone https://github.com/santiagorealyn-byte/Open_Library_Cataloguer_Workspace.git

Navigate to the project directory:

cd Open_Library_Cataloguer_Workspace

Get the project dependencies:

dart pub get

How to Run

Navigate to the CLI package:

cd library_cli

Run the application:

dart run

Example Usage

The application can be used to search for book information through the command-line interface.

Example command:

library > search harry potter

Example output:

[INFO] Searching Open Library for: harry potter

Title: Harry Potter and the Philosopher's Stone
Author: J. K. Rowling
First Published: 1997

The displayed book information is retrieved from the Open Library API.

API

This project uses the Open Library API to retrieve book data.

The API can provide information such as:

* Book title
* Author
* Publication year
* ISBN
* Publisher
* Book cover information
* Open Library work or edition identifiers

The application processes the JSON response and converts the relevant information into Dart objects before displaying it in the command-line interface.

Error Handling

The application implements error handling for possible problems such as:

* Network connection failures
* API request failures
* Invalid API responses
* Missing or invalid book data
* Timeout errors
* No search results

Exceptions are handled using Dart exception-handling mechanisms.

Logging

The CLI package includes logging functionality for recording application events and errors.

Logging helps identify problems during application execution and makes troubleshooting easier.

Testing

The project contains automated tests for the different components of the application.

Tests may include:

* API client tests
* JSON-to-model conversion tests
* Command parsing tests
* Error-handling tests
* CLI behavior tests

Run the tests using:

dart test

Conclusion

The Open Library Cataloguer demonstrates how Dart can be used to create a modular command-line application that communicates with an external API. The project combines API integration, JSON processing, object-oriented programming, command parsing, error handling, logging, terminal styling, and automated testing in a single application.
