// ignore_for_file: camel_case_types, unused_import, use_build_context_synchronously, deprecated_member_use, await_only_futures

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gracesoft/core/constants/app_colors.dart';
import 'package:gracesoft/core/constants/app_data.dart';
import 'package:gracesoft/core/constants/app_icons.dart';
import 'package:gracesoft/core/constants/app_text_styles.dart';
import 'package:gracesoft/core/constants/url_constant.dart';
import 'package:gracesoft/route/app_pages.dart';
import 'package:gracesoft/route/custom_navigator.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

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
  bool _isLoading = false;
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
                      'Don\'t have an account ? ',
                      style: AppTextStyles.textStyles_Puritan_30_400_Secondary
                          .copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey),
                    ),
                    const SizedBox(height: 15),
                    _buildSignUpButton(),
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
                return 'Short Name is required.';
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
              if (value == null || value.trim().isEmpty) {
                return 'Login Name is Required.';
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
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.5)),
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
              if (value == null || value.trim().isEmpty) {
                return 'Password is required.';
              }
              return null;
            },
          )
        ],
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
          child: _isLoading
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

  _buildSignUpButton() => GestureDetector(
        onTap: () {
         launchUrl(url: "https://www.gracesoft.com/freetrial");
        },
        child: Container(
          height: 50,
          width: 160,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 3, color: AppColors.primary),
          ),
          child: const Center(
              child: Text(
            'Sign Up',
            style: TextStyle(
                fontWeight: FontWeight.w700, color: AppColors.primary),
          )),
        ),
      );

  void _showErrorSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        duration: Duration(seconds: 3), // Adjust the duration as needed
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      validateLogin();
    }
  }

   Future<void> launchUrl({
    required String url,
  
  }) async {
    try {
      await url_launcher.launchUrl(
        Uri.parse(url),
        mode: url_launcher.LaunchMode.externalNonBrowserApplication,
      );
    } catch (e) {
      _showErrorSnackbar(context , e.toString());
    }
  }

  Future<void> validateLogin() async {
    setState(() {
      _isLoading = true;
    });

    final dio = Dio();

    final requestBody = {
      "ShortName": propertyShortNameController.text.toString(),
      "UserName": nameController.text.toString(),
      "Password": passwordController.text.toString(),
    };

    try {
      final response = await dio.post(LOGIN_API, data: requestBody);
  

      if (response.statusCode == 200)  {

        if (response.data['details'] == "Success") {
          String dateTime  = DateTime.now().toString();
          AppData.setTokenAndPropertyID(response.data['accessToken'],int.parse(response.data['propertyId']) , dateTime);
          // AppData.accessToken = response.data['accessToken'];
          // AppData.propertyId = int.parse(response.data['propertyId']);
          saveStatus();

          
        } else {
          _showErrorSnackbar(
              context, "Something wrong with details you entered !");
               setState(() {
          _isLoading = false;
        });
        }
      } else {

        _showErrorSnackbar(context, "Something went wrong ! Please try again.");
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
   

      _showErrorSnackbar(context, error.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> saveStatus()async{
    SharedPreferences user = await SharedPreferences.getInstance();
    user.setBool("isLogin", true);

    print("status saved==============");
    CustomNavigator.pushReplace(context, AppPages.navigationBar);

           setState(() {
          _isLoading = false;
        });
  }
}
