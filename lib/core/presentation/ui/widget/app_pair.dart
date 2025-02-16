import 'package:flutter/material.dart';
import 'package:movie_app/core/presentation/ui/widget/app_widgets.dart';

class AppPair extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String value;
  final Color valueColor;
  final PairType pairType;
  final bool showInCenter;
  final bool showBoldText;

  const AppPair(
    this.title,
    this.value, {
    this.titleColor = Colors.black,
    this.valueColor = Colors.black87,
    this.pairType = PairType.row,
    this.showInCenter = false,
    this.showBoldText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = AppText(
      "$title:", // Title with colon
      false,
      color: titleColor,
      isBold: true,
    );
    Widget valueWidget = AppText(
      value,
      false,
      color: valueColor,
      isBold: showBoldText,
    );

    // Display as a column even in row layout to place value on new line
    if (pairType == PairType.row) {
      return Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns to the top
          mainAxisSize: showInCenter ? MainAxisSize.min : MainAxisSize.max,
          children: [
            titleWidget, // Title on the left
            const SizedBox(width: 5), // Small spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  valueWidget, // Value on a new line
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [titleWidget, valueWidget],
    );
  }
}

enum PairType { row, column }
