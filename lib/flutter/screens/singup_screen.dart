import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_form_app/flutter/bloc/global/global_bloc.dart';
import 'package:my_form_app/flutter/widgets/custom_input_field.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = <String, String>{
      'username': '',
      'password': '',
      'confirmPassword': '',
      'name': '',
      'lastName': '',
      'birthDate': '',
    };
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Registro'),
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
                          //Nombre, Apellido, fecha de nacimiento
                          CustomInputField(
                            labelText: 'Nombre',
                            hintText: 'Ingrese su nombre',
                            formProperty: 'name',
                            formValues: formValues,
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            labelText: 'Apellido',
                            hintText: 'Ingrese su apellido',
                            formProperty: 'lastName',
                            formValues: formValues,
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            labelText: 'Fecha de nacimiento',
                            hintText: 'Ingrese su fecha de nacimiento',
                            formProperty: 'birthDate',
                            formValues: formValues,
                          ),
                          const SizedBox(height: 20),
                          CustomInputField(
                            labelText: 'Usuario',
                            hintText: 'Ingrese su usuario',
                            formProperty: 'username',
                            validator: 'username',
                            formValues: formValues,
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
                          CustomInputField(
                            labelText: 'Confirmar contraseña',
                            hintText: 'Ingrese su contraseña',
                            formProperty: 'confirmPassword',
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
                            child: const Text('Registrar'),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                      },
                      child: const Text('Ir a Iniciar Sesión'),
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
