import 'package:flutter_test/flutter_test.dart';

import 'package:fittrack/main.dart';

void main() {
  testWidgets('Dashboard renders greeting and stats', (WidgetTester tester) async {
    await tester.pumpWidget(const FitTrackApp());

    expect(find.text('Alex Carter'), findsOneWidget);
    expect(find.text('Steps'), findsOneWidget);
    expect(find.text('Move'), findsOneWidget);
  });
}
