import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideAdminMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideAdminMenu({super.key, required this.scaffoldKey});

  @override
  SideAdminMenuState createState() => SideAdminMenuState();
}

class SideAdminMenuState extends ConsumerState<SideAdminMenu> {
  int navDrawerIndex = 0;


  @override
  Widget build(BuildContext context) {
    // final dataClienteJson = ref.watch(dataUserProvider);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;



    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          // final menuItem = appMenuItems[value];
          // context.push( menuItem.link );
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: Text('Saludos', style: textStyles.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Flexible(child: Text('Admin', style: textStyles.titleSmall)),
          ),
          const SizedBox(height: 20,),
           const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Administrar'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                buttonColor: Colors.orange,
                onPressed: () {
                  context.push("/solicitudRefugios");
                },
                text: 'Solicitudes de Refugios'),
          ),
           const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Otras Opciones'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                buttonColor: const Color.fromARGB(255, 247, 66, 53),
                onPressed: () {
                  ref.read(nombreRazaProvider.notifier).setName("");
                  ref.read(idTipoMascotaProvider.notifier).setId("");
                  ref.read(idCiudadProvider.notifier).setId("");
                  ref.read(nombreTipoProvider.notifier).setName("");
                  context.go('/login');
                },
                text: 'Cerrar Sesión'),
          ),
        ]);
  }
}
