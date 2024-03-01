import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/features/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/features/providers/connect_provider.dart';

import '../../shared/widgets/widgets.dart';

class LoginRefugioScreen extends StatefulWidget {
  const LoginRefugioScreen({super.key});

  @override
  State<LoginRefugioScreen> createState() => _LoginRefugioScreenState();
}

class _LoginRefugioScreenState extends State<LoginRefugioScreen> {
  TextEditingController emailRefugio = TextEditingController();
  TextEditingController passwordRefugio = TextEditingController();

  String mensaje = '';

  Future<void> login() async {
    String uri = "http://$ipConnect/mascotas/login_refugios.php";
    var res = await http.post(Uri.parse(uri), body: {
      "email_refugio": emailRefugio.text,
      "password_refugio": passwordRefugio.text
    });

    var datauser = jsonDecode(res.body);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "Correo o Contraseña incorrectas";
      });
    } else {
      context.go('/petsRefugio');
      emailRefugio.clear();
      passwordRefugio.clear();
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: BlocProvider(
              create: (context) => LoginCubit(),
              child: GeometricalBackground(
                  color: Colors.purple,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        // Icon Banner
                        const Icon(
                          Icons.house_rounded,
                          color: Colors.white,
                          size: 120,
                        ),
                        const SizedBox(height: 80),

                        Container(
                          height: size.height -
                              160, // 80 los dos sizebox y 100 el ícono
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100)),
                          ),

                          child: _LoginForm(
                            email: emailRefugio,
                            password: passwordRefugio,
                            login: login,
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final Function login;
  const _LoginForm(
      {required this.email, required this.password, required this.login});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();
    final emailCubit = loginCubit.state.email;
    final passwordCubit = loginCubit.state.password;

    final textStyles = Theme.of(context).textTheme;
    // final fieldText = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text('Iniciar Sesión', style: textStyles.titleLarge),
            const SizedBox(height: 40),
            CustomTextFormField(
              label: 'Correo',
              keyboardType: TextInputType.emailAddress,
              controller: email,
              onChanged: loginCubit.emailChanged,
              errorMessage: emailCubit.errorMessage,
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
                label: 'Contraseña',
                obscureText: true,
                controller: password,
                onChanged: loginCubit.passwordChanged,
                errorMessage: passwordCubit.errorMessage),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Ingresar',
                buttonColor: Colors.purple,
                onPressed: () {
                  login();
                  loginCubit.onSubmit();
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿No eres un Refugio?'),
                TextButton(
                    onPressed: () => context.push('/login'),
                    child: const Text('Ingresar Como Usuario'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
