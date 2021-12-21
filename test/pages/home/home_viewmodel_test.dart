import 'package:flutter_test/flutter_test.dart';
import 'package:template_app/api/gql/gql_link.dart';
import 'package:template_app/pages/home/home_viewmodel.dart';

void main() {
  group('HomeViewmodelTest -', () {
    late HomeViewModel viewModel;
    setUp(() {
      viewModel = HomeViewModel();
    });
    tearDown(() => viewModel.dispose());

    group('Initialized -', () {
      final viewModel = HomeViewModel();
      test(
          'Given , When called HomeViewModel, Then load a data and return NotFoundException.',
          () async {
        expect(() async => await viewModel.loadData(),
            throwsA(isA<NotFoundException>()));
      });
      test('Given, When HomeViewModel loaded, Then viewModel has error.', () {
        expect(viewModel.hasError, true);
      });
    });

    group('Button Test -', () {
      test(
          'Given a submit button, When submit button press, Then the onButtonTap() function will return true.',
          () async {
        bool result = await viewModel.onButtonTap();
        expect(result, true);
      });
    });
  });
}
