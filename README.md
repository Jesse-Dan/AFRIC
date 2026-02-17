# Wallet App - ACCESSMENT

Flutter wallet app — auth, balance tracking, and fund transfers.

## Stack

- Flutter · Riverpod · SharedPreferences · HTTP

## Features

- Login / register / logout with persistent session
- Live balance updates after every transaction
- Send and receive funds
- Transaction history cached locally
- Light / dark theme that persists across launches

## Getting Started

```bash
flutter pub get
flutter run
```

## Structure

```
lib/
├── src/
│   ├── client/       # API clients
│   ├── config/       # Theme, routes, colors
│   ├── modules/      # Screens
│   ├── providers/    # State management
│   └── reusables/    # Models, components, utils
└── main.dart
```
