/// A library providing icons from the Majesticons font.
///
/// This library enables the use of Majesticons icons in Flutter applications.
/// It includes the [MajesticonsData] class, which extends [IconData] to represent
/// individual icons.
///
/// To use this library, ensure that the Majesticons font is included in your
/// project and properly configured in your `pubspec.yaml`.
library majesticons;

import "package:flutter/widgets.dart";

/// Represents an icon from the Majesticons font.
///
/// The [MajesticonsData] class extends [IconData], providing a way to use
/// Majesticons icons in Flutter widgets such as [Icon] or [IconButton].
///
/// Example:
/// ```dart
/// Icon(MajesticonsData(0xe001))
/// ```
///
/// The `codePoint` parameter refers to the specific icon's Unicode value.
/// The font is identified by the `fontFamily` and `fontPackage` properties,
/// which are set to `"majesticons"` by default.
class MajesticonsData extends IconData {
  /// Creates a new [MajesticonsData] instance with the given [codePoint].
  ///
  /// The [codePoint] specifies the Unicode value of the icon, which is used
  /// to render the corresponding Majesticons glyph.
  ///
  /// Example:
  /// ```dart
  /// const icon = MajesticonsData(0xe001);
  /// ```
  const MajesticonsData(int codePoint)
      : super(codePoint, fontFamily: "majesticons", fontPackage: "majesticons");
}
