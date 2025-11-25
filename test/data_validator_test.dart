import 'package:flutter_test/flutter_test.dart';
import 'package:tests/data_validator.dart';

void main() {
  late DataValidator validator;

  setUp(() {
    validator = DataValidator();
  });

  test('should return true for valid value', () {
    expect(validator.isValid(50), true);
  });

  test('should return false for value <1', () {
    expect(validator.isValid(0), false);
  });

  test('should return false for value >100', () {
    expect(validator.isValid(101), false);
  });
}
