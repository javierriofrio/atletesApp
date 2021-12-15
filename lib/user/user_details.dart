import 'package:atletes_sport_app/header_appbar.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/user/model/user.dart';


class UserDetails extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _UserDetails createState() => _UserDetails();
}

class _UserDetails extends State<UserDetails> {
  User perfil = User();
  late TextEditingController nombres;
  late TextEditingController apellidos;
  late TextEditingController ciudad;
  late TextEditingController descripcion;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Usuario'),
            centerTitle: true,
          ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nombres',
                ),
                controller: nombres,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Apellidos',
                ),
                controller: apellidos,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Ciudad',
                ),
                controller: ciudad,
              ),
            ),
            DropdownButton(
              items: [],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Breve descripción',
                ),
                maxLines: 8,
                controller: descripcion,
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Guardar'),
                onPressed: () {
                },
              ),
            )
          ],
        ),
      ),
    ));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombres = TextEditingController();
    apellidos = TextEditingController();
    ciudad = TextEditingController();
    descripcion = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nombres.dispose();
    apellidos.dispose();
    ciudad.dispose();
    descripcion.dispose();
  }
}
