import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';

void main() {
  String sampleJson = '''
{
  \"list\": [
     {
            \"definition\": \"Used when \"no\" is too [formal], and \"nope\" is too [casual].\n\n[If it's] ever capitilized, you're using it wrong.\",
            \"permalink\": \"http://nah.urbanup.com/8326552\",
            \"thumbs_up\": 2468,
            \"author\": \"ICantThinkOfAUsername\",
            \"word\": \"nah\",
            \"defid\": 8326552,
            \"current_vote\": \"\",
            \"written_on\": \"2015-06-21T17:00:22.542Z\",
            \"example\": \"[Police]: \"Did you [kill] [this man]?!\"\r\nMe: nah\",
            \"thumbs_down\": 188
        }
  ]
}
''';

  List<UrbanWord> l = <UrbanWord>[
    UrbanWord(
      definition:
          'Used when \"no\" is too [formal], and "nope" is too [casual].\n\n[If it\'s] ever capitilized, you\'re using it wrong.',
      permalink: 'http://nah.urbanup.com/8326552',
      thumbsUp: 2468,
      author: 'ICantThinkOfAUsername',
      word: 'nah',
      defId: 8326552,
      currentVote: '',
      writtenOn: DateTime.parse('2015-06-21T17:00:22.542Z'.replaceAll('Z', '')),
      example: '[Police]: \"Did you [kill] [this man]?!"\r\nMe: nah',
      thumbsDown: 188,
    ),
  ];
  group('urban word ...', () {
    test('should be equal l List', () {
      expect(
          UrbanWord.fromJsonList(
              jsonDecode(sampleJson) as Map<String, dynamic>),
          l);
    });
  });
}
