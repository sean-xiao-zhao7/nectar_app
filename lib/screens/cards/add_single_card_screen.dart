import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nectar_app/components/buttons/my_regular_button.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/ai_card_recognition_service.dart';
import 'package:nectar_app/helpers/cards_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/auth/login_screen.dart';

/// Add a new Nectar card for current user
///
/// Only first and last names are required for a new card at the moment.
/// The other fields are initially blank, and can be filled out later.
///
/// This screen is used by both owned cards and cards collection, using forCardsCollection to switch.
class AddSingleCardScreen extends StatefulWidget {
  final bool forCardsCollection;

  const AddSingleCardScreen({super.key, this.forCardsCollection = false});

  @override
  State<AddSingleCardScreen> createState() => _AddSingleCardScreenState();
}

class _AddSingleCardScreenState extends State<AddSingleCardScreen>
    with TickerProviderStateMixin {
  // vars for main form
  final _formKey = GlobalKey<FormState>();
  final _mainNameController = TextEditingController();
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

  // controller for TabBar and TabView
  late final TabController _tabController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _mainNameController.dispose();
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
    _tabController.dispose();
    super.dispose();
  }

  // Call AI service to get schema for an image user provides
  Future<void> scanCard() async {
    NectarCard resultCard =
        await AICardRecognitionService.generateNectarCard('Starbucks');
    print(resultCard);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // check for auth, redirect to login if not authed
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
            // User is authed.
            // Split displayName into first/last names.
            if (snapshotAuth.data!.displayName != null) {
              String fullName = snapshotAuth.data!.displayName!;
              int lastSpaceIndex = fullName.lastIndexOf(' ');
              _firstNameController.text = fullName.substring(0, lastSpaceIndex);
              _lastNameController.text = fullName.substring(lastSpaceIndex + 1);
            }

            // fetch all cards for current user (TODO remove if not needed)
            widgetTree = FutureBuilder<List<NectarCard>>(
                future: fetchUserAllCards(snapshotAuth.data!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NectarCard>> snapshotCards) {
                  if (snapshotCards.connectionState == ConnectionState.done &&
                      snapshotCards.hasData) {
                    return ListView(shrinkWrap: true, children: [
                      MyRegularText(
                        'Please fill in some details for your new card. Other than the main name, other fields can be filled out later if you need.',
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
                              labelText: 'Main Card Name',
                              capitalize: true,
                              textInputAction: TextInputAction.next,
                              validators: <FormFieldValidatorFn>[
                                FormValidators.required('Main name'),
                              ],
                            ),
                            const SizedBox(height: 24),
                            MyRegularText('Optional info below'),
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
              body: Column(children: <Widget>[
                Expanded(
                    // the tabBar is at the bottom of the switchable tab views
                    child: TabBarView(controller: _tabController, children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 30,
                      children: [
                        MyRegularButton(
                          parentIsLoading: isLoading,
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            scanCard();
                          },
                          padding: EdgeInsets.symmetric(vertical: 30),
                          iconData: Icons.image,
                          label: 'Generate from an image',
                        ),
                        MyRegularButton(
                          parentIsLoading: isLoading,
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            scanCard();
                          },
                          padding: EdgeInsets.symmetric(vertical: 30),
                          iconData: Icons.camera_alt,
                          label: 'Generate by camera',
                        ),
                      ],
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.12),
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                  ]),
                              child: widgetTree),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 15, right: 15, bottom: 5),
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: MyRegularButton(
                              label: 'Complete adding a new card',
                              iconData: Icons.done,
                              onPressed: () => addNewCardFormHelper(
                                  context,
                                  _formKey,
                                  {
                                    'mainName': _mainNameController.text,
                                    'personalInfo': {
                                      'firstName': _firstNameController.text,
                                      'lastName': _lastNameController.text,
                                      'email': _emailController.text,
                                      'phone': _phoneController.text,
                                    },
                                    'companyInfo': {
                                      'job': _jobController.text,
                                      'company': _companyController.text,
                                    },
                                    'socialMedia': {
                                      'website': _websiteController.text,
                                    },
                                    'addressInfo': {
                                      'address': _addressController.text,
                                      'city': _cityController.text,
                                      'state': _stateController.text,
                                      'country': _countryController.text,
                                      'postal': _postalController.text,
                                    },
                                    'uid': snapshotAuth.data!.uid,
                                  },
                                  'Adding new card successful',
                                  fetchOwnedCards: !widget.forCardsCollection)),
                        ),
                      ]),
                ])),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TabBar(
                    labelStyle: TextStyle(fontSize: 18),
                    unselectedLabelStyle: TextStyle(fontSize: 18),
                    controller: _tabController,
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(Icons.image),
                        text: 'Generate',
                      ),
                      Tab(
                        icon: Icon(Icons.add),
                        text: 'Add manually',
                      ),
                    ],
                  ),
                ),
              ]));
        });
  }
}
