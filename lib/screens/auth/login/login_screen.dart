import 'package:banking_app/blocs/auth/auth_bloc.dart';
import 'package:banking_app/blocs/auth/auth_event.dart';
import 'package:banking_app/blocs/auth/auth_state.dart';
import 'package:banking_app/screens/auth/register/register_screen.dart';
import 'package:banking_app/screens/auth/widgets/password_text_input.dart';
import 'package:banking_app/screens/auth/widgets/universal_text_input.dart';
import 'package:banking_app/screens/tab_box/tab_screen.dart';
import 'package:banking_app/utils/app_colors.dart';
import 'package:banking_app/utils/app_constants.dart';
import 'package:banking_app/utils/app_images.dart';
import 'package:banking_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isChecked = false;

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.black,
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthErrorState) {
              return Center(
                child: Text(state.errorText),
              );
            }
            if (state is AuthInitialState) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 44.w),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // 60.getH(),
                              Image.asset(
                                AppImages.registerImage,
                                height: 250.h,
                                width: 225.w,
                                fit: BoxFit.cover,
                              ),
                              16.getH(),
                              Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 22.w,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              16.getH(),
                              UniversalTextInput(
                                controller: emailController,
                                hintText: "Email",
                                type: TextInputType.text,
                                regExp: AppConstants.emailRegExp,
                                errorTitle: 'Email error',
                                iconPath: AppImages.email,
                              ),
                              16.getH(),
                              PasswordTextInput(
                                controller: passwordController,
                              ),
                              35.getH(),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 18.h,
                                    horizontal: 80.w,
                                  ),
                                  backgroundColor: AppColors.c_262626,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  context.read<AuthBloc>().add(
                                        AuthLoginEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                },
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: TextStyle(
                          color: AppColors.white.withOpacity(.8),
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const RegisterScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.w,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  30.getH(),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          listener: (BuildContext context, AuthState state) {
            if (state is AuthSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TabScreen(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
