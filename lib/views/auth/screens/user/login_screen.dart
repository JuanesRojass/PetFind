import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/controllers/auth/login_controller_user.dart';
import 'package:mascotas_bga/views/auth/forms/forms.dart';
import '../../../../helpers/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginController controller = LoginController();

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

                          child: LoginForm(
                            email: email,
                            password: password,
                            controllerLogin: controller.login,
                          ),
                        )
                      ],
                    ),
                  )
                )  
              ),
          )
      );
    }
}
