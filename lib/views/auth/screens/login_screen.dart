import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';

import '../../../helpers/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String mensaje = '';

  Future<void> login() async {
    String uri = "http://$ipConnect/mascotas/login.php";
    var res = await http.post(Uri.parse(uri),
        body: {"email": email.text, "password": password.text});

    var datauser = jsonDecode(res.body);

    if (datauser.length == 0) {
      setState(() {
        mensaje = "Correo o Contraseña incorrectas";
      });
    } else {
      if (datauser[0]['rol'] == 'cliente') {
        context.push('/pets');
        email.clear();
        password.clear();
      } else if (datauser[0]['rol'] == 'administrador') {
        context.push('/petsRefugio');
        email.clear();
        password.clear();
      }
      setState(() {
        // username = datauser[0]['username'];
      });
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
                color: Colors.orange,
                  child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    // Icon Banner
                    const Icon(
                      Icons.pets_rounded,
                      color: Colors.white,
                      size: 100,
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
                        email: email,
                        password: password,
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
                buttonColor: Colors.orange,
                onPressed: () {
                  login();
                  loginCubit.onSubmit();
                },
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 180,
              height: 50,
              child: CustomFilledButton(
                text: "Eres un Refugio?",
                buttonColor: Colors.purple,
                onPressed: () {
                  context.go('/loginRefugio');
                },
              ),
            ),
            const SizedBox(height: 30,),  
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿No tienes cuenta?'),
                TextButton(
                    onPressed: () => context.push('/register'),
                    child: const Text('Crea una aquí'))
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
