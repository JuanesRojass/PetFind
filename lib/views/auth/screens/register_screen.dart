import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';

import '../../../helpers/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController controllUser = TextEditingController();
  TextEditingController controllEmail = TextEditingController();
  TextEditingController controllPass = TextEditingController();

  Future<void> insertrecord() async {
    if (controllUser.text != "" ||
        controllPass.text != "" ||
        controllEmail.text != "") {
      try {
        String uri = "http://$ipConnect/mascotas/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "username": controllUser.text,
          "password": controllPass.text,
          "rol": 'usuario',
          "email": controllEmail.text,
        });

        var response = jsonDecode(res.body);

        if (response["success"] == "true") {
          print("Record Inserted");
          controllUser.clear();
          controllEmail.clear();
          controllPass.clear();
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
          body: BlocProvider(
              create: (context) => LoginCubit(),
              child: GeometricalBackground(
                color: Colors.orange,
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
                            style: textStyles.titleLarge
                                ?.copyWith(color: Colors.white)),
                        const Spacer(flex: 2),
                      ],
                    ),

                    const SizedBox(height: 50),

                    Container(
                      height: size.height -
                          260, // 80 los dos sizebox y 100 el ícono
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100)),
                      ),
                      child: _RegisterForm(
                        userController: controllUser,
                        passController: controllPass,
                        emailController: controllEmail,
                        insertRecord: insertrecord,
                      ),
                    )
                  ],
                ),
              ))),
        ));
  }
}

class _RegisterForm extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passController;
  final TextEditingController emailController;
  final Function insertRecord;
  const _RegisterForm(
      {required this.userController,
      required this.passController,
      required this.emailController,
      required this.insertRecord});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    final loginCubit = context.watch<LoginCubit>();
    final usernameCubit = loginCubit.state.username;
    final emailCubit = loginCubit.state.email;
    final passwordCubit = loginCubit.state.password;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text('Nueva cuenta', style: textStyles.titleMedium),
          const SizedBox(height: 50),
          CustomTextFormField(
            label: 'Nombre de Usuario',
            keyboardType: TextInputType.emailAddress,
            controller: userController,
            onChanged: loginCubit.usernameChanged,
            errorMessage: usernameCubit.errorMessage,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onChanged: loginCubit.emailChanged,
            errorMessage: emailCubit.errorMessage,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            controller: passController,
            onChanged: loginCubit.passwordChanged,
            errorMessage: passwordCubit.errorMessage,
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
                buttonColor: Colors.orange,
                onPressed: () {
                  insertRecord();
                  loginCubit.onSubmit();
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
    );
  }
}
