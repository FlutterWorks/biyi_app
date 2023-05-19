import 'package:flutter/material.dart';

import '../../includes.dart';

class WordSentenceView extends StatelessWidget {
  final WordSentence wordSentence;

  const WordSentenceView(
    this.wordSentence, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 6),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: wordSentence.text),
                const TextSpan(text: '\n'),
                TextSpan(
                  text: wordSentence.translations.first,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            style: textTheme.bodyMedium!.copyWith(
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
