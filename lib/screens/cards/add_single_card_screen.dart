import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nectar_app/components/buttons/nectar_regular_button.dart';
import 'package:nectar_app/components/layout/nectar_app_bar.dart';
import 'package:nectar_app/components/layout/nectar_drawer.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/helpers/ai_card_recognition_service.dart';
import 'package:nectar_app/helpers/cards_helper.dart';
import 'package:nectar_app/helpers/form_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/auth/login_screen.dart';
import 'package:nectar_app/screens/cards/cards_collection_screen.dart';

/// Add a new Nectar card for current user
///
/// Only first and last names are required for a new card at the moment.
/// The other fields are initially blank, and can be filled out later.
///
/// This screen is used by both owned cards and cards collection, using [isOwnCard] to switch.
class AddSingleCardScreen extends StatefulWidget {
  final bool isOwnCard;

  const AddSingleCardScreen({super.key, this.isOwnCard = false});

  @override
  State<AddSingleCardScreen> createState() => _AddSingleCardScreenState();
}

class _AddSingleCardScreenState extends State<AddSingleCardScreen>
    with TickerProviderStateMixin {
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

  // controller for TabBar and TabView
  late final TabController _tabController;

  // image picker for A.I. service
  // https://pub.dev/packages/image_picker/example
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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

  // Call AI service to get schema for an image user provides
  Future<void> scanCard(String uid, {bool isCamera = false}) async {
    try {
      if (isCamera) {
        // anaylze image from camera
        await _launchImagePicker(ImageSource.gallery);
      } else {
        // analyze image from gallery
        await _launchImagePicker(ImageSource.gallery);
      }

      if (imageFile == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      // send image into A.I. service
      await AICardRecognitionService.generateNectarCard(
        '',
        uid,
        isOwnCard: widget.isOwnCard,
        imagePath: imageFile!.path,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: NectarRegularText(
            'Added a new card to your collection.',
            color: Theme.of(context).colorScheme.onSecondary,
          )),
        );
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const CardsCollectionScreen(),
          ),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: NectarRegularText(
                  'Error adding card. Please try again later.')),
        );
      }
    }
  }

  // handle image picking
  Future<void> _launchImagePicker(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 1,
      );
      setState(() {
        imageFile = pickedFile;
      });
    } catch (e) {
      // show snack with error
    }
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
            // fetch all cards for current user
            widgetTree = FutureBuilder<List<NectarCard>>(
                future: fetchUserAllCards(snapshotAuth.data!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<NectarCard>> snapshotCards) {
                  if (snapshotCards.connectionState == ConnectionState.done &&
                      snapshotCards.hasData) {
                    return ListView(shrinkWrap: true, children: [
                      NectarRegularText(
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

          return Scaffold(
              drawer: NectarDrawer(),
              appBar: NectarAppBar(
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
                        NectarRegularButton(
                          parentIsLoading: isLoading,
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            scanCard(snapshotAuth.data!.uid);
                          },
                          padding: EdgeInsets.symmetric(vertical: 30),
                          iconData: Icons.image_sharp,
                          label: 'Generate from an image',
                        ),
                        NectarRegularButton(
                          parentIsLoading: isLoading,
                          onPressed: () {
                            setState(() {
                              isLoading = true;
                            });
                            scanCard(snapshotAuth.data!.uid);
                          },
                          padding: EdgeInsets.symmetric(vertical: 30),
                          iconData: Icons.camera_alt_sharp,
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
                          child: NectarRegularButton(
                              label: 'Complete adding a new card',
                              iconData: Icons.done_sharp,
                              onPressed: () => addNewCardFormHelper(
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
                                      'department': _departmentController.text,
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
                                  'Adding new card successful',
                                  isOwnCard: widget.isOwnCard)),
                        ),
                      ]),
                ])),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: TabBar(
                    labelStyle: TextStyle(fontSize: 18),
                    unselectedLabelStyle: TextStyle(fontSize: 18),
                    controller: _tabController,
                    tabs: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Tab(
                          icon: Icon(Icons.image_sharp),
                          text: 'Generate',
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Tab(
                          icon: Icon(Icons.add_sharp),
                          text: 'Add manually',
                        ),
                      ),
                    ],
                  ),
                ),
              ]));
        });
  }
}
