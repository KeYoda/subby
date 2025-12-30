import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:subby/utils/brand_helper.dart';
import '../models/subscription.dart';
import '../services/notification_service.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  final _daysBeforeController = TextEditingController(text: '1');

  DateTime _selectedDate = DateTime.now();
  BillingCycle _selectedCycle = BillingCycle.monthly;
  int _selectedColor = Colors.blue.value;

  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.black,
    Colors.pink,
  ];

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveSubscription() {
    if (_nameController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen isim ve fiyat giriniz.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int daysBefore = int.tryParse(_daysBeforeController.text) ?? 1;

    final box = Hive.box<Subscription>('subscriptions');

    String rawName = _nameController.text;
    String formattedName = rawName.isNotEmpty
        ? rawName[0].toUpperCase() + rawName.substring(1)
        : rawName;

    final newSub = Subscription(
      name: formattedName,
      price: double.parse(_priceController.text.replaceAll(',', '.')),
      firstPaymentDate: _selectedDate,
      cycle: _selectedCycle,
      colorValue: _selectedColor,
      reminderDaysBefore: daysBefore,
      reminderHour: _selectedTime.hour,
      reminderMinute: _selectedTime.minute,
    );

    box.add(newSub);

    DateTime notificationDate = _selectedDate.subtract(
      Duration(days: daysBefore),
    );

    notificationDate = DateTime(
      notificationDate.year,
      notificationDate.month,
      notificationDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    if (notificationDate.isAfter(DateTime.now())) {
      NotificationService().scheduleNotification(
        id: newSub.key as int,
        title: 'Ödeme Hatırlatıcı 💸',
        body:
            '${newSub.name} ödemene $daysBefore gün kaldı! (${newSub.price} TL)',
        scheduledDate: notificationDate,
      );
    }
    // ----------------------------------------

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abonelik ve Alarm kaydedildi!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Abonelik'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return BrandHelper.getBrandNames().where((String option) {
                  return option.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  );
                });
              },

              onSelected: (String selection) {
                final brand = BrandHelper.getBrandInfo(selection);
                if (brand != null) {
                  setState(() {
                    _nameController.text = brand.name;
                    _selectedColor = brand.color.value;
                  });
                }
              },

              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onChanged: (value) {
                        _nameController.text = value;

                        final brand = BrandHelper.getBrandInfo(value);
                        if (brand != null) {
                          setState(() {
                            _selectedColor = brand.color.value;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Abonelik Adı (Örn: Netflix)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.subscriptions),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                      ),
                    );
                  },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Fiyat (TL)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.attach_money),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'İlk Ödeme',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(_selectedDate),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<BillingCycle>(
                    initialValue: _selectedCycle,
                    decoration: InputDecoration(
                      labelText: 'Döngü',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: BillingCycle.monthly,
                        child: Text('Aylık'),
                      ),
                      DropdownMenuItem(
                        value: BillingCycle.yearly,
                        child: Text('Yıllık'),
                      ),
                      DropdownMenuItem(
                        value: BillingCycle.weekly,
                        child: Text('Haftalık'),
                      ),
                    ],
                    onChanged: (v) => setState(() => _selectedCycle = v!),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "🔔 Bildirim Ayarları",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _daysBeforeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Kaç gün önce?',
                      hintText: 'Örn: 3',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.history),
                      suffixText: 'gün',
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: InkWell(
                    onTap: _pickTime,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Saat kaçta?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.access_time),
                      ),
                      child: Text(
                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Renk Seç",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _colors.map((color) {
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color.value),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _selectedColor == color.value
                            ? Border.all(color: Colors.black, width: 2)
                            : null,
                      ),
                      child: CircleAvatar(backgroundColor: color, radius: 16),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                onPressed: _saveSubscription,
                icon: const Icon(Icons.save),
                label: const Text('KAYDET', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
