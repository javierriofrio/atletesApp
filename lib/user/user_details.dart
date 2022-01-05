import 'package:atletes_sport_app/services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:atletes_sport_app/user/model/user.dart';
import 'package:atletes_sport_app/user/widget/sports.dart';


class UserDetails extends StatefulWidget {
  // This widget is the root of your application.
  late User user;

  UserDetails(this.user);

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
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Perfil usuario'),
      elevation: 0.0,
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
                enabled: false,
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
                enabled: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: new DropdownButton<String>(
                hint: Text('Pais'),
                value: widget.user.country,
                onChanged: (newValue) {
                  setState(() {
                    widget.user.country = newValue!;
                  });
                },
                items: <String>[
                  'Argentina',
                  'Bolivia',
                  'Brasil',
                  'Chile',
                  'Colombia',
                  'Costa Rica',
                  'Cuba',
                  'Ecuador',
                  'España',
                  'El Salvador',
                  'Guatemala',
                  'Honduras',
                  'México',
                  'Nicaragua',
                  'Panamá',
                  'Paraguay',
                  'Perú',
                  'Puerto Rico',
                  'República Dominicana',
                  'Uruguay',
                  'Venezuela'
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
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
            Container(
              height: 210,
              child:
              CheckboxWidget(widget.user.sports),
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
                  saveProfile();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombres = TextEditingController(text: widget.user.firstName);
    apellidos = TextEditingController(text: widget.user.lastName);
    if (widget.user.country.isEmpty){
      widget.user.country = 'Ecuador';
    }
    if(widget.user.sports.isEmpty){
      widget.user.sports = {
        'Ciclismo': false,
        'Correr': false,
        'Natacion': false,
        'Otros': false,
      };
    }
    ciudad = TextEditingController(text: widget.user.city);
    descripcion = TextEditingController(text: widget.user.description);
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

  void saveProfile(){
    FireStoreUtils.createNewUser(widget.user);
  }

}
