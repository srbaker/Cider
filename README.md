# Cider

Cider is a macOS-first SwiftUI frontend for Smalltalk. The Swift app will receive a wire protocol emitted by a Pharo Spec framework adapter and render the resulting UI natively.

Phase 0 establishes the project floor: SwiftPM structure, a minimal SwiftUI app shell, a pure Swift core module, Swift Testing coverage, and a headless Pharo availability check.

## Requirements

- Swift 6.3 or newer
- macOS 14 or newer for the SwiftUI app target
- A local Pharo installation on `PATH` for headless bootstrap checks

Pharo is intentionally local-first in this phase. Containerized Pharo is deferred until the CI and reproducibility work.

## Bootstrap

Run the full Phase 0 check with:

```sh
scripts/test
```

Run Swift-only checks with:

```sh
scripts/bootstrap-swift
```

Run the Pharo availability check with:

```sh
scripts/bootstrap-pharo
```

## Project Shape

- `CiderApp` is the macOS SwiftUI executable target.
- `CiderCore` is the pure Swift module for protocol and domain boundaries.
- `CiderCoreTests` contains Swift Testing coverage for core behavior.

The actual Spec adapter protocol, transport, serialization format, and widget schema are not defined in Phase 0.
