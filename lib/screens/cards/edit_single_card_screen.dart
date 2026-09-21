import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/components/buttons/nectar_regular_button.dart';
import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/components/util/nectar_loading_indicator.dart';
import 'package:nectar_app/helpers/cards_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/helpers/ui_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/home_screen.dart';

/// Edit an exiting Nectar card for current user
///
/// Only first and last names are required for a new card at the moment.
/// The other fields are initially blank, and can be filled out later.
class EditSingleCardScreen extends StatefulWidget {
  final NectarCard nectarCard;
  final bool isOwnCard;

  const EditSingleCardScreen(
      {super.key, this.isOwnCard = false, required this.nectarCard});

  @override
  State<EditSingleCardScreen> createState() => _EditSingleCardScreenState();
}

class _EditSingleCardScreenState extends State<EditSingleCardScreen> {
  // form vars
  final _formKey = GlobalKey<FormState>();

  final _mainNameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _companyNameController = TextEditingController();
  final _businessTypeController = TextEditingController();
  final _roleController = TextEditingController();
  final _departmentController = TextEditingController();

  final _websiteController = TextEditingController();
  final _linkedInController = TextEditingController();
  final _twitterController = TextEditingController();
  final _instagramController = TextEditingController();
  final _facebookController = TextEditingController();

  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalCodeController = TextEditingController();

  // isLoading trigger
  bool _isLoading = false;

  @override
  void initState() {
    _mainNameController.text = widget.nectarCard.mainName;
    _shortDescriptionController.text = widget.nectarCard.shortDescription;

    _firstNameController.text = widget.nectarCard.personalInfo['firstName']!;
    _lastNameController.text = widget.nectarCard.personalInfo['lastName']!;
    _phoneController.text = widget.nectarCard.personalInfo['phone']!;
    _emailController.text = widget.nectarCard.personalInfo['email']!;

    _companyNameController.text = widget.nectarCard.companyInfo['companyName']!;
    _businessTypeController.text =
        widget.nectarCard.companyInfo['businessType']!;
    _roleController.text = widget.nectarCard.companyInfo['role']!;
    _departmentController.text = widget.nectarCard.companyInfo['department']!;

    _websiteController.text = widget.nectarCard.socialMedia['website']!;
    _linkedInController.text = widget.nectarCard.socialMedia['linkedin']!;
    _twitterController.text = widget.nectarCard.socialMedia['twitter']!;
    _instagramController.text = widget.nectarCard.socialMedia['instagram']!;
    _facebookController.text = widget.nectarCard.socialMedia['facebook']!;

    _streetController.text = widget.nectarCard.addressInfo['street']!;
    _cityController.text = widget.nectarCard.addressInfo['city']!;
    _stateController.text = widget.nectarCard.addressInfo['state']!;
    _countryController.text = widget.nectarCard.addressInfo['country']!;
    _postalCodeController.text = widget.nectarCard.addressInfo['postalCode']!;
    super.initState();
  }

  @override
  void dispose() {
    _mainNameController.dispose();
    _shortDescriptionController.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();

    _companyNameController.dispose();
    _roleController.dispose();
    _businessTypeController.dispose();
    _departmentController.dispose();

    _websiteController.dispose();
    _linkedInController.dispose();
    _twitterController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();

    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  // Delete nectar card from database
  void deleteCard() {
    setState(() {
      _isLoading = true;
    });
    deleteSingleCard(widget.nectarCard.cardId, widget.nectarCard.ownerUserId,
            isOwnCard: widget.isOwnCard)
        .then((message) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        nectarSnackBar(context, 'Card deleted.');
        myNavigate(context, HomeScreen());
      }
    }).catchError((message) {
      setState(() {
        _isLoading = false;
      });
    });
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
                      NectarRegularText(
                        'Other than the main name, other fields can be filled out later if you need.',
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
                              controller: _mainNameController,
                              labelText: 'Main name',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                              validators: <FormFieldValidatorFn>[
                                FormValidators.required('Main name'),
                              ],
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _shortDescriptionController,
                              labelText: 'Short description',
                              capitalize: true,
                              maxLines: 3,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            NectarRegularText('Personal'),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _firstNameController,
                              labelText: 'First name',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _lastNameController,
                              labelText: 'Last name',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
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
                            NectarRegularText('Company'),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _companyNameController,
                              labelText: 'Company name',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _businessTypeController,
                              labelText: 'Business type',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _roleController,
                              labelText: 'Role',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _departmentController,
                              labelText: 'Department',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            NectarRegularText('Social Media'),
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
                              controller: _linkedInController,
                              labelText: 'LinkedIn',
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _twitterController,
                              labelText: 'X',
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _instagramController,
                              labelText: 'Instagram',
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _facebookController,
                              labelText: 'Facebook',
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 24),
                            NectarRegularText('Address'),
                            const SizedBox(height: 24),
                            myTextFormField(
                              context: context,
                              controller: _streetController,
                              labelText: 'Street',
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
                              controller: _postalCodeController,
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

          return NectarScaffoldContainer(
              title: 'Edit Card',
              appBarLead: IconButton(
                icon: const Icon(Icons.arrow_back_sharp),
                onPressed: () => Navigator.pop(context),
              ),
              appBarActions: [
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever_sharp,
                    color: Colors.red,
                  ),
                  onPressed: () => deleteCard(),
                ),
              ],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _isLoading
                      ? [Expanded(child: Nectarloadingindicator())]
                      : [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.12),
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ]),
                                child: widgetTree),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: 10, right: 10, bottom: 0),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: NectarRegularButton(
                                label: 'Complete editing card',
                                iconData: Icons.done_sharp,
                                onPressed: () => editCardFormHelper(
                                    context,
                                    _formKey,
                                    {
                                      'mainName': _mainNameController.text,
                                      'shortDescription':
                                          _shortDescriptionController.text,
                                      'personalInfo': {
                                        'firstName': _firstNameController.text,
                                        'lastName': _lastNameController.text,
                                        'email': _emailController.text,
                                        'phone': _phoneController.text,
                                      },
                                      'companyInfo': {
                                        'companyName':
                                            _companyNameController.text,
                                        'businessType':
                                            _businessTypeController.text,
                                        'role': _roleController.text,
                                        'department':
                                            _departmentController.text,
                                      },
                                      'socialMedia': {
                                        'website': _websiteController.text,
                                        'linkedIn': _linkedInController.text,
                                        'twitter': _twitterController.text,
                                        'instagram': _instagramController.text,
                                        'facebook': _facebookController.text,
                                      },
                                      'addressInfo': {
                                        'address': _streetController.text,
                                        'city': _cityController.text,
                                        'state': _stateController.text,
                                        'country': _countryController.text,
                                        'postal': _postalCodeController.text,
                                      },
                                      'uid': snapshotAuth.data!.uid,
                                    },
                                    'Edit card successful',
                                    widget.nectarCard.cardId,
                                    isOwnCard: widget.isOwnCard)),
                          ),
                        ]));
        });
  }
}
