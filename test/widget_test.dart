import 'package:flutter_test/flutter_test.dart';
import 'package:stayzone/app/app.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to StayZone'), findsOneWidget);
  });
}
