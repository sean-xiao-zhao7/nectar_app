import 'package:flutter_test/flutter_test.dart';
import 'package:nectar_app/helpers/form_helper.dart';

void main() {
  group('FormValidators.available', () {
    test('contains expected validator names', () {
      expect(FormValidators.available, <String>['required', 'email', 'minLength']);
    });
  });

  group('FormValidators.required', () {
    test('returns error for null/empty/whitespace input', () {
      final validator = FormValidators.required('Email');

      expect(validator(null), 'Email is required.');
      expect(validator(''), 'Email is required.');
      expect(validator('   '), 'Email is required.');
    });

    test('returns null for non-empty input', () {
      final validator = FormValidators.required('Email');
      expect(validator('jane@nectar.app'), isNull);
    });
  });

  group('FormValidators.email', () {
    test('returns null for null/empty input', () {
      final validator = FormValidators.email();

      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('   '), isNull);
    });

    test('returns error for invalid email', () {
      final validator = FormValidators.email();
      expect(validator('not-an-email'), 'Enter a valid email.');
    });

    test('returns null for valid email', () {
      final validator = FormValidators.email();
      expect(validator('jane@nectar.app'), isNull);
    });
  });

  group('FormValidators.minLength', () {
    test('returns null for null/empty input', () {
      final validator = FormValidators.minLength(6, 'Password');

      expect(validator(null), isNull);
      expect(validator(''), isNull);
      expect(validator('   '), isNull);
    });

    test('returns error when shorter than minimum', () {
      final validator = FormValidators.minLength(6, 'Password');
      expect(validator('12345'), 'Password must be at least 6 characters.');
    });

    test('returns null when meeting minimum', () {
      final validator = FormValidators.minLength(6, 'Password');
      expect(validator('123456'), isNull);
    });
  });

  group('runValidators', () {
    test('returns first failing validation message', () {
      final result = runValidators(
        'bad',
        <FormFieldValidatorFn>[
          FormValidators.required('Email'),
          FormValidators.email(),
        ],
      );

      expect(result, 'Enter a valid email.');
    });

    test('returns null when all validators pass', () {
      final result = runValidators(
        'jane@nectar.app',
        <FormFieldValidatorFn>[
          FormValidators.required('Email'),
          FormValidators.email(),
        ],
      );

      expect(result, isNull);
    });
  });
}
