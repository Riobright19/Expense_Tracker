## Expense Tracker – Flutter

# Overview

This project demonstrates a scalable Flutter application using:

- Clean Architecture
- BLoC Cubit state management
- Form validation
- Error handling
- Unit testing
- Localization (English & Spanish)

## Architecture ##

The project follows a 3-layer structure:

# Presentation Layer

UI
BLoC state management
Domain Layer

Business entities
Repository contracts
Independent of external packages
Data Layer

Repository implementations
Data sources (currently in-memory)
Easily replaceable with Firebase or REST API
State Management
BLoC is used for predictable and testable state transitions.

Events:

LoadExpenses
AddExpenseEvent
DeleteExpenseEvent
States:

ExpenseInitial
ExpenseLoading
ExpenseLoaded
ExpenseError
Localization
Implemented using Flutter's intl package.
Supports:

English
Spanish
Switching is handled at the root MaterialApp level.
Testing
Unit tests are written using:

bloc_test
mocktail
Future Improvements
Firebase integration
Offline caching
Charts & analytics
Dark mode