import 'package:hive/hive.dart';

part 'subscription.g.dart';

@HiveType(typeId: 1)
enum BillingCycle {
  @HiveField(0)
  weekly,
  @HiveField(1)
  monthly,
  @HiveField(2)
  yearly,
}

@HiveType(typeId: 0)
class Subscription extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double price;

  @HiveField(2)
  DateTime firstPaymentDate;

  @HiveField(3)
  BillingCycle cycle;

  @HiveField(4)
  int colorValue;

  @HiveField(5)
  int reminderDaysBefore;

  @HiveField(6)
  int reminderHour;

  @HiveField(7)
  int reminderMinute;
  // ----------------------------

  Subscription({
    required this.name,
    required this.price,
    required this.firstPaymentDate,
    required this.cycle,
    required this.colorValue,
    this.reminderDaysBefore = 1,
    this.reminderHour = 10,
    this.reminderMinute = 0,
  });
}
