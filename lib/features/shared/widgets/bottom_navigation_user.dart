import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationUser extends StatefulWidget {
  const BottomNavigationUser({super.key});

  @override
  State<BottomNavigationUser> createState() => _BottomNavigationUserState();
}

class _BottomNavigationUserState extends State<BottomNavigationUser> {
  int paginaActual = 0;
  

  List paginas = ['/pets', '/lost'];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) {
          setState(() {
            paginaActual = index;
            context.push(paginas[paginaActual]);
          });
        },
        currentIndex: paginaActual,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.pets_outlined), label: 'Adopta'),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark_outlined), label: 'Perdidos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'Encontrados'),
          BottomNavigationBarItem(
              icon: Icon(Icons.house_outlined), label: 'Refugios'),
        ]);
  }
}
