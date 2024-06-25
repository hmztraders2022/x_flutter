import 'package:beta_x/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  LoginController loginController = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //here
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://i.pinimg.com/736x/65/3f/03/653f03fbd8d7f48ccbce8891141a2060.jpg',
            ),
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        'LOGIN',
                        style: GoogleFonts.robotoSlab(
                          textStyle: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w700,
                            backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                suffixIcon: const Icon(
                                  Icons.email,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+").hasMatch(value)) {
                                  return 'Email is not valid!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              return TextFormField(
                                controller: passwordController,
                                obscureText: loginController.showPassword.value ? false : true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: IconButton(
                                    icon: Icon(loginController.showPassword.value ? Icons.visibility : Icons.visibility_off),
                                    onPressed: () {
                                      loginController.changeShowPassword();
                                    },
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Password';
                                  }
                                  return null;
                                },
                              );
                            }),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Navigate the user to the Home page
                                  Get.to(() => const HomeView());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill input')),
                                  );
                                }
                              },
                              child: const Text('Log in'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(
//                   'https://i.pinimg.com/736x/65/3f/03/653f03fbd8d7f48ccbce8891141a2060.jpg',
//                 ),
//               ),
//             ),
//           ),
//           
//         ],
//       ),
//     );
//   }