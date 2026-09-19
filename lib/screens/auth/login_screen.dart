import 'package:flutter/material.dart';

import 'package:nectar_app/components/buttons/nectar_regular_button.dart';
import 'package:nectar_app/components/layout/nectar_app_bar.dart';
import 'package:nectar_app/components/layout/nectar_drawer.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';

import 'package:nectar_app/helpers/auth_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';

import 'package:nectar_app/screens/auth/register_screen.dart';

/// Log in an existing user
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NectarDrawer(),
      appBar: NectarAppBar(
        title: 'Log in',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const NectarRegularText('Access your Nectar account.'),
                const SizedBox(height: 24),
                NectarRegularButton(
                  label: 'Log in with Google',
                  onPressed: () => authFormSubmitGoogleHelper(context),
                  iconData: Icons.g_mobiledata_sharp,
                ),
                const SizedBox(height: 24),
                const NectarRegularText('OR'),
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
                  maxLines: 1,
                  validators: <FormFieldValidatorFn>[
                    FormValidators.minLength(6, 'Password'),
                  ],
                ),
                const SizedBox(height: 24),
                NectarRegularButton(
                  label: 'Log in to Nectar',
                  onPressed: () => authFormSubmitHelper(
                      context,
                      formKey,
                      loginHelper,
                      {
                        'email': _emailController.text,
                        'password': _passwordController.text
                      },
                      'Login successful'),
                ),
                const SizedBox(height: 24),
                TextButton(
                    onPressed: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const RegisterScreen(),
                            ),
                          )
                        },
                    child: NectarRegularText('Sign up here instead.'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
