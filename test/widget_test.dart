import 'package:flutter_test/flutter_test.dart';
import 'package:zarvix/zarvix_app.dart';

void main() {
  testWidgets('ZarvixApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ZarvixApp());
    expect(find.text('ZARVIX QUOTE VAULT'), findsOneWidget);
    expect(find.textContaining('Bookmarks'), findsOneWidget);
  });
}
