import 'package:scanify/core/l10n/app_localizations.dart';

enum AutoDeleteDay {
  never(-1),
  short(7),
  long(30),
  extended(90);

  final int value;
  const AutoDeleteDay(this.value);

  String label(AppLocalizations l) => switch (this) {
    AutoDeleteDay.never => l.autoDeleteNever,
    AutoDeleteDay.short => l.autoDelete7,
    AutoDeleteDay.long => l.autoDelete30,
    AutoDeleteDay.extended => l.autoDelete90,
  };

  static Map<AutoDeleteDay, String> asMapLabel(AppLocalizations l) => {
    AutoDeleteDay.never: l.autoDeleteNever,
    AutoDeleteDay.short: l.autoDelete7,
    AutoDeleteDay.long: l.autoDelete30,
    AutoDeleteDay.extended: l.autoDelete90,
  };
}
