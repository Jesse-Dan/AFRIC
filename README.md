# Technical Assessment Summary

## What I Completed

- Implemented authentication flow using Riverpod (login, logout, persistent session loading).
- Built a BaseProvider architecture for state management and API handling.
- Build a Beautiful UI to compliment app context

## Challenges / What I Couldn’t Fully Complete

- Did not fully migrate to an immutable StateNotifier architecture due to time constraints.
- End-to-end testing and edge-case handling (e.g., race conditions on startup) were limited.

## Notes

Given more time, I would:

- Refactor ChangeNotifier to StateNotifier for predictable state management.
- Add secure storage (flutter_secure_storage) for tokens.
- Implement automatic token refresh with Dio interceptors.
- Add integration and unit tests for auth flow.
- Integrated local storage for user and token persistence.
- Added error handling and debug logging utilities.
# AFRIC
