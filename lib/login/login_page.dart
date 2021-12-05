import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:atletes_sport_app/authentication/authentication.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(
                      'assets/atletes.jpg',
                      height: 200,
                    ),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0),
                  ),
                  onPressed: () {

                  },
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'Login Google'.toUpperCase(),
                  ),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                ),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {

                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  minWidth: double.infinity,
                  height: 40,
                  child: Text(
                    'Login Facebook'.toUpperCase(),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
