import 'package:flutter_test/flutter_test.dart';
import 'package:todo_bloc_clean_architecture/main.dart';

void main() {
  testWidgets('App should start without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // You can add more assertions here if needed
  });
}
