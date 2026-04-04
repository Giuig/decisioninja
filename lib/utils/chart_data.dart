import 'dart:ui';

class ChartData {
  ChartData(this.x, this.y, [Color? color])
      : color = color ?? const Color.fromARGB(0, 0, 0, 0);

  final String x;
  final double y;
  final Color color;
}
