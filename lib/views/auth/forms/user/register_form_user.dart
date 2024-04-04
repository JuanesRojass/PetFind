import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/helpers/shared.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passController;
  final TextEditingController emailController;
  final Function insertRecord;

  const RegisterForm({
    super.key, required this.userController,
    required this.passController,
    required this.emailController,
    required this.insertRecord
    });
  

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    final loginCubit = context.watch<LoginCubit>();
    final usernameCubit = loginCubit.state.username;
    final emailCubit = loginCubit.state.email;
    final passwordCubit = loginCubit.state.password;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text('Nueva cuenta', style: textStyles.titleMedium),
          const SizedBox(height: 50),
          CustomTextFormField(
            label: 'Nombre de Usuario',
            keyboardType: TextInputType.emailAddress,
            controller: userController,
            onChanged: loginCubit.usernameChanged,
            errorMessage: usernameCubit.errorMessage,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onChanged: loginCubit.emailChanged,
            errorMessage: emailCubit.errorMessage,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            controller: passController,
            onChanged: loginCubit.passwordChanged,
            errorMessage: passwordCubit.errorMessage,
          ),
          const SizedBox(height: 30),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Crear Cuenta',
                buttonColor: Colors.orange,
                onPressed: () {
                  insertRecord(context, userController.text, emailController.text, passController.text);
                  loginCubit.onSubmit();
                },
              )),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                  onPressed: () {
                    if (context.canPop()) {
                      return context.pop();
                    }
                    context.push('/login');
                  },
                  child: const Text('Ingresa aquí'))
            ],
          ),
        ],
      ),
    );
  }
}