import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BrandInfo {
  final String name;
  final Color color;
  final IconData icon;

  BrandInfo(this.name, this.color, this.icon);
}

class BrandHelper {
  static final Map<String, BrandInfo> _brands = {
    // --- Video Streaming ---
    'netflix': BrandInfo(
      'Netflix',
      const Color(0xFFE50914),
      FontAwesomeIcons.n,
    ),
    'youtube': BrandInfo(
      'YouTube',
      const Color(0xFFFF0000),
      FontAwesomeIcons.youtube,
    ),
    'youtube premium': BrandInfo(
      'YouTube Premium',
      const Color(0xFFFF0000),
      FontAwesomeIcons.youtube,
    ),
    'prime video': BrandInfo(
      'Prime Video',
      const Color(0xFF00A8E1),
      FontAwesomeIcons.amazon,
    ),
    'disney': BrandInfo('Disney+', const Color(0xFF113CCF), FontAwesomeIcons.d),
    'disney+': BrandInfo(
      'Disney+',
      const Color(0xFF113CCF),
      FontAwesomeIcons.d,
    ),
    'hbo': BrandInfo('HBO Max', const Color(0xFF5A2E88), Icons.movie_filter),
    'hulu': BrandInfo(
      'Hulu',
      const Color(0xFF1CE783),
      Icons.play_circle_outline,
    ),
    'apple tv': BrandInfo(
      'Apple TV+',
      const Color(0xFF2C2C2C),
      FontAwesomeIcons.apple,
    ),
    'mubi': BrandInfo('Mubi', const Color(0xFF003ECB), FontAwesomeIcons.film),

    // --- Yerel Video Platformları (TR) ---
    'exxen': BrandInfo(
      'Exxen',
      const Color(0xFFFFD600),
      Icons.play_circle_filled,
    ),
    'blutv': BrandInfo('BluTV', const Color(0xFF00A4DC), Icons.tv),
    'gain': BrandInfo(
      'Gain',
      const Color(0xFFE60023),
      Icons.play_arrow_rounded,
    ),
    'bein': BrandInfo(
      'Bein Connect',
      const Color(0xFF6A0F49),
      FontAwesomeIcons.futbol,
    ),
    'tod': BrandInfo(
      'TOD TV',
      const Color(0xFF2E0938),
      FontAwesomeIcons.futbol,
    ),

    // --- Müzik & Ses ---
    'spotify': BrandInfo(
      'Spotify',
      const Color(0xFF1DB954),
      FontAwesomeIcons.spotify,
    ),
    'apple music': BrandInfo(
      'Apple Music',
      const Color(0xFFFA243C),
      FontAwesomeIcons.music,
    ),
    'deezer': BrandInfo(
      'Deezer',
      const Color(0xFFEF5466),
      FontAwesomeIcons.chartSimple,
    ),
    'tidal': BrandInfo(
      'Tidal',
      const Color(0xFF000000),
      FontAwesomeIcons.waveSquare,
    ),
    'soundcloud': BrandInfo(
      'SoundCloud',
      const Color(0xFFFF5500),
      FontAwesomeIcons.soundcloud,
    ),
    'fizy': BrandInfo('Fizy', const Color(0xFFFFC600), FontAwesomeIcons.music),

    // --- Oyun & Eğlence ---
    'twitch': BrandInfo(
      'Twitch',
      const Color(0xFF9146FF),
      FontAwesomeIcons.twitch,
    ),
    'xbox': BrandInfo(
      'Xbox Game Pass',
      const Color(0xFF107C10),
      FontAwesomeIcons.xbox,
    ),
    'playstation': BrandInfo(
      'PlayStation Plus',
      const Color(0xFF00439C),
      FontAwesomeIcons.playstation,
    ),
    'steam': BrandInfo(
      'Steam',
      const Color(0xFF171A21),
      FontAwesomeIcons.steam,
    ),
    'epic': BrandInfo(
      'Epic Games',
      const Color(0xFF333333),
      FontAwesomeIcons.gamepad,
    ),
    'discord': BrandInfo(
      'Discord Nitro',
      const Color(0xFF5865F2),
      FontAwesomeIcons.discord,
    ),
    'geforce': BrandInfo(
      'GeForce Now',
      const Color(0xFF76B900),
      FontAwesomeIcons.computer,
    ),
    'ea play': BrandInfo(
      'EA Play',
      const Color(0xFFFF4747),
      FontAwesomeIcons.gamepad,
    ),

    // --- Yazılım & AI & İş ---
    'github': BrandInfo(
      'GitHub Copilot',
      const Color.fromARGB(255, 40, 40, 40),
      FontAwesomeIcons.github,
    ),
    'chatgpt': BrandInfo(
      'ChatGPT Plus',
      const Color(0xFF10A37F),
      FontAwesomeIcons.robot,
    ),
    'openai': BrandInfo(
      'OpenAI',
      const Color(0xFF10A37F),
      FontAwesomeIcons.robot,
    ),
    'adobe': BrandInfo(
      'Adobe CC',
      const Color(0xFFFF0000),
      FontAwesomeIcons.penNib,
    ),
    'canva': BrandInfo(
      'Canva Pro',
      const Color(0xFF00C4CC),
      FontAwesomeIcons.palette,
    ),
    'microsoft': BrandInfo(
      'Microsoft 365',
      const Color(0xFF0078D4),
      FontAwesomeIcons.microsoft,
    ),
    'office': BrandInfo(
      'Office 365',
      const Color(0xFFD83B01),
      FontAwesomeIcons.microsoft,
    ),
    'dropbox': BrandInfo(
      'Dropbox',
      const Color(0xFF0061FF),
      FontAwesomeIcons.dropbox,
    ),
    'google one': BrandInfo(
      'Google One',
      const Color(0xFF4285F4),
      FontAwesomeIcons.google,
    ),
    'zoom': BrandInfo('Zoom', const Color(0xFF2D8CFF), FontAwesomeIcons.video),
    'slack': BrandInfo(
      'Slack',
      const Color(0xFF4A154B),
      FontAwesomeIcons.slack,
    ),

    // --- Alışveriş & E-Ticaret ---
    'amazon': BrandInfo(
      'Amazon Prime',
      const Color(0xFF00A8E1),
      FontAwesomeIcons.amazon,
    ),
    'hepsiburada': BrandInfo(
      'Hepsiburada Premium',
      const Color(0xFFFF6000),
      FontAwesomeIcons.bagShopping,
    ),
    'trendyol': BrandInfo(
      'Trendyol Elite',
      const Color(0xFFF27A1A),
      FontAwesomeIcons.bagShopping,
    ),
    'getir': BrandInfo(
      'Getir',
      const Color(0xFF5D3EBC),
      FontAwesomeIcons.bicycle,
    ),
    'yemeksepeti': BrandInfo(
      'Yemeksepeti',
      const Color(0xFFEA004B),
      FontAwesomeIcons.burger,
    ),
    'martı': BrandInfo(
      'Martı',
      const Color(0xFF33C27F),
      FontAwesomeIcons.motorcycle,
    ),

    // --- Sosyal Medya & Arkadaşlık ---
    'linkedin': BrandInfo(
      'LinkedIn Premium',
      const Color(0xFF0077B5),
      FontAwesomeIcons.linkedin,
    ),
    'tinder': BrandInfo(
      'Tinder',
      const Color(0xFFFE3C72),
      FontAwesomeIcons.fire,
    ),
    'bumble': BrandInfo(
      'Bumble',
      const Color(0xFFFFC629),
      FontAwesomeIcons.heart,
    ),
    'twitter': BrandInfo(
      'X Premium',
      const Color(0xFF000000),
      FontAwesomeIcons.xTwitter,
    ),
    'x premium': BrandInfo(
      'X Premium',
      const Color(0xFF000000),
      FontAwesomeIcons.xTwitter,
    ),
    'snapchat': BrandInfo(
      'Snapchat+',
      const Color(0xFFFFFC00),
      FontAwesomeIcons.snapchat,
    ),

    // --- Bulut & Ekosistem ---
    'icloud': BrandInfo(
      'iCloud',
      const Color(0xFF555555),
      FontAwesomeIcons.cloud,
    ),
    'apple': BrandInfo(
      'Apple',
      const Color(0xFF555555),
      FontAwesomeIcons.apple,
    ),

    // --- Spor & Sağlık ---
    'strava': BrandInfo(
      'Strava',
      const Color(0xFFFC4C02),
      FontAwesomeIcons.personRunning,
    ),
    'headspace': BrandInfo(
      'Headspace',
      const Color(0xFFF47D31),
      FontAwesomeIcons.brain,
    ),
    'calm': BrandInfo('Calm', const Color(0xFF0058CC), FontAwesomeIcons.spa),
    'macfit': BrandInfo(
      'MacFit',
      const Color(0xFF004F9F),
      FontAwesomeIcons.dumbbell,
    ),
  };

  // 🔍 Gelişmiş Kategori İkonu Algılayıcı
  static IconData getIconByCategory(String name) {
    final lowerName = name.toLowerCase();

    // 1. Spor & Sağlık
    if (lowerName.contains('spor') ||
        lowerName.contains('gym') ||
        lowerName.contains('fitness') ||
        lowerName.contains('pilates') ||
        lowerName.contains('yoga') ||
        lowerName.contains('macfit') ||
        lowerName.contains('health')) {
      return FontAwesomeIcons.dumbbell;
    }

    // 2. Konut & Barınma
    if (lowerName.contains('kira') ||
        lowerName.contains('ev') ||
        lowerName.contains('aidat') ||
        lowerName.contains('site') ||
        lowerName.contains('apartman')) {
      return FontAwesomeIcons.house;
    }

    // 3. İletişim & İnternet
    if (lowerName.contains('internet') ||
        lowerName.contains('wifi') ||
        lowerName.contains('turkcell') ||
        lowerName.contains('vodafone') ||
        lowerName.contains('türk telekom') ||
        lowerName.contains('superonline') ||
        lowerName.contains('türksat') ||
        lowerName.contains('telefon') ||
        lowerName.contains('fatura')) {
      return FontAwesomeIcons.wifi;
    }

    // 4. Eğitim & Kurs
    if (lowerName.contains('kurs') ||
        lowerName.contains('ders') ||
        lowerName.contains('okul') ||
        lowerName.contains('udemy') ||
        lowerName.contains('coursera') ||
        lowerName.contains('eğitim') ||
        lowerName.contains('kitap')) {
      return FontAwesomeIcons.graduationCap;
    }

    // 5. Oyun
    if (lowerName.contains('game') ||
        lowerName.contains('oyun') ||
        lowerName.contains('play') ||
        lowerName.contains('plus')) {
      return FontAwesomeIcons.gamepad;
    }

    // 6. Yeme & İçme
    if (lowerName.contains('yemek') ||
        lowerName.contains('burger') ||
        lowerName.contains('pizza') ||
        lowerName.contains('kahve') ||
        lowerName.contains('starbucks') ||
        lowerName.contains('market') ||
        lowerName.contains('migros') ||
        lowerName.contains('getir')) {
      return FontAwesomeIcons.utensils;
    }

    // 7. Ulaşım & Araç
    if (lowerName.contains('taksi') ||
        lowerName.contains('uber') ||
        lowerName.contains('martı') ||
        lowerName.contains('binbin') ||
        lowerName.contains('otobüs') ||
        lowerName.contains('metro') ||
        lowerName.contains('benzin') ||
        lowerName.contains('mazot')) {
      return FontAwesomeIcons.car;
    }

    // 8. Faturalar (Genel)
    if (lowerName.contains('elektrik') ||
        lowerName.contains('enerjisa') ||
        lowerName.contains('tedaş')) {
      return FontAwesomeIcons.bolt;
    }
    if (lowerName.contains('su') || lowerName.contains('iski')) {
      return FontAwesomeIcons.faucetDrip;
    }
    if (lowerName.contains('gaz') || lowerName.contains('igdaş')) {
      return FontAwesomeIcons.fire;
    }

    // 9. Yazılım & Bulut
    if (lowerName.contains('cloud') ||
        lowerName.contains('drive') ||
        lowerName.contains('server') ||
        lowerName.contains('vpn')) {
      return FontAwesomeIcons.cloud;
    }

    return FontAwesomeIcons.creditCard;
  }

  static List<String> getBrandNames() {
    return _brands.values.map((e) => e.name).toSet().toList();
  }

  static BrandInfo? getBrandInfo(String inputName) {
    final cleaned = inputName.toLowerCase().trim();

    for (var key in _brands.keys) {
      if (cleaned.contains(key)) {
        return _brands[key];
      }
    }
    return null;
  }
}
