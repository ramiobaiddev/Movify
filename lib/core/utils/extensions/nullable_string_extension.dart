/// Helpers on nullable [String] values.
extension NonEmptyString on String? {
  /// Returns `this` when non-null and non-empty, otherwise `null`.
  String? get nonEmptyOrNull => (this == null || this!.isEmpty) ? null : this;
}
