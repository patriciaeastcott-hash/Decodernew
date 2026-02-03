import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:decoder/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // FIX: Changed MyApp to LinguisticDecoderApp to match main.dart
    await tester.pumpWidget(const DecoderApp());

    // Basic smoke test remains standard for structure validation
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
