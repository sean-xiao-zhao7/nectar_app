import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nectar_app/components/buttons/my_regular_button.dart';

import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';

import 'package:nectar_app/helpers/cards_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';

import 'package:nectar_app/screens/auth/login_screen.dart';

/// Add a new Nectar card for current user
///
/// Only first and last names are required for a new card at the moment.
/// The other fields are initially blank, and can be filled out later.
class AddSingleCardScreen extends StatefulWidget {
  const AddSingleCardScreen({super.key});

  @override
  State<AddSingleCardScreen> createState() => _AddSingleCardScreenState();
}

class _AddSingleCardScreenState extends State<AddSingleCardScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _jobController = TextEditingController();
  final _companyController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalController = TextEditingController();
  final bool _isFormValid = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _jobController.dispose();
    _companyController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshotAuth) {
          Widget widgetTree = Center(child: CircularProgressIndicator());
          if (snapshotAuth.connectionState == ConnectionState.done &&
              !snapshotAuth.hasData) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const LoginScreen(),
              ),
            );
          } else if (snapshotAuth.connectionState == ConnectionState.active &&
              snapshotAuth.hasData) {
            widgetTree = FutureBuilder<List<NectarCard>>(
                future: fetchUserAllCards(snapshotAuth.data!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NectarCard>> snapshotCards) {
                  if (snapshotCards.connectionState == ConnectionState.done &&
                      snapshotCards.hasData) {
                    return ListView(shrinkWrap: true, children: [
                      MyRegularText(
                        'Please fill in some details for your new card. Other than first/last names, other fields can be filled out later.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
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
                            MyRegularText('Optional info below'),
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
                              controller: _phoneController,
                              labelText: 'Phone',
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              validators: <FormFieldValidatorFn>[
                                FormValidators.minLength(6, 'Phone'),
                              ],
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _jobController,
                              labelText: 'Job',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _companyController,
                              labelText: 'Company',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _websiteController,
                              labelText: 'Website',
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _addressController,
                              labelText: 'Address',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _cityController,
                              labelText: 'City',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _stateController,
                              labelText: 'State',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _countryController,
                              labelText: 'Country',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _postalController,
                              labelText: 'Postal code',
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                    ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }

          return Scaffold(
              drawer: MyDrawer(),
              appBar: MyAppBar(
                title: 'Add a new card',
              ),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.12),
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                ),
                              ]),
                          child: widgetTree),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: MyRegularButton(
                        label: 'Complete adding a new card',
                        onPressed: _isFormValid
                            ? () => addNewCardFormHelper(
                                context,
                                _formKey,
                                {
                                  'firstName': _firstNameController.text,
                                  'lastName': _lastNameController.text,
                                  'email': _emailController.text,
                                  'phone': _phoneController.text,
                                  'job': _jobController.text,
                                  'company': _companyController.text,
                                  'website': _websiteController.text,
                                  'address': _addressController.text,
                                  'city': _cityController.text,
                                  'state': _stateController.text,
                                  'country': _countryController.text,
                                  'postal': _postalController.text,
                                },
                                'Sign up successful')
                            : null,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 50),
                        child: MyRegularText('\u00a9 2026 Nectar Inc.'))
                  ]));
        });
  }
}
