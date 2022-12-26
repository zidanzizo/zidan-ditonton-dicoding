import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  testWidgets('kSubtitle textstyle changes propagate to Text', (WidgetTester tester) async {
    const Text textWidget = Text('Hello', textDirection: TextDirection.ltr);

    await tester.pumpWidget(DefaultTextStyle(
      style: kSubtitle,
      child: textWidget,
    ));

    RichText text = tester.firstWidget(find.byType(RichText));
    expect(text, isNotNull);
    expect(text.text.style, kSubtitle);
  });

  testWidgets('kBodyText textstyle changes propagate to Text', (WidgetTester tester) async {
    const Text textWidget = Text('Hello', textDirection: TextDirection.ltr);

    await tester.pumpWidget(DefaultTextStyle(
      style: kBodyText,
      child: textWidget,
    ));

    RichText text = tester.firstWidget(find.byType(RichText));
    expect(text, isNotNull);
    expect(text.text.style, kBodyText);
  });

  testWidgets('textTheme changes propagate to Text', (WidgetTester tester) async {
    const Text textWidget = Text('Hello', textDirection: TextDirection.ltr);
    TextStyle s1 = GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400);

    await tester.pumpWidget(DefaultTextStyle(
      style: kTextTheme.headline5!,
      child: textWidget,
    ));

    RichText text = tester.firstWidget(find.byType(RichText));
    expect(text, isNotNull);
    expect(text.text.style, s1);
  });
}
