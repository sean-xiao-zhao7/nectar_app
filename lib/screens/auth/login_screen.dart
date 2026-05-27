import 'package:flutter/material.dart';
import 'package:nectar_app/components/buttons/my_regular_button.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/auth_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';
import 'package:nectar_app/screens/auth/register_screen.dart';
import 'package:nectar_app/screens/home_screen.dart';

/// Log in an existing user
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String resultMessage =
        await loginHelper(_emailController.text, _passwordController.text);
    if (resultMessage.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Log in successful.')),
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

  void _submitGoogle() async {
    final resultMessage = await loginHelperGoogle();
    if (!mounted) {
      return;
    }

    if (resultMessage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google login successful.')),
      );

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(resultMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(
        title: 'Log in',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const MyRegularText('Access your Nectar account.'),
                const SizedBox(height: 24),
                MyRegularButton(
                  label: 'Log in with Google',
                  onPressed: _submitGoogle,
                  iconData: Icons.g_mobiledata,
                ),
                const SizedBox(height: 24),
                const MyRegularText('OR'),
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
                MyRegularButton(
                  label: 'Log in to Nectar',
                  onPressed: _submit,
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
                    child: MyRegularText(
                        'Sign up here instead.'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
