import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../widgets/monthly_chart.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Subscription> subscriptions;

  const StatisticsScreen({super.key, required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harcama Analizi'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: MonthlyChart(subscriptions: subscriptions),
    );
  }
}
