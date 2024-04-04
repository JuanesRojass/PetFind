import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/controllers/auth/login_controller_refugio.dart';
import 'package:mascotas_bga/views/auth/forms/forms.dart';
import '../../../../helpers/widgets/widgets.dart';

class LoginRefugioScreen extends StatefulWidget {
  const LoginRefugioScreen({super.key});

  @override
  State<LoginRefugioScreen> createState() => _LoginRefugioScreenState();
}

class _LoginRefugioScreenState extends State<LoginRefugioScreen> {
  late TextEditingController emailRefugio = TextEditingController();
  late TextEditingController passwordRefugio = TextEditingController();
  late LoginControllerRefugio controllerRefugio = LoginControllerRefugio(
    emailRefugio: emailRefugio,
    passwordRefugio: passwordRefugio
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

                          child: LoginFormRefugio(
                            email: emailRefugio,
                            password: passwordRefugio,
                            loginRefugio: controllerRefugio.login,
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}


