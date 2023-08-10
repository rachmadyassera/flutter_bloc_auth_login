import 'package:fic4_flutter_auth_bloc/bloc/login/login_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/register/register_bloc.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/login_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';
import 'package:fic4_flutter_auth_bloc/presentation/pages/home_page.dart';
import 'package:fic4_flutter_auth_bloc/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    // TODO: implement initState
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              controller: emailController,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              controller: passwordController,
            ),
            const SizedBox(
              height: 16,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is LoginLoaded) {
                  emailController!.clear();
                  passwordController!.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text('Success Login'),
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                }
              },
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                    onPressed: () {
                      final requestModel = LoginModel(
                          email: emailController!.text,
                          password: passwordController!.text);
                      context
                          .read<LoginBloc>()
                          .add(DoLoginEvent(loginModel: requestModel));
                    },
                    child: const Text('Login'));
              },
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  }));
                },
                child: const Text(
                  'Belum punya akun ? Register',
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
