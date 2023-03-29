import 'package:application/blocs/blocs.dart';
import 'package:application/pages/pages.dart';
import 'package:application/services/services.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  final _facebookLogin = FacebookLogin(debug: true);

  int loginType = -1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = _auth.currentUser?.displayName ?? "";
    _emailController.text = _auth.currentUser?.email ?? "";
    HelperSharedPreferences.getLoginType().then((value) {
      setState(() {
        loginType = value ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void onLogOut() async {
      try {
        showDialog(
          context: context,
          builder: (context) => CustomDialog(
            title: 'Log out',
            content: 'Do you want to log out?',
            onSubmit: () async {
              showDialog(
                  context: context,
                  builder: (context) => const LoadingDialog());

              switch (loginType) {
                case 0:
                  await AuthService().signOut();
                  break;
                case 1:
                  await _googleSignIn.disconnect();
                  await _googleSignIn.signOut();
                  break;
                case 2:
                  await _facebookLogin.logOut();
                  break;
              }

              await AuthService().signOut();
              await HelperSharedPreferences.saveUid('');
              await HelperSharedPreferences.saveToken('');
              await HelperSharedPreferences.saveLoginType(-1);
              await HelperSharedPreferences.saveExpirationTime(-1);
              await HelperSharedPreferences.saveLogin(false);
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginPage.id, (route) => false);
            },
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void onSaveProfile() {
      showDialog(context: context, builder: (context) => const LoadingDialog());
      if (_auth.currentUser != null) {
        BlocProvider.of<ProfileBloc>(context).add(SaveProfileEvent(
            user: _auth.currentUser!, name: _nameController.text));
      }
    }

    Future pickImage() async {
      try {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) {
          return;
        }
        if (_auth.currentUser != null) {
          BlocProvider.of<AvatarBloc>(context).add(ChangeAvatarEvent(
              imagePath: image.path, user: _auth.currentUser!));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void gotoChangePassword() {
      Navigator.of(context).pushNamed(ChangePasswordPage.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile', style: kTextSize28w500White),
        actions: [
          GestureDetector(
            onTap: () => onLogOut(),
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.logout, size: 30.0, color: AppColor.white),
            ),
          )
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case SaveProfileSuccess:
                        // close loading dialog
                        Navigator.of(context).pop();
                        Future.delayed(Duration.zero).then((_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Update profile successfully!',
                                style: kTextSize18w400White),
                            backgroundColor: AppColor.background,
                          ));
                        });
                        return const SizedBox();
                      case SaveProfileFailure:
                        // close loading dialog
                        Navigator.of(context).pop();
                        Future.delayed(Duration.zero).then((_) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Update profile failure!',
                                style: kTextSize18w400White),
                            backgroundColor: AppColor.background,
                          ));
                        });
                        return const SizedBox();
                    }
                    return const SizedBox();
                  },
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: AppColor.blur),
                      borderRadius: BorderRadius.circular(150.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150.0),
                      child: BlocBuilder<AvatarBloc, AvatarState>(
                        builder: (context, state) {
                          if (state is ChangeAvatarLoading) {
                            return SizedBox(
                                height: 150.0,
                                width: 150.0,
                                child: Image.asset(
                                    'assets/images/image_placeholder.gif'));
                          } else if (state is ChangeAvatarSuccess) {
                            debugPrint('success');
                          } else if (state is ChangeAvatarFailure) {
                            debugPrint('fail');
                          }
                          return FadeInImage(
                            placeholder: const AssetImage(
                              'assets/images/image_placeholder.gif',
                            ),
                            image: NetworkImage(_auth.currentUser == null
                                ? noProfileImage
                                : _auth.currentUser?.photoURL ??
                                    noProfileImage),
                            fit: BoxFit.cover,
                            height: 150.0,
                            width: 150.0,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () => pickImage(),
                  child: const Center(
                    child: Text(
                      'Edit Photo',
                      style: kTextSize15w400Blue,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text('Name', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(
                  controller: _nameController,
                  hintText: 'Name',
                ),
                const SizedBox(height: 10.0),
                const Text('Email', style: kTextSize20w400White),
                const SizedBox(height: 10.0),
                ReusableTextField(controller: _emailController, enabled: false),
                const SizedBox(height: 20.0),
                ReusableButton(
                  onTap: () => onSaveProfile(),
                  buttonTitle: 'Save',
                  buttonColor: AppColor.red,
                ),
                const SizedBox(height: 10.0),
                loginType == 0
                    ? ReusableButton(
                        onTap: () => gotoChangePassword(),
                        buttonTitle: 'Change Password',
                        buttonColor: AppColor.green,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
