import 'package:flutter/material.dart';
import 'package:nectar_app/components/buttons/my_regular_button.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/form_helper.dart';

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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign up successful.')),
    );
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
                // const SizedBox(height: 24),
                const SizedBox(height: 24),
                MyRegularButton(label: 'Sign up to Nectar', onPressed: _submit)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
