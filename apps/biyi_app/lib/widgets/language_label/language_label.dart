import 'package:biyi_app/includes.dart';
import 'package:influxui/influxui.dart';

class LanguageLabel extends StatelessWidget {
  const LanguageLabel(
    this.language, {
    super.key,
    this.flagSize = 22,
    this.flagBorderColor,
    this.style,
  });

  final String language;
  final double flagSize;
  final Color? flagBorderColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GappedRow(
      gap: 5,
      mainAxisSize: MainAxisSize.min,
      children: [
        LanguageFlagView(
          language,
          size: flagSize,
          borderColor: flagBorderColor,
        ),
        DefaultTextStyle(
          style: textTheme.bodyMedium!,
          child: Text(
            getLanguageName(language),
            style: style,
          ),
        ),
      ],
    );
  }
}
