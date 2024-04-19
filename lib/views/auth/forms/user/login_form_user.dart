import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';
import 'package:mascotas_bga/helpers/shared.dart';

class LoginForm extends ConsumerWidget {
  final TextEditingController email;
  final TextEditingController password;
  final Function controllerLogin;

  const LoginForm(
      {super.key,
      required this.email,
      required this.password,
      required this.controllerLogin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              label: 'Correo Electrónico',
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
                  controllerLogin(context, ref, email.text, password.text);
                  loginCubit.onSubmit();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 180,
              height: 50,
              child: CustomFilledButton(
                text: "Soy Un Refugio",
                buttonColor: Colors.purple,
                onPressed: () {
                  context.push('/loginRefugio');
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      ref.read(rolProvider.notifier).state = "Invitado";
                      context.go('/pets');
                      email.clear();
                      password.clear();
                    },
                    child: const Text('Ingresar Como Invitado'))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿No tienes cuenta?'),
                TextButton(
                    onPressed: () {
                      context.push('/register');
                      email.clear();
                      password.clear();
                    },
                    child: const Text('Crea una aquí'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
