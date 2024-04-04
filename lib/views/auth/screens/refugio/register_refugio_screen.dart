import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/controllers/register/register_controller_refugio.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/views/auth/forms/forms.dart';

class RegisterRefugioScreen extends StatefulWidget {
  const RegisterRefugioScreen({super.key});

  @override
  State<RegisterRefugioScreen> createState() => _RegisterRefugioScreenState();
}

class _RegisterRefugioScreenState extends State<RegisterRefugioScreen> {
  late TextEditingController usernameRefugio = TextEditingController();
  late TextEditingController emailRefugio = TextEditingController();
  late TextEditingController passwordRefugio = TextEditingController();
  late TextEditingController telefonoRefugio = TextEditingController();
  late TextEditingController descriptionRefugio = TextEditingController();
  late TextEditingController misionRefugio = TextEditingController();
  late TextEditingController ciudadRefugio = TextEditingController();
  late TextEditingController barrioRefugio = TextEditingController();
  late TextEditingController direccionRefugio = TextEditingController();
  late RegisterRefugioController registerRefugioController = RegisterRefugioController(
      usernameController: usernameRefugio,
      emailController: emailRefugio,
      passwordController: passwordRefugio,
      telefonoController: telefonoRefugio,
      descripcionController: descriptionRefugio,
      misionController: misionRefugio,
      ciudadController: ciudadRefugio,
      barrioController: barrioRefugio,
      direccionController: direccionRefugio
      );

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

                          child: RegisterFormRefugio(
                            username: usernameRefugio,
                            email: emailRefugio,
                            password: passwordRefugio,
                            telefono: telefonoRefugio,
                            description: descriptionRefugio,
                            mision: misionRefugio,
                            ciudad: ciudadRefugio,
                            barrio: barrioRefugio,
                            direccion: direccionRefugio,
                            registarRefugio: registerRefugioController.registerRefugio,
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}


