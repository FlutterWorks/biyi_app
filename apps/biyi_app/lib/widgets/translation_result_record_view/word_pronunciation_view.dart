import 'package:biyi_app/models/ext_word_pronunciation.dart';
import 'package:biyi_app/widgets/sound_play_button/sound_play_button.dart';
import 'package:influxui/influxui.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

class WordPronunciationView extends StatelessWidget {
  const WordPronunciationView(
    this.wordPronunciation, {
    super.key,
  });

  final WordPronunciation wordPronunciation;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SelectableText.rich(
            TextSpan(
              text: '',
              children: [
                if ((wordPronunciation.type ?? '').isNotEmpty)
                  TextSpan(
                    text: '${wordPronunciation.localType} ',
                    style: textTheme.bodyMedium!.copyWith(
                      fontSize: 13,
                    ),
                  ),
                if ((wordPronunciation.phoneticSymbol ?? '').isNotEmpty)
                  TextSpan(
                    text: '[${wordPronunciation.phoneticSymbol}]',
                  ),
              ],
            ),
            style: textTheme.bodySmall!.copyWith(
              fontSize: 13,
            ),
          ),
          if ((wordPronunciation.audioUrl ?? '').isNotEmpty)
            Container(
              margin: const EdgeInsets.only(left: 10, top: 2),
              child: SoundPlayButton(
                audioUrl: wordPronunciation.audioUrl!,
              ),
            ),
        ],
      ),
    );
  }
}
