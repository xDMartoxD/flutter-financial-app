import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;
  const ChartBar({
    super.key,
    required this.label,
    required this.spendingAmount,
    required this.spendingPercentageOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((p0, p1) {
        return Column(
          children: [
            SizedBox(
              height: p1.maxHeight * .1,
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: p1.maxHeight * .05),
            SizedBox(
              height: p1.maxHeight * .7,
              width: 10,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromARGB(255, 62, 62, 62),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: spendingPercentageOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(height: p1.maxHeight * .05),
            SizedBox(
                height: p1.maxHeight * .1,
                child: FittedBox(
                  child: Text(
                    label,
                  ),
                ))
          ],
        );
      }),
    );
  }
}
