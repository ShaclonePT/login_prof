import 'package:flutter/material.dart';
import 'package:login_prof/authentication.dart';
import 'package:login_prof/login.dart';
import 'package:login_prof/home.dart';

class Signupaluno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          SizedBox(height: 80),
          // logo
          Column(
            children: [
              Container(
                  width: 150,
                  height: 150,
                  child: Image.asset('assets/aluno.png')),
            ],
          ),
          SizedBox(height: 50),
          Text(
            'Cadastre o aluno!',
            style: TextStyle(fontSize: 24),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SignupForm(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthenticationHelper()
              .signOut()
              .then((_) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (contex) => Login()),
                  ));
        },
        child: Icon(Icons.logout),
        tooltip: 'Logout',
      ),
    );
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "T",
          style: TextStyle(color: Colors.white, fontSize: 60.0),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  String name;
  String nota1;
  String nota2;
  bool _obscureText = true;

  bool agree = false;

  final pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(100.0),
      ),
    );

    var space = SizedBox(height: 10);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: 'Email',
                border: border),
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor insira algum texto';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          space,

          // password
          TextFormField(
            controller: pass,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            onSaved: (val) {
              password = val;
            },
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor insira algum texto';
              }
              return null;
            },
          ),
          space,
          // confirm passwords
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: border,
            ),
            obscureText: true,
            validator: (value) {
              if (value != pass.text) {
                return 'A senha não coincide';
              }
              return null;
            },
          ),
          space,
          // name
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: Icon(Icons.account_circle),
              border: border,
            ),
            onSaved: (val) {
              name = val;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor insira algum nome';
              }
              return null;
            },
          ),
          space,
          // name
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Insira a Nota 1',
              prefixIcon: Icon(Icons.format_list_numbered),
              border: border,
            ),
            onSaved: (val) {
              nota1 = val;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor insira alguma nota';
              }
              return null;
            },
          ),
          space,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Insira a Nota 2',
              prefixIcon: Icon(Icons.format_list_numbered),
              border: border,
            ),
            onSaved: (val) {
              nota2 = val;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor insira alguma nota';
              }
              return null;
            },
          ),

          // signUP button
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                AuthenticationHelper()
                    .signUp(email: email, password: password)
                    .then((result) {
                  if (result == null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        result,
                        style: TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                });
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            color: Colors.blue[400],
            textColor: Colors.white,
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
