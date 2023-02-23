import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_form_app/flutter/bloc/global/global_bloc.dart';
import 'package:my_form_app/flutter/widgets/custom_input_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = <String, String>{
      'username': '',
      'password': '',
    };
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Login and Register'),
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
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            labelText: 'Contraseña',
                            hintText: 'Ingrese su contraseña',
                            formProperty: 'password',
                            formValues: formValues,
                            validator: 'password',
                            isPassword: true,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (myFormKey.currentState!.validate()) {
                                myFormKey.currentState!.save();
                                debugPrint(formValues.toString());
                              }
                            },
                            child: const Text('Enviar'),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
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
