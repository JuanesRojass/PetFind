import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/auth/blocs/all_blocs.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs.dart';
import 'package:mascotas_bga/helpers/shared.dart';

class RegisterFormRefugio extends ConsumerWidget {
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
  const RegisterFormRefugio({
    super.key, 
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
                label: 'Teléfono Refugio',
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
                  registarRefugio(context,
                    ref,
                    username.text,
                    email.text,
                    password.text,
                    telefono.text,
                    description.text,
                    mision.text,
                    ciudad.text,
                    barrio.text,
                    direccion.text,
                    );
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