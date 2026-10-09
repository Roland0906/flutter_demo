# 0004. No code generation

- Status: Accepted
- Date: 2026-10-09

## Context

json_serializable, freezed, and riverpod_generator reduce boilerplate but require build_runner and generated files.

## Decision

At the current size (one model, a few providers), write `fromJson` and providers by hand and skip code generation.

## Consequences

- The app runs right after `flutter pub get`, with no generated files to keep in sync
- Revisit this decision if the number of models or providers grows significantly
