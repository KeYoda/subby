import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:subby/utils/brand_helper.dart';
import '../models/subscription.dart';

class MonthlyChart extends StatefulWidget {
  final List<Subscription> subscriptions;

  const MonthlyChart({super.key, required this.subscriptions});

  @override
  State<MonthlyChart> createState() => _MonthlyChartState();
}

class _MonthlyChartState extends State<MonthlyChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    double total = 0;
    for (var sub in widget.subscriptions) {
      if (sub.cycle == BillingCycle.monthly) {
        total += sub.price;
      } else if (sub.cycle == BillingCycle.yearly) {
        total += sub.price / 12;
      } else {
        total += sub.price * 4;
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          bool isTouchEnded =
                              event is FlTapUpEvent ||
                              event is FlPanEndEvent ||
                              event is FlLongPressEnd;

                          if (!isTouchEnded ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            if (isTouchEnded) {
                              touchedIndex = -1;
                            }
                            return;
                          }

                          final newIndex = pieTouchResponse
                              .touchedSection!
                              .touchedSectionIndex;

                          if (touchedIndex == newIndex) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = newIndex;
                          }
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 2,
                    centerSpaceRadius: 70,
                    sections: _showingSections(total, colorScheme),
                  ),
                ),

                IgnorePointer(
                  child: _buildCenterText(total, colorScheme, textTheme),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: widget.subscriptions.map((sub) {
                  final isTouched =
                      widget.subscriptions.indexOf(sub) == touchedIndex;

                  double monthlyPrice = sub.price;
                  if (sub.cycle == BillingCycle.yearly) monthlyPrice /= 12;
                  if (sub.cycle == BillingCycle.weekly) monthlyPrice *= 4;

                  final percent = (monthlyPrice / total * 100).toStringAsFixed(
                    1,
                  );

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (touchedIndex == widget.subscriptions.indexOf(sub)) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = widget.subscriptions.indexOf(sub);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isTouched
                            ? colorScheme.primaryContainer.withOpacity(0.4)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isTouched
                            ? Border.all(
                                color: colorScheme.primary.withOpacity(0.2),
                              )
                            : Border.all(color: Colors.transparent),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Color(sub.colorValue),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(sub.colorValue).withOpacity(0.4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            sub.name,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: isTouched
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '%$percent',
                              style: textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${monthlyPrice.toStringAsFixed(2)} ₺',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: isTouched
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterText(
    double total,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    String title = 'Toplam';
    String amount = NumberFormat.currency(
      locale: 'tr',
      symbol: '₺',
    ).format(total);
    Color amountColor = colorScheme.onSurface;

    if (touchedIndex != -1 && touchedIndex < widget.subscriptions.length) {
      final sub = widget.subscriptions[touchedIndex];
      title = sub.name;
      double price = sub.price;
      if (sub.cycle == BillingCycle.yearly) price /= 12;
      if (sub.cycle == BillingCycle.weekly) price *= 4;
      amount = NumberFormat.currency(locale: 'tr', symbol: '₺').format(price);
      amountColor = Color(sub.colorValue);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: amountColor,
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _showingSections(
    double total,
    ColorScheme colorScheme,
  ) {
    if (widget.subscriptions.isEmpty) {
      return [
        PieChartSectionData(
          color: colorScheme.surfaceContainerHighest,
          value: 100,
          title: '',
          radius: 20,
        ),
      ];
    }

    return List.generate(widget.subscriptions.length, (i) {
      final isTouched = i == touchedIndex;
      final sub = widget.subscriptions[i];

      double value = sub.price;
      if (sub.cycle == BillingCycle.yearly) value /= 12;
      if (sub.cycle == BillingCycle.weekly) value *= 4;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: Color(sub.colorValue),
        value: value,
        title: '',
        radius: radius,
        badgeWidget: isTouched ? _buildIconBadge(sub, colorScheme) : null,
        badgePositionPercentageOffset: .98,
      );
    });
  }

  Widget _buildIconBadge(Subscription sub, ColorScheme colorScheme) {
    final color = Color(sub.colorValue);
    final brandInfo = BrandHelper.getBrandInfo(sub.name);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
        border: Border.all(color: Color(sub.colorValue), width: 2),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: brandInfo != null
              ? FaIcon(brandInfo.icon, color: color, size: 28)
              : (Text(
                  sub.name.isNotEmpty ? sub.name[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )),
        ),
      ),
    );
  }
}
