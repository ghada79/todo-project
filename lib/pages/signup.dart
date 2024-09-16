import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/models/user_model.dart';
import 'package:todoapp/utils/firbase_utils.dart';
import 'package:todoapp/widgets/custom_btn.dart';
import 'package:todoapp/widgets/custom_text_filed.dart';
import '../providers/select_theme.dart';
import '../providers/user_provider.dart';
import '../style/app_colors.dart';
import '../style/theme_app.dart';
import 'home_screen.dart';

class Signup extends StatelessWidget {
  static const String routeName = 'Signup';
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<SelectTheme>(context);
    var scaffoldColor = themeProvider.isDarkMode()
        ? AppColors.backgroundDarkColor
        : AppColors.backgroundColor;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: themeProvider .isDarkMode() ?
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
                child: Text(
                  AppLocalizations.of(context)!.signup,
                  style: ThemeApp.darkTheme.textTheme.titleMedium
                      ?.copyWith(fontSize: 32),
                )),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.email,
                      style: ThemeApp.darkTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    CustomTextFiled(
                        hintStyle: ThemeApp.darkTheme.textTheme.titleMedium!.copyWith(color: AppColors.blackColor.withOpacity(0.2)),
                        keyboardType: TextInputType.text,
                        suffixIcon: Icon(Icons.email),
                        hintText: AppLocalizations.of(context)!.hint_enter_Email,
                        validator: (checkEmail) {
                          if (checkEmail == null || checkEmail.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_massage_email;
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(checkEmail);
                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .hint_enter_valid_Email;
                          }

                          return null;
                        },
                        controller: emailController,
                        obscureText: false),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.password,
                      style: ThemeApp.darkTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    CustomTextFiled(
                        hintStyle: ThemeApp.darkTheme.textTheme.titleMedium!.copyWith(color: AppColors.blackColor.withOpacity(0.2)),
                        keyboardType: TextInputType.number,
                        suffixIcon: Icon(Icons.remove_red_eye_sharp),
                        hintText: AppLocalizations.of(context)!.hint_password,
                        validator: (checkPassword) {
                          if (checkPassword == null || checkPassword.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_massage_password;
                          } else if (checkPassword.length < 8) {
                            return AppLocalizations.of(context)!
                                .your_password_less_8;
                          }
                        } ,
                        controller: password,
                        obscureText: true),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.confirm_password,
                      style: ThemeApp.darkTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    CustomTextFiled(
                        hintStyle: ThemeApp.darkTheme.textTheme.titleMedium!.copyWith(color: AppColors.blackColor.withOpacity(0.2)),
                        keyboardType: TextInputType.number,
                        suffixIcon: Icon(Icons.remove_red_eye_sharp),
                        hintText: AppLocalizations.of(context)!.confirm_password,
                        validator: (confirmPassword) {
                          if (confirmPassword == null || confirmPassword.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_massage_Confirm_password;
                          } else if (confirmPassword != password.text) {
                            return AppLocalizations.of(context)!
                                .your_password_match;
                          }
                          return null;
                        },
                        controller: confirmPassword,
                        obscureText: true
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    CustomBtn(
                      titleBtn: AppLocalizations.of(context)!.signup,
                      onTap: () {
                        createAccount(context);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        )
            :
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
                child: Text(
              AppLocalizations.of(context)!.signup,
              style: ThemeApp.lightTheme.textTheme.titleMedium
                  ?.copyWith(fontSize: 32),
            )),
            Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.email,
                      style: ThemeApp.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    CustomTextFiled(
                        keyboardType: TextInputType.text,
                        suffixIcon: Icon(Icons.email),
                        hintText: AppLocalizations.of(context)!.hint_enter_Email,
                        validator: (checkEmail) {
                          if (checkEmail == null || checkEmail.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_massage_email;
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(checkEmail);
                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .hint_enter_valid_Email;
                          }

                          return null;
                        },
                        controller: emailController,
                        obscureText: false),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.password,
                      style: ThemeApp.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    CustomTextFiled(
                        keyboardType: TextInputType.number,
                        suffixIcon: Icon(Icons.remove_red_eye_sharp),
                        hintText: AppLocalizations.of(context)!.hint_password,
                        validator: (checkPassword) {
                          if (checkPassword == null || checkPassword.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_massage_password;
                          } else if (checkPassword.length < 8) {
                            return AppLocalizations.of(context)!
                                .your_password_less_8;
                          }
                        } ,
                        controller: password,
                        obscureText: true),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.confirm_password,
                      style: ThemeApp.lightTheme.textTheme.titleMedium,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    CustomTextFiled(
                        keyboardType: TextInputType.number,
                        suffixIcon: Icon(Icons.remove_red_eye_sharp),
                        hintText: AppLocalizations.of(context)!.confirm_password,
                        validator: (confirmPassword) {
                          if (confirmPassword == null || confirmPassword.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_massage_Confirm_password;
                          } else if (confirmPassword != password.text) {
                            return AppLocalizations.of(context)!
                                .your_password_match;
                          }
                          return null;
                        },
                        controller: confirmPassword,
                        obscureText: true
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                    CustomBtn(
                      titleBtn: AppLocalizations.of(context)!.signup,
                      onTap: () {
                        createAccount(context);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> createAccount(context) async {
    if(formkey.currentState!.validate()){
      FirebaseUtils.signUpAccount(emailController.text, password.text);
      Myuser myUser = Myuser(email: emailController.text, id: FirebaseAuth.instance.currentUser?.uid ?? '');
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(myUser);
      await FirebaseUtils.addUserToFireStore(myUser);

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}

