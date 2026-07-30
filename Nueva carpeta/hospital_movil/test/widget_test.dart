import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hospital_movil/app/app.dart';
import 'package:hospital_movil/app/di/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await GetIt.I.reset();
  });

  testWidgets('MovilHospitalApp initial test', (WidgetTester tester) async {
    await initDependencyInjection();
    await tester.pumpWidget(const MovilHospitalApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(MovilHospitalApp), findsOneWidget);
  });
}
