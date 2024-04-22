import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/sideMenu/side_menu_refugio_controller.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SideMenuRefugio extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenuRefugio({super.key, required this.scaffoldKey});

  @override
  SideMenuRefugioState createState() => SideMenuRefugioState();
}

class SideMenuRefugioState extends ConsumerState<SideMenuRefugio> {
  final SideMenuRefugioController _controller = SideMenuRefugioController();
  List<Map<String, dynamic>> datarefugio = [];
  int navDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final idRefugio = ref.watch(idRefugioProvider);
    final idRefugioInt = int.parse(idRefugio);
    cargarUser(idRefugioInt);
  }

  Future<void> cargarUser(int idRefugio) async {
    final dataRefugio = await _controller.getRefugio(idRefugio);
    setState(() {
      datarefugio = dataRefugio;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final dataClienteJson = ref.watch(dataUserProvider);
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    final username =
        datarefugio.isNotEmpty ? datarefugio[0]["nombre_refugio"] : "Refugio no encontrado";

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
            child: Row(children: [
             Text('$username', style: textStyles.titleSmall),
             const Icon(Icons.verified_user_rounded, color: Colors.blue,)
             ]),
          ),
          NavigationDrawerDestination(
            icon: InkWell(
                onTap: () {
                  context.push('/editRefugio', extra: datarefugio[0]);
                },
                child: const Icon(Icons.edit)),
            label: InkWell(
                onTap: () {
                  context.push('/editRefugio', extra: datarefugio[0]);
                },
                child: const Text('Editar Mis Datos')),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Otras opciones'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                buttonColor: Colors.orange,
                onPressed: () {
                  context.push("/publicacionesAdpRefugio");
                },
                text: 'Mis Mascotas En Adopción'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                buttonColor: Colors.orange,
                onPressed: () {
                  context.push("/publicacionesStreetRefugio");
                },
                text: 'Mascotas En Calle Publicadas', styleText: const TextStyle(fontSize: 15, ),),
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
