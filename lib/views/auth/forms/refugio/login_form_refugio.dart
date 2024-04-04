import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/helpers/shared.dart';

class LoginFormRefugio extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final Function loginRefugio;
  const LoginFormRefugio(
      {super.key,
      required this.email,
      required this.password,
      required this.loginRefugio});

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
                buttonColor: const Color.fromARGB(255, 190, 82, 209),
                onPressed: () {
                  loginCubit.onSubmit();
                  loginRefugio(context, email.text, password.text);
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
                text: "Mandar Solicitud",
                buttonColor: Colors.purple,
                onPressed: () {
                  context.push('/RegisterRefugio');
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿No eres un refugio?'),
                TextButton(
                    onPressed: () => context.push('/login'),
                    child: const Text('Ingresa como Usuario'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
