# Technical Assessment Summary

---

## Changelog 1

### What I Built

- Auth flow — login, logout, persistent session
- `BaseProvider` for shared API handling and state logic
- Clean UI that fits the app context

### Didn't Get To

- Full `StateNotifier` migration — `ChangeNotifier` works but is more mutable than ideal
- Edge case testing — happy path is solid, startup race conditions not fully covered

### Would Fix With More Time

- `ChangeNotifier` → `StateNotifier`
- Tokens in `flutter_secure_storage` not plain SharedPreferences
- Auto token refresh via Dio interceptors
- Proper integration and unit tests

---

## Changelog 2

### Bug Fixes

**filterTransactions** — method was taking itself as a parameter. Made it private, wired the listener correctly, added `dispose()` for the controller.

**Riverpod startup crash** — `getUserDetails()` was firing inside provider init, which tried to write to another provider. Riverpod forbids that. Moved it to `Future.microtask()`.

**StorageUtil.get()** — was synchronous, threw when prefs weren't ready. Made it async with an `await init()` guard.

---

### What I Added

**Balance card refresh button** — top-right icon, spins while loading, disables mid-request.

**Theme persistence** — selected theme saved to SharedPreferences, restored on next launch.

**Transaction caching** — credit/debit results saved locally, restored on startup, newest entry always on top.

**Instant balance update** — balance pulled from `Journal` response and pushed to `AuthProvider` via `copyWith()` immediately after a transaction. No manual refresh needed.

**Sheets wired to API** — Send and Receive bottom sheets now actually call `credit()` and `debit()`, with loading states and success/error feedback.
