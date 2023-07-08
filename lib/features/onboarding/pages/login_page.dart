// ignore_for_file: camel_case_types, unused_import

import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_icons.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusScopeNode _focusScopeNode = FocusScopeNode();
  final _formKey = GlobalKey<FormState>();

  //========================EDITING CONTROLLERS =========================
  final TextEditingController propertyShortNameController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showPassword = false;
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_focusScopeNode.hasFocus) {
          _focusScopeNode.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.primary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  // _buildHeader() => Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "Login",
  //             style: AppTextStyles.textStyles_PTSans_16_400_Secondary.copyWith(
  //                 fontSize: 30,
  //                 color: AppColors.white,
  //                 fontWeight: FontWeight.w700),
  //           ),
  //           Text(
  //             "Welcome Back",
  //             style: AppTextStyles.textStyles_PlusJakartaSans_30_700_Primary
  //                 .copyWith(
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.w400,
  //                     color: AppColors.white),
  //           ),
  //         ],
  //       ),
  //     );

  _buildHeader() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  height: 55,
                  width: 210,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(AppIcons.app_icon)),
            ),
            const SizedBox(height: 20),
            Text(
              'Property Management Software',
              style: AppTextStyles.textStyles_PlusJakartaSans_30_700_Primary
                  .copyWith(fontSize: 18, color: Colors.orange),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );

  _buildBody() => Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      'Welcome Back !',
                      style: AppTextStyles.textStyles_Puritan_30_400_Secondary
                          .copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    _buildForm(),
                    const SizedBox(height: 20),
                    _buildForgotPassword(),
                    const SizedBox(height: 30),
                    _buildLoginButton(),
                    const SizedBox(height: 20),
                    const SizedBox(
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Login With ? ',
                      style: AppTextStyles.textStyles_Puritan_30_400_Secondary
                          .copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary),
                    ),
                    const SizedBox(height: 15),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _buildForm() => Column(
        children: <Widget>[
          TextFormField(
            controller: propertyShortNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              focusColor: AppColors.primary,
              hintText: 'Property Short Name',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Property Name is required.';
              }
              return null;
            },
            keyboardType: TextInputType.name,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: nameController,
            // textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Name',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) {
              // Validators.name(value);
              if (value == null || value.trim().isEmpty) {
                return 'Name is Required.';
              }
              return null;
            },
            keyboardType: TextInputType.name,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              hintText: 'Password',
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
              ),
            ),
            validator: (value) {
              // Validators.password(value);
              if (value == null || value.trim().isEmpty) {
                return 'Password is required.';
              }
              return null;
            },
          )
        ],
      );

  _buildForgotPassword() => const Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.grey),
      );

  _buildLoginButton() => GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            _login();
          }
        },
        child: Container(
          height: 50,
          width: 160,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.primary),
          child: _isloading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              : const Center(
                  child: Text(
                  'Login',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                )),
        ),
      );

  _buildFooter() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 40, width: 40, child: Image.asset(AppIcons.google_icon))
        ],
      );

  void _login() {
    // setState(() {
    //   _isloading = true;
    // });
    // Timer(const Duration(seconds: 3), () {
    //   Get.off(const BottomNavigationBarWidget());
    // });
    if (_formKey.currentState!.validate()) {
      CustomNavigator.pushReplace(context, AppPages.navigationBar);
    }
  }
}
