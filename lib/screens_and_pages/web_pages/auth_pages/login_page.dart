import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_nu_thon_6/apis/auth_apis/auth_apis.dart';
import 'package:hack_nu_thon_6/provider/router_provider.dart';
import 'package:hack_nu_thon_6/utils/helper_functions/web_toast.dart';
import 'package:hack_nu_thon_6/utils/logo.dart';
import 'package:hack_nu_thon_6/utils/theme/theme.dart';
import 'package:hack_nu_thon_6/utils/widgets/buttons/custom_button.dart';
import 'package:hack_nu_thon_6/utils/widgets/text_feild/custom_text_feild.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const route = "/login";
  static const fullRoute = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isRegisterHovered = false;
  bool obscure = true;

  bool _isLoading = false;

  bool isValid = true;

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> loginUser() async {
    try {
      await AuthApi.signIn(
        context,
        _emailController.text,
        _passwordController.text,
      );
    } catch (error) {
      WebToasts.showToastification(
          "Error",
          "Something went wrong",
          Icon(Icons.error, color: Colors.red),
          context);
      // print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouterProvider>(builder: (context, bucketProvider, child) {
      return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.theme['backgroundColor'],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0, top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In to",
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
                    "If you don't have an account",
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
                              setState(() => _isRegisterHovered = true),
                          onExit: (_) =>
                              setState(() => _isRegisterHovered = false),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.go('/register');
                                  bucketProvider.isLoginEnabled = false;
                                },
                                child: Text(
                                  "Register here!",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: !_isRegisterHovered
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
                                  width: (_isRegisterHovered) ? 100.0 : 0.0,
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
            Expanded(child: Image.asset("assets/ils/login_ills.png",height: 450,width: 450,)),

            Padding(
              padding: const EdgeInsets.only(right: 60,bottom: 60),
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:AppColors.theme['backgroundColor'],
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("L O G I N",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: AppColors.theme['primaryColor']),),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          width: 300,
                          child: CustomTextFeild(
                            hintText: "Enter email",
                            isNumber: false,
                            controller: _emailController,
                            prefixicon: Icon(Icons.mail_outline_outlined),
                            obsecuretext: false,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 50,
                          width: 300,
                          child: CustomTextFeild(
                            hintText: "Enter password",
                            isNumber: false,
                            prefixicon: Icon(Icons.password_outlined),
                            obsecuretext: obscure,
                            controller: _passwordController,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: Icon(
                                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: CupertinoColors.systemGrey2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
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
                          child: CustomButton(
                            isLoading: _isLoading,
                            loadWidth: 150,
                            height: 45,
                            width: 300,
                            textColor: Colors.white,
                            bgColor: AppColors.theme['primaryColor'],
                            onTap: () async {
                              if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                                isValid = false;
                                setState(() {
                                  _isLoading = false;
                                });

                                WebToasts.showToastification(
                                  "Error",
                                  "All details are required",
                                  Icon(Icons.error, color: Colors.red),
                                  context,
                                );
                                return;
                              }

                              isValid = true;
                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                await loginUser();
                              } catch (e) {
                                WebToasts.showToastification(
                                  "Error",
                                  "Login failed: ${e.toString()}",
                                  Icon(Icons.error, color: Colors.red),
                                  context,
                                );
                              }

                              setState(() {
                                _isLoading = false;
                              });
                            },
                            title: 'Sign In',
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      );
    });
  }
}