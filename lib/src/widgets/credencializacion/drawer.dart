import 'package:flutter/material.dart';

class DrawerCredencializacion extends StatefulWidget {
  const DrawerCredencializacion({super.key});

  @override
  State<DrawerCredencializacion> createState() => _DrawerCredencializacionState();
}

class _DrawerCredencializacionState extends State<DrawerCredencializacion> {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: ListView(
      children: [
        DrawerHeader(child: Column(children: [
          Container(color: Colors.blue,)
        ],)),
        ExpansionTile(title: const Text("CONFIGURACION"),
        children: [
          ListTile(title: const Text("Perfil"),
          onTap: () {
            
          },
          ),
          ListTile(title: const Text("Cerrar sesión"),
          onTap: () {
            
          },
          )
        ],),
      ExpansionTile(
        title: const Text("ARTESANOS"),
        children: [
          
      ListTile(
        title: const Text("VER ARTESANOS"),
        onTap: () {
          
        },
      ),
      ListTile(
        title: const Text("AGREGAR NUEVO"),
        onTap: () {
          
        },
      ),
        ],
      ),
      ListTile(
        title: const Text("ORGANIZACIONES"),
        onTap: () {
          
        },
      ),
      ListTile(
        title: const Text("TALLERES FAMILIARES"),
        onTap: () {
          
        },
      ),
      ListTile(
        title: const Text("RAMAS ARTESANALES"),
        onTap: () {
          
        },
      ),
      ListTile(
        title: const Text("TECNICA ARTESANAL"),
        onTap: () {
          
        },
      )
    ],) ,);
  }
}