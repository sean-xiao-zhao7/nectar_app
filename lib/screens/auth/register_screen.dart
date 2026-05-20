import 'package:flutter/material.dart';

import 'package:nectar_app/components/buttons/my_regular_button.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/auth_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';
import 'package:nectar_app/screens/home_screen.dart';

/// Register a new user
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAgreementChecked = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Callback for register button
  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String resultMessage = await signUpHelper(
        _emailController.text,
        _passwordController.text,
        _firstNameController.text,
        _lastNameController.text);
    if (resultMessage.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up successful.')),
        );

        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const HomeScreen(),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(
        title: 'Sign up',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const MyRegularText(
                    'A few details to get started with Nectar.'),
                const SizedBox(height: 24),
                myTextFormField(
                  context: context,
                  controller: _firstNameController,
                  labelText: 'First name',
                  capitalize: true,
                  textInputAction: TextInputAction.next,
                  validators: <FormFieldValidatorFn>[
                    FormValidators.required('First name'),
                  ],
                ),
                const SizedBox(height: 24),
                myTextFormField(
                  context: context,
                  controller: _lastNameController,
                  labelText: 'Last name',
                  capitalize: true,
                  textInputAction: TextInputAction.next,
                  validators: <FormFieldValidatorFn>[
                    FormValidators.required('Last name'),
                  ],
                ),
                const SizedBox(height: 24),
                myTextFormField(
                  context: context,
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validators: <FormFieldValidatorFn>[
                    FormValidators.email(),
                  ],
                ),
                const SizedBox(height: 24),
                myTextFormField(
                  context: context,
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validators: <FormFieldValidatorFn>[
                    FormValidators.minLength(6, 'Password'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: _isAgreementChecked,
                      onChanged: (value) {
                        setState(() {
                          _isAgreementChecked = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: MyRegularText(
                        'I agree to Nectar\'s Terms of Service and Privacy Policy.',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                MyRegularButton(
                  label: 'Sign up to Nectar',
                  onPressed: _isAgreementChecked ? _submit : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
