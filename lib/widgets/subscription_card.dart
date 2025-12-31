import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:subby/utils/brand_helper.dart';
import '../models/subscription.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback onDelete;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    required this.onDelete,
  });

  int _calculateDaysLeft() {
    final now = DateTime.now();
    DateTime nextDate = subscription.firstPaymentDate;

    while (nextDate.isBefore(now)) {
      if (subscription.cycle == BillingCycle.monthly) {
        nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
      } else if (subscription.cycle == BillingCycle.yearly) {
        nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
      } else {
        nextDate = nextDate.add(const Duration(days: 7));
      }
    }
    return nextDate.difference(now).inDays;
  }

  @override
  Widget build(BuildContext context) {
    String cycleText = '';
    switch (subscription.cycle) {
      case BillingCycle.weekly:
        cycleText = 'Hafta';
      case BillingCycle.monthly:
        cycleText = 'Ay';
        break;
      case BillingCycle.yearly:
        cycleText = 'Yıl';
        break;
    }

    final brandInfo = BrandHelper.getBrandInfo(subscription.name);
    final daysLeft = _calculateDaysLeft();
    final theme = Theme.of(context);
    final color = Color(subscription.colorValue);
    IconData? categoryIcon;

    if (brandInfo == null) {
      categoryIcon = BrandHelper.getIconByCategory(subscription.name);
    }

    return Dismissible(
      key: ValueKey(subscription.key),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),

      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),

        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'SİL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.delete_sweep_outlined, color: Colors.white, size: 28),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: brandInfo != null
                      ? FaIcon(brandInfo.icon, color: color, size: 28)
                      : (categoryIcon != null
                            ? FaIcon(categoryIcon, color: color, size: 24)
                            : Text(
                                subscription.name.isNotEmpty
                                    ? subscription.name[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${NumberFormat.currency(locale: 'tr', symbol: '₺').format(subscription.price)} / $cycleText',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Text(
                    '$daysLeft',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: daysLeft <= 3
                          ? Colors.red
                          : theme.colorScheme.primary,
                    ),
                  ),
                  Text('Gün Kaldı', style: theme.textTheme.labelSmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
