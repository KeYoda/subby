# 💸 Subby - Subscription Tracker App

Subby is a modern Flutter application designed to help you track your daily, weekly, monthly, or yearly subscriptions, analyze your expenses, and send you custom notifications before payment dates.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Hive](https://img.shields.io/badge/Hive-NoSQL-orange?style=for-the-badge)

## 📱 Screenshots

| Home Screen | Add Subscription | Statistics |
|:-----------:|:----------------:|:----------:|
| <img src="screenshots/home.jpeg" width="220"/> | <img src="screenshots/add.jpeg" width="220"/> | <img src="screenshots/chart.jpeg" width="220"/> |

## ✨ Features

* **📊 Expense Analysis:** Converts all your subscriptions (Daily/Weekly/Yearly) into a monthly average cost to help you manage your budget effectively.
* **🔔 Smart Notifications:** Sends custom reminder notifications before the payment date at your preferred day and time (e.g., 3 days before at 14:00).
* **🎨 Brand Detection:** Automatically detects the category icon and brand color when you type the subscription name (e.g., Netflix, Spotify, Rent).
* **💾 Local Database:** Safely stores your data on your device using Hive, ensuring privacy with no internet connection required.
* **🌙 Dark/Light Mode:** Modern interface that automatically adapts to your device's system theme (powered by FlexColorScheme).
* **📈 Interactive Charts:** Visualize your expense distribution with touch-interactive pie charts for detailed insights.

## 🛠️ Tech Stack & Packages

* **[Flutter](https://flutter.dev/):** UI Framework.
* **[Hive](https://pub.dev/packages/hive):** Lightweight, fast, and secure NoSQL local database.
* **[Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications):** For advanced scheduled notifications.
* **[FL Chart](https://pub.dev/packages/fl_chart):** For interactive expense charts.
* **[Flex Color Scheme](https://pub.dev/packages/flex_color_scheme):** Professional theme and color management.
* **[Font Awesome](https://pub.dev/packages/font_awesome_flutter):** Extensive library for brand and category icons.

## 🚀 Installation

After cloning the project to your local machine, run the following commands in the terminal:

1.  Get dependencies:
    ```bash
    flutter pub get
    ```

2.  Generate Hive type adapters:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  Run the app:
    ```bash
    flutter run
    ```

## 👨‍💻 Developer

**Umut Keskin**
* GitHub: [@KeYoda](https://github.com/KeYoda)
* Mail:keyodapp@gmail.com

---
⭐️ If you found this project helpful, please consider giving it a star!
