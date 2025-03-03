import 'package:expenses/main.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});
  final double fill;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          // تعطي الارتفاع بالنسب وليس الارقام
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                color: appmode == ThemeMode.dark
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.8)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}
