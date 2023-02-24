import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_form_app/flutter/bloc/global/global_bloc.dart';
import 'package:my_form_app/flutter/widgets/custom_input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = <String, String>{
      'username': '',
      'password': '',
    };
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        final GlobalBloc globalBloc = BlocProvider.of<GlobalBloc>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Iniciar sesión'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Form(
                      key: myFormKey,
                      child: Column(
                        children: <Widget>[
                          CustomInputField(
                            labelText: 'Usuario',
                            hintText: 'Ingrese su usuario',
                            formProperty: 'username',
                            formValues: formValues,
                            validator: 'username',
                            initialValue: globalBloc.state.user != null
                                ? globalBloc.state.user['username'] ?? ''
                                : '',
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            labelText: 'Contraseña',
                            hintText: 'Ingrese su contraseña',
                            formProperty: 'password',
                            formValues: formValues,
                            validator: 'password',
                            isPassword: true,
                            initialValue: globalBloc.state.user != null
                                ? globalBloc.state.user['password'] ?? ''
                                : '',
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (myFormKey.currentState!.validate()) {
                                myFormKey.currentState!.save();
                                debugPrint(formValues.toString());
                                globalBloc.add(SetIsLoading(true));
                                globalBloc.add(
                                  LoginUser(
                                    context: context,
                                    username: formValues['username']!,
                                    password: formValues['password']!,
                                  ),
                                );
                                Future<void>.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    // validar si inicio sesion y el usuario existe
                                    if (globalBloc.state.isLoggedIn) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/home',
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Usuario o contraseña incorrectos'),
                                        ),
                                      );
                                    }
                                    globalBloc.add(SetIsLoading(false));
                                  },
                                );
                              }
                            },
                            child: const Text('Iniciar sesión'),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Ir a registro');
                        Navigator.pushNamed(context, '/singup');
                      },
                      child: const Text('Ir a registro'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
