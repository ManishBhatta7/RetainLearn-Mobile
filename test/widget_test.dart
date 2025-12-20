// This is a basic Flutter widget test for RetainLearn.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adaptive_ed_coach/main.dart';

void main() {
  testWidgets('RetainLearn app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: RetainLearnApp(),
      ),
    );

    // Verify that the app launches without errors
    // The landing page should contain the app name
    await tester.pumpAndSettle();
    
    // Minimal smoke test - just verify the app builds
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
