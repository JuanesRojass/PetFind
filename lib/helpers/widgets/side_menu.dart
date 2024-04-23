import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/sideMenu/side_menu_user_controller.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  final SideMenuUserController _controller = SideMenuUserController();
  List<Map<String, dynamic>> datauser = [];
  int navDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final idCliente = ref.watch(idClienteProvider);
    final idClienteInt = int.parse(idCliente);
    cargarUser(idClienteInt);
  }

  Future<void> cargarUser(int idRefugio) async {
    final dataUser = await _controller.getUser(idRefugio);
    setState(() {
      datauser = dataUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final dataClienteJson = ref.watch(dataUserProvider);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    final username =
        datauser.isNotEmpty ? datauser[0]["username"] : "Usuario no encontrado";

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
            child: Text('$username', style: textStyles.titleSmall),
          ),
          NavigationDrawerDestination(
            icon: InkWell(
                onTap: () {
                  context.push('/editCliente', extra: datauser[0]);
                },
                child: const Icon(Icons.edit)),
            label: InkWell(
                onTap: () {
                  context.push('/editCliente', extra: datauser[0]);
                },
                child: const Text('Editar Mis Datos')),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Mis Publicaciones'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                buttonColor: Colors.orange,
                onPressed: () {
                  context.push("/publicacionesLostUser");
                },
                text: 'Mis Mascotas Perdidas'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                buttonColor: Colors.orange,
                onPressed: () {
                  context.push("/publicacionesStreetUser");
                },
                text: 'Mascotas En Calle Publicadas', styleText: const TextStyle(fontSize: 15, ),),
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
                text: 'Cerrar sesión'),
          ),
        ]);
  }
}
