import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_codedata/models/user_model.dart';
import 'package:loja_codedata/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignupScreen()));
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator(),);

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty || !text.contains("@")) return "E-mail inválido";
                    return null;
                  },
                ),

                SizedBox(height: 16.0,),

                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) return "Senha inválida";
                    return null;
                  },
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text("Esqueci minha senha", textAlign: TextAlign.right),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Insira seu e-mail para recuperar senha"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        model.recoverPass(_emailController.text);
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Confira seu e-mail"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ),

                SizedBox(height: 16.0,),

                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0, color: Colors.white),),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao Logar"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}