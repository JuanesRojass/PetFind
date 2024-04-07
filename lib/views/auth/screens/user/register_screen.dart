import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/controllers/register/register_controller.dart';
import 'package:mascotas_bga/views/auth/forms/forms.dart';
import '../../../../helpers/widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _controllUser = TextEditingController();
  final TextEditingController _controllEmail = TextEditingController();
  final TextEditingController _controllPass = TextEditingController();
  final TextEditingController _controllTelefono = TextEditingController();
  final RegisterController _registerController = RegisterController();

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
                          height: size.height - 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(100)),
                          ),
                          child: RegisterForm(
                            userController: _controllUser,
                            passController: _controllPass,
                            emailController: _controllEmail,
                            telefonoController: _controllTelefono,
                            insertRecord: _registerController.register,
                          ),
                        )
                      ],
                    ),
                  ))),
        ));
  }
}


