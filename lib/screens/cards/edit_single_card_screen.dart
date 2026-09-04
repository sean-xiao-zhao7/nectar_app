import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/components/buttons/my_regular_button.dart';
import 'package:nectar_app/components/layout/my_scaffold_container.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/cards_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/auth/login_screen.dart';

/// Edit an exiting Nectar card for current user
///
/// Only first and last names are required for a new card at the moment.
/// The other fields are initially blank, and can be filled out later.
class EditSingleCardScreen extends StatefulWidget {
  final NectarCard nectarCard;

  const EditSingleCardScreen({super.key, required this.nectarCard});

  @override
  State<EditSingleCardScreen> createState() => _EditSingleCardScreenState();
}

class _EditSingleCardScreenState extends State<EditSingleCardScreen> {
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

  @override
  void initState() {
    _firstNameController.text = widget.nectarCard.personalInfo['firstName']!;
    _lastNameController.text = widget.nectarCard.personalInfo['lastName']!;
    _phoneController.text = widget.nectarCard.personalInfo['phone']!;
    _emailController.text = widget.nectarCard.personalInfo['email']!;
    _jobController.text = widget.nectarCard.companyInfo['job']!;
    _companyController.text = widget.nectarCard.companyInfo['company']!;
    _websiteController.text = widget.nectarCard.companyInfo['website']!;
    _addressController.text = widget.nectarCard.companyInfo['address']!;
    _cityController.text = widget.nectarCard.addressInfo['city']!;
    _stateController.text = widget.nectarCard.addressInfo['state']!;
    _countryController.text = widget.nectarCard.addressInfo['country']!;
    _postalController.text = widget.nectarCard.addressInfo['postal']!;
    super.initState();
  }

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
            // Split displayName into first/last names.
            if (snapshotAuth.data!.displayName != null) {
              String fullName = snapshotAuth.data!.displayName!;
              int lastSpaceIndex = fullName.lastIndexOf(' ');
              _firstNameController.text = fullName.substring(0, lastSpaceIndex);
              _lastNameController.text = fullName.substring(lastSpaceIndex + 1);
            }

            widgetTree = FutureBuilder<List<NectarCard>>(
                future: fetchUserAllCards(snapshotAuth.data!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NectarCard>> snapshotCards) {
                  if (snapshotCards.connectionState == ConnectionState.done &&
                      snapshotCards.hasData) {
                    return ListView(shrinkWrap: true, children: [
                      MyRegularText(
                        'Other than first/last names, other fields can be filled out later if you need.',
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
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _phoneController,
                              labelText: 'Phone',
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
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

          return MyScaffoldContainer(
              title: 'Edit Card',
              appBarLead: IconButton(
                icon: const Icon(Icons.arrow_back_sharp),
                onPressed: () => Navigator.pop(context),
              ),
              appBarActions: [
                IconButton(
                  icon: const Icon(Icons.delete_sharp),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 20),
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
                          label: 'Complete editing card',
                          iconData: Icons.done_sharp,
                          onPressed: () => editCardFormHelper(
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
                                'uid': snapshotAuth.data!.uid,
                              },
                              'Edit card successful',
                              widget.nectarCard.cardId)),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 50),
                        child: MyRegularText('\u00a9 2026 Nectar Inc.'))
                  ]));
        });
  }
}
