# Movify Project Rules & Architecture Guidelines

## 1. Terminal Constraints (Strict)
- **STRICT PROHIBITION:** NEVER run `flutter test` or `flutter analyze` via terminal. The user runs these manually.

## 2. Widget Composition & Architecture
- **Pure Widget Composition:** NEVER use private helper builder methods (e.g. `Widget _build...()`). Split UI into dedicated small, focused widget files.
- **File Length & Modularity:** Keep presentation files modular, focused, and ideally under 100–150 lines.
- **Clean Architecture & KISS:** Follow feature-first Clean Architecture (`domain`, `data`, `presentation`). Keep logic in Cubits and UI declarative.

## 3. Design System & Token Fidelity
- **Strict Design Tokens:** ALWAYS use `context.colors`, `Radii`, `Space`, and `Theme.of(context).textTheme`.
- **No Raw Colors:** NEVER hardcode raw colors (`Colors.white`, `Colors.black`, hex codes `Color(0x...)`). Always use semantic tokens from `context.colors`.
- **No Typography Overrides:** NEVER override `fontSize` or `fontWeight` on `textTheme` styles. Use the designated typography token (`titleLarge`, `titleMedium`, `bodyMedium`, `labelSmall`, etc.).
- **Constructors:** Prefer `const` constructors wherever possible for optimal Flutter performance.
