import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../shared/widgets/widgets.dart';

class RegisterScreenTest extends StatefulWidget {
  const RegisterScreenTest({super.key});

  @override
  State<RegisterScreenTest> createState() => _RegisterScreenTestState();
}

class _RegisterScreenTestState extends State<RegisterScreenTest> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rol = TextEditingController();

  Future<void> insertrecord() async {
    if (username != "" || password != "" || rol != "" || email != "") {
      try {
        String uri = "http://192.168.1.7/mascotas/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "username": username.text,
          "password": password.text,
          "rol": rol.text,
          "email": email.text,
        });

               
        var response = jsonDecode(res.body);
        
        
        if (response["success"] == "true") 
        {
          print("Record Inserted");
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("please Fill All fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: GeometricalBackground(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // Icon Banner
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (!context.canPop()) return;
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded,
                        size: 40, color: Colors.white)),
                const Spacer(flex: 1),
                Text('Crear cuenta',
                    style:
                        textStyles.titleLarge?.copyWith(color: Colors.white)),
                const Spacer(flex: 2),
              ],
            ),

            const SizedBox(height: 50),

            Container(
              height: size.height - 100, // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text('Nueva cuenta', style: textStyles.titleMedium),
                    const SizedBox(height: 50),
                    CustomTextFormField(
                      label: 'Nombre completo',
                      keyboardType: TextInputType.emailAddress,
                      controller: username,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      label: 'Correo',
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      label: 'Contraseña',
                      obscureText: true,
                      controller: password,
                    ),

                    const SizedBox(height: 30),
                    CustomTextFormField(
                      label: 'Rol',
                      obscureText: false,
                      controller: rol,
                    ),
                    // const SizedBox(height: 30),
                    // CustomTextFormField(
                    //   label: 'Repita la contraseña',
                    //   obscureText: true,
                    //   controller: passController,
                    // ),
                    const SizedBox(height: 30),
                    SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: CustomFilledButton(
                          text: 'Crear',
                          buttonColor: Colors.red,
                          onPressed: () {
                            insertrecord();
                          },
                        )),
                    const Spacer(flex: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿Ya tienes cuenta?'),
                        TextButton(
                            onPressed: () {
                              if (context.canPop()) {
                                return context.pop();
                              }
                              context.go('/login');
                            },
                            child: const Text('Ingresa aquí'))
                      ],
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            )
          ],
        ),
      ))),
    );
  }
}
