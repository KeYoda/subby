import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/subscription.dart';
import 'add_subscription_screen.dart';
import '../widgets/subscription_card.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Subscription>('subscriptions');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Aboneliklerim',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddSubscriptionScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Ekle'),
      ),
      body: ValueListenableBuilder<Box<Subscription>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.savings_outlined,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hiç aboneliğin yok.\nParan cebinde kalsın! 🎉',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                ],
              ),
            );
          }

          final subscriptions = box.values.toList();
          double totalMonthly = 0;
          for (var sub in subscriptions) {
            if (sub.cycle == BillingCycle.monthly) {
              totalMonthly += sub.price;
            } else if (sub.cycle == BillingCycle.yearly) {
              totalMonthly += sub.price / 12;
            } else {
              totalMonthly += sub.price * 4;
            }
          }

          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StatisticsScreen(subscriptions: subscriptions),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Aylık Ortalama',
                                style: TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.pie_chart,
                                color: Colors.white.withOpacity(0.6),
                                size: 16,
                              ),
                            ],
                          ),
                          const Text(
                            'Gideriniz',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        NumberFormat.currency(
                          locale: 'tr',
                          symbol: '₺',
                        ).format(totalMonthly),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: subscriptions.length,
                  itemBuilder: (context, index) {
                    final sub = subscriptions[index];
                    return SubscriptionCard(
                      subscription: sub,
                      onDelete: () {
                        sub.delete();
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
