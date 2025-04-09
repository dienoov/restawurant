import 'package:flutter/widgets.dart';

enum RestawurantColors {
  green("Green", Color(0xFF00804A)),
  ivory("Ivory", Color(0xFFFCF3EC)),
  offwhite("Off White", Color(0xFFFFFCF7)),
  lime("Lime", Color(0xFFCEF546)),
  maroon("Maroon", Color(0xFF4E080C)),
  orange("Orange", Color(0xFFFF5E29)),
  pink("Pink", Color(0xFFE6A4D8)),
  yellow("Yellow", Color(0xFFFFD12E));

  const RestawurantColors(this.name, this.color);

  final String name;
  final Color color;
}
