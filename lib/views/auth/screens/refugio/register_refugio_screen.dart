import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs/inputs.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/helpers/shared.dart';

class RegisterRefugioScreen extends StatefulWidget {
  const RegisterRefugioScreen({super.key});

  @override
  State<RegisterRefugioScreen> createState() => _RegisterRefugioScreenState();
}

class _RegisterRefugioScreenState extends State<RegisterRefugioScreen> {
  TextEditingController usernameRefugio = TextEditingController();
  TextEditingController emailRefugio = TextEditingController();
  TextEditingController passwordRefugio = TextEditingController();
  TextEditingController telefonoRefugio = TextEditingController();
  TextEditingController descriptionRefugio = TextEditingController();
  TextEditingController misionRefugio = TextEditingController();
  TextEditingController ciudadRefugio = TextEditingController();
  TextEditingController barrioRefugio = TextEditingController();
  TextEditingController direccionRefugio = TextEditingController();

  String mensaje = '';

  Future<void> registrarRefugio(WidgetRef ref) async {
    

    String uri = "http://$ipConnect/mascotas/insert_refugio.php";
    var res = await http.post(Uri.parse(uri), body: {
      "nombre_refugio": usernameRefugio.text,
      "email_refugio": emailRefugio.text,
      "password_refugio": passwordRefugio.text,
      "telefono_refugio": telefonoRefugio.text,
      "desc_refugio": descriptionRefugio.text,
      "mision_refugio": misionRefugio.text,
      "ciudad_refugio": ref.watch(idCiudadProvider),
      "barrio_refugio": ref.watch(idBarrioProvider),
      "direccion_refugio": direccionRefugio.text,
      "estado_refugio": '2',
    });

     if(usernameRefugio.text.isEmpty ||
      emailRefugio.text.isEmpty ||
      passwordRefugio.text.isEmpty ||
      telefonoRefugio.text.isEmpty ||
      descriptionRefugio.text.isEmpty ||
      misionRefugio.text.isEmpty ||
      ciudadRefugio.text.isEmpty ||
      barrioRefugio.text.isEmpty ||
      direccionRefugio.text.isEmpty){
    
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Datos Incorrectos'),
            content: const Text(
                "Ha habido un error en el envio de datos en la solicitud, revisa si no te falto algún campo por llenar o si ingresaste bien los datos en el lado correcto"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
        
      ); 
      return;
    }

    var response = jsonDecode(res.body);
    // var datauser = jsonDecode(res.body);

    if (response['success']) {
      print(response['message']);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Solicitud Enviada'),
            content: const Text(
                'Tu Solicitud ha sido enviada, la revisión puede tardar un tiempo, en el correo registrado llegará el aviso de el estado de tu cuenta al ser revisada por Nosotros, Gracias.".'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  usernameRefugio.clear();
                  emailRefugio.clear();
                  passwordRefugio.clear();
                  telefonoRefugio.clear();
                  descriptionRefugio.clear();
                  misionRefugio.clear();
                  ciudadRefugio.clear();
                  barrioRefugio.clear();
                  direccionRefugio.clear();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } // "Insertado con éxito en ambas tablas"
    // Manejar éxito
   
    // emailRefugio.clear();
    // passwordRefugio.clear();
    // ciudadRefugio.clear();
    // barrioRefugio.clear();
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
                        const SizedBox(height: 50),

                        Container(
                          height: size.height +
                              400, // 80 los dos sizebox y 100 el ícono
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100)),
                          ),

                          child: _LoginForm(
                            username: usernameRefugio,
                            email: emailRefugio,
                            password: passwordRefugio,
                            telefono: telefonoRefugio,
                            description: descriptionRefugio,
                            mision: misionRefugio,
                            ciudad: ciudadRefugio,
                            barrio: barrioRefugio,
                            direccion: direccionRefugio,
                            registarRefugio: registrarRefugio,
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}

class _LoginForm extends ConsumerWidget {
  final TextEditingController username;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController telefono;
  final TextEditingController description;
  final TextEditingController mision;
  final TextEditingController ciudad;
  final TextEditingController barrio;
  final TextEditingController direccion;

  final Function registarRefugio;
  const _LoginForm({
    required this.email,
    required this.password,
    required this.registarRefugio,
    required this.username,
    required this.description,
    required this.mision,
    required this.telefono,
    required this.direccion,
    required this.ciudad,
    required this.barrio,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginCubit = context.watch<LoginCubit>();
    final usernameCubit = loginCubit.state.username;
    final emailCubit = loginCubit.state.email;
    final passwordCubit = loginCubit.state.password;
    final telefonoCubit = loginCubit.state.telefono;
    final descriptionCubit = loginCubit.state.description;
    final misionCubit = loginCubit.state.mision;

    final textStyles = Theme.of(context).textTheme;
    // final fieldText = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text('Enviar Solicitud', style: textStyles.titleMedium),
            const SizedBox(height: 40),
            CustomTextFormField(
              label: 'Nombre Refugio',
              keyboardType: TextInputType.text,
              controller: username,
              onChanged: loginCubit.usernameChanged,
              errorMessage: usernameCubit.errorMessage,
            ),
            const SizedBox(height: 30),
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
            CustomTextFormField(
                label: 'Telefono Refugio',
                keyboardType: TextInputType.number,
                controller: telefono,
                onChanged: loginCubit.telefonoChanged,
                errorMessage: telefonoCubit.errorMessage),
            const SizedBox(height: 30),
            CustomTextFormField(
              label: 'Descripción Refugio',
              keyboardType: TextInputType.text,
              controller: description,
              onChanged: loginCubit.descriptionChanged,
              errorMessage: descriptionCubit.errorMessage,
            ),
            const SizedBox(height: 30),
            CustomTextFormField(
              label: 'Misión Refugio',
              keyboardType: TextInputType.text,
              controller: mision,
              onChanged: loginCubit.misionChanged,
              errorMessage: misionCubit.errorMessage,
            ),
            const SizedBox(height: 30),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: DropdownCiudades(
                  controller: ciudad,
                )),
            const SizedBox(height: 30),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: DropdownBarrios(
                  controller: barrio,
                )),
            const SizedBox(height: 30),
            CustomTextFormField(
              label: 'Dirección Refugio',
              keyboardType: TextInputType.text,
              controller: direccion,
              onChanged: loginCubit.descriptionChanged,
              errorMessage: descriptionCubit.errorMessage,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Enviar Solicitud',
                buttonColor: Colors.purple,
                onPressed: () {
                  registarRefugio(ref);
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



// Future<void> login() async {
//     String uri = "http://$ipConnect/mascotas/login_refugios.php";
//     var res = await http.post(Uri.parse(uri), body: {
//       "email_refugio": emailRefugio.text,
//       "password_refugio": passwordRefugio.text
//     });

//     var datauser = jsonDecode(res.body);

//     if (datauser.length == 0) {
//       setState(() {
//         mensaje = "Correo o Contraseña incorrectas";
//       });
//     } else {
//       context.go('/petsRefugio');
//       emailRefugio.clear();
//       passwordRefugio.clear();
//     }
//     return datauser;
//   }