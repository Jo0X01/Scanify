import 'package:qrcode_scanner_app/core/enum/tool_data_types.dart'
    show SocialType;

class _SocialConfig {
  final SocialType tool;
  final List<String> detectPatterns;
  final String Function(String) buildUrl;

  const _SocialConfig({
    required this.tool,
    required this.detectPatterns,
    required this.buildUrl,
  });

  bool isContain(String data) {
    return detectPatterns.any((p) => data.contains(p));
  }
}

abstract class SocialUrlResolver {
  SocialUrlResolver._();

  static final _configs = [
    _SocialConfig(
      tool: SocialType.whatsapp,
      detectPatterns: ['wa.me', 'whatsapp'],
      buildUrl: (val) =>
          'https://wa.me/${val.replaceAll(RegExp(r'[\s\+\-\(\)]'), '')}',
    ),
    _SocialConfig(
      tool: SocialType.telegram,
      detectPatterns: ['t.me', 'tg:'],
      buildUrl: (val) => RegExp(r'^\+?[0-9]{7,15}$').hasMatch(val)
          ? 'https://t.me/+${val.replaceAll('+', '')}'
          : 'https://t.me/$val',
    ),
    _SocialConfig(
      tool: SocialType.twitter,
      detectPatterns: ['twitter.com', 'x.com'],
      buildUrl: (val) => 'https://x.com/$val',
    ),
    _SocialConfig(
      tool: SocialType.instagram,
      detectPatterns: ['instagram.com'],
      buildUrl: (val) => 'https://instagram.com/$val',
    ),
    _SocialConfig(
      tool: SocialType.facebook,
      detectPatterns: ['facebook.com'],
      buildUrl: (val) => 'https://facebook.com/$val',
    ),
    _SocialConfig(
      tool: SocialType.youtube,
      detectPatterns: ['youtube.com', 'youtu.be'],
      buildUrl: (val) {
        if (RegExp(r'^UC[a-zA-Z0-9_\-]{22}$').hasMatch(val)) {
          return 'https://youtube.com/channel/$val';
        }
        if (RegExp(r'^[a-zA-Z0-9_\-]{11}$').hasMatch(val)) {
          return 'https://youtu.be/$val';
        }
        return 'https://youtube.com/@$val';
      },
    ),
    _SocialConfig(
      tool: SocialType.tiktok,
      detectPatterns: ['tiktok.com'],
      buildUrl: (val) => 'https://tiktok.com/@$val',
    ),
    _SocialConfig(
      tool: SocialType.paypal,
      detectPatterns: ['paypal'],
      buildUrl: (val) => 'https://paypal.me/$val',
    ),
    _SocialConfig(
      tool: SocialType.snapchat,
      detectPatterns: ['snapchat.com'],
      buildUrl: (val) => 'https://snapchat.com/add/$val',
    ),
    _SocialConfig(
      tool: SocialType.spotify,
      detectPatterns: ['spotify.com'],
      buildUrl: (val) => 'https://open.spotify.com/user/$val',
    ),
    _SocialConfig(
      tool: SocialType.linkedin,
      detectPatterns: ['linkedin.com'],
      buildUrl: (val) => 'https://linkedin.com/in/$val',
    ),
  ];

  static SocialType? detect(String? url) {
    if (url == null) return null;
    final value = url.toLowerCase();
    for (final config in _configs) {
      if (config.isContain(value)) {
        return config.tool;
      }
    }
    return null;
  }

  static String build(SocialType type, String input) {
    final val = input.replaceAll('@', '').trim();
    return _configs.firstWhere((c) => c.tool == type).buildUrl(val);
  }
}
