import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../shared/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllUser = TextEditingController();
  TextEditingController controllPass = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground( 
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox( height: 80 ),
                // Icon Banner
                const Icon( 
                  Icons.pets_rounded, 
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox( height: 80 ),
    
                Container(
                  height: size.height - 260, // 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: const _LoginForm(),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox( height: 50 ),
          Text('Login', style: textStyles.titleLarge ),
          const SizedBox( height: 90 ),

          const CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox( height: 30 ),

          const CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
          ),
    
          const SizedBox( height: 30 ),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: Colors.orange,
              onPressed: (){

              },
            )
          ),

          const Spacer( flex: 2 ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                onPressed: ()=> context.push('/register'), 
                child: const Text('Crea una aquí')
              )
            ],
          ),

          const Spacer( flex: 1),
        ],
      ),
    );
  }
}


// String mensaje = '';

  // Future<void> login() async {
  //   final response = await http.post("http://192.168.1.7/mascotas/login.php",
  //       body: {"username": controllUser.text, "password": controllPass.text});

  // var datauser = json.decode(response.body);

  // if (datauser.length == 0){
  //   setState(() {
  //     mensaje="Usuario o contraseña incorrectas";
  //   });
  // } else{
  //   if (datauser[0]['nivel']== 'usuario'){
  //     context.push('/pets');
  //   } else if (datauser[0]['nivel'] == 'refugio'){
  //     context.push('/petsRefugio');
  //   }
  //   setState(() {

  //   });
  // }
  // }