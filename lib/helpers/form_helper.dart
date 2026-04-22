import 'package:flutter/material.dart';

typedef FormFieldValidatorFn = String? Function(String? value);

/// A small catalog of reusable validators for form fields.
class FormValidators {
  static const List<String> available = <String>[
    'required',
    'email',
    'minLength',
  ];

  static FormFieldValidatorFn required(String fieldLabel) {
    return (value) {
      if (_isEmpty(value)) {
        return '$fieldLabel is required.';
      }
      return null;
    };
  }

  static FormFieldValidatorFn email() {
    return (value) {
      if (_isEmpty(value)) {
        return null;
      }
      final input = value!.trim();
      if (!input.contains('@')) {
        return 'Enter a valid email.';
      }
      return null;
    };
  }

  static FormFieldValidatorFn minLength(int min, String fieldLabel) {
    return (value) {
      if (_isEmpty(value)) {
        return null;
      }
      final input = value!.trim();
      if (input.length < min) {
        return '$fieldLabel must be at least $min characters.';
      }
      return null;
    };
  }

  static bool _isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }
}

String? runValidators(
  String? value,
  List<FormFieldValidatorFn> validators,
) {
  for (final validator in validators) {
    final error = validator(value);
    if (error != null) {
      return error;
    }
  }
  return null;
}

InputDecoration fieldDecoration(BuildContext context, String labelText) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelText: labelText,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), gapPadding: 10),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
  );
}

Widget formTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String labelText,
  required TextInputAction textInputAction,
  List<FormFieldValidatorFn> validators = const <FormFieldValidatorFn>[],
  TextInputType? keyboardType,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    decoration: fieldDecoration(context, labelText),
    textInputAction: textInputAction,
    validator: (value) => runValidators(value, validators),
    keyboardType: keyboardType,
    obscureText: obscureText,
  );
}
