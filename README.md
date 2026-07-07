# Cider

Cider is a macOS-first SwiftUI frontend for Smalltalk. The Swift app will receive a wire protocol emitted by a Pharo Spec framework adapter and render the resulting UI natively.

Phase 0 establishes the project floor: SwiftPM structure, a minimal SwiftUI app shell, a pure Swift core module, Swift Testing coverage, and a headless Pharo availability check.

Phase 1 adds the first Spec-shaped wire slice. A minimal Pharo Spec application emits `CIDER:`-prefixed NDJSON records whose payloads use Spec vocabulary such as `SpWindowPresenter`, `SpBoxLayout`, `SpLabelPresenter`, adapter names, selectors, and presenter relationships.

## Requirements

- Swift 6.3 or newer
- macOS 14 or newer for the SwiftUI app target
- A local Pharo 13.1 installation on `PATH` for headless bootstrap checks
- `CIDER_PHARO_IMAGE` pointing at a local Pharo 13.1 image for Pharo tests

Pharo is intentionally local-first in this phase. Containerized Pharo is deferred until the CI and reproducibility work.

## Bootstrap

Run the full local check with:

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

`scripts/bootstrap-pharo` also runs the Hello World Spec application headlessly and compares its `CIDER:` output with `Sources/CiderCore/Resources/hello-world.ndjson`, which is the canonical Swift fixture for this slice.

Prepare a cached local Pharo image and VM with:

```sh
scripts/prepare-pharo
```

By default this uses the full Pharo 13.1 image and stores the prepared image, VM, sources, and Pharo home directory under `.build/pharo`. The minimal image can be selected with `CIDER_PHARO_IMAGE_FLAVOR=minimal`, but the full image is the supported default because it already includes the released Spec stack.

## Project Shape

- `CiderApp` is the macOS SwiftUI executable target.
- `CiderCore` is the pure Swift module for protocol and domain boundaries.
- `CiderCoreTests` contains Swift Testing coverage for core behavior.

The full Spec adapter protocol, transport, serialization format, and widget schema are not defined yet.

## Pharo Packages

The Pharo code lives in Tonel format under `pharo/src`:

- `Cider-Spec` contains the Spec backend, adapters, and wire emitter.
- `Cider-Spec-Examples` contains the Hello World Spec application.
- `Cider-Spec-Tests` contains the SUnit wire test.
