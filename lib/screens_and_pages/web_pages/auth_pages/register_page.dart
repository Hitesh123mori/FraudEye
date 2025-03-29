import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/main.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:hack_nu_thon_6/utils/helper_functions/web_toast.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/buttons/custom_button.dart';
import 'package:hack_nu_thon_6/utils/widgets/text_feild/custom_text_feild.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  static const route = "/register";
  static const fullRoute = "/register";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoginHovered = false;
  bool obscure1 = true;
  bool obscure2 = true;
  bool _isLoading = false;

  bool isBank = false;

  bool isValid = true;
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passConfirmController = TextEditingController();

  // Function for registering user
  Future<void> registerUser() async {
    // try {
    //   await AuthApi.signUp(
    //     context,
    //     _emailController.text,
    //     _passwordController.text,
    //     _userNameController.text,
    //   );
    // } catch (error) {
    //   WebToasts.showToastification(
    //       "Error",
    //       "Something went wrong",
    //       Icon(Icons.error, color: Colors.red),
    //       context);
    // }
  }

  // General validator
  String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Consumer<RouterProvider>(builder: (context, routerProvider, child) {
      return Form(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.theme['backgroundColor'],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up to",
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Our Application",
                      style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "If you already have an account",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "You can",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) =>
                                setState(() => _isLoginHovered = true),
                            onExit: (_) =>
                                setState(() => _isLoginHovered = false),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.go('/login');
                                    routerProvider.isLoginEnabled = true;
                                  },
                                  child: Text(
                                    "Login here!",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: !_isLoginHovered
                                          ? AppColors.theme['primaryColor']
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: 2,
                                    width: (_isLoginHovered) ? 80.0 : 0.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.theme['primaryColor'],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  "assets/ils/login_ills.png",
                  height: 450,
                  width: 450,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 10),
                child: Container(
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.theme['backgroundColor'],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                              "LOGO HERE",
                              style: GoogleFonts.poppins(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color:  AppColors.theme['primaryColor']
                              ),
                            ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                width: 300,
                                child: CustomTextFeild(
                                  controller: _userNameController,
                                  hintText: "Enter Name",
                                  isNumber: false,
                                  prefixicon: Icon(Icons.person),
                                  obsecuretext: false,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                width: 300,
                                child: CustomTextFeild(
                                  controller: _emailController,
                                  hintText: "Enter Email",
                                  isNumber: false,
                                  prefixicon: Icon(Icons.email_rounded),
                                  obsecuretext: false,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                width: 300,
                                child: CustomTextFeild(
                                  controller: _passwordController,
                                  hintText: "Enter password",
                                  isNumber: false,
                                  prefixicon: Icon(Icons.password_outlined),
                                  obsecuretext: obscure1,
                                  suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure1 = !obscure1;
                                      });
                                    },
                                    icon: Icon(
                                      obscure1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                      color: CupertinoColors.systemGrey2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                width: 300,
                                child: CustomTextFeild(
                                  hintText: "Enter confirm password",
                                  isNumber: false,
                                  controller: _passConfirmController,
                                  prefixicon: Icon(Icons.password_outlined),
                                  obsecuretext: obscure2,
                                  suffix: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure2 = !obscure2;
                                      });
                                    },
                                    icon: Icon(
                                      obscure2 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                      color: CupertinoColors.systemGrey2,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isBank,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isBank = value ?? false;
                                      });
                                    },
                                    activeColor: AppColors.theme['primaryColor'],
                                  ),
                                  Text(
                                    "Register as bank",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.theme['primaryColor'],
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: CustomButton(
                                    isLoading: _isLoading,
                                    loadWidth: 150,
                                    height: 45,
                                    width: 300,
                                    textColor: Colors.white,
                                    bgColor: AppColors.theme['primaryColor'],
                                    onTap: () async {
                                      if (_passwordController.text.isEmpty ||
                                          _userNameController.text.isEmpty ||
                                          _passConfirmController.text.isEmpty) {
                                        isValid = false;
                                        setState(() {});
                                        WebToasts.showToastification(
                                          "Error",
                                          "All details are required",
                                          Icon(Icons.error, color: Colors.red),
                                          context,
                                        );
                                      }

                                      if (!RegExp(r'^(?=.*[A-Z]).{8,}$').hasMatch(_passwordController.text)) {
                                        isValid = false;
                                        setState(() {});
                                        WebToasts.showToastification(
                                          "Error",
                                          "Password must be at least 8 characters long and contain at least one capital letter",
                                          Icon(Icons.error, color: Colors.red),
                                          context,
                                        );
                                      }

                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text)) {
                                        isValid = false;
                                        setState(() {});
                                        WebToasts.showToastification(
                                          "Error",
                                          "Email is not well formatted",
                                          Icon(Icons.error, color: Colors.red),
                                          context,
                                        );
                                      }

                                      if (_passwordController.text != _passConfirmController.text) {
                                        WebToasts.showToastification(
                                          "Error",
                                          "Password and Confirm password are not matched",
                                          Icon(Icons.error, color: Colors.red),
                                          context,
                                        );
                                      }

                                      if (isValid) {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        await registerUser();

                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    },
                                    title: 'Sign Up',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}