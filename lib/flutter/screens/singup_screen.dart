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
        final GlobalBloc globalBloc = BlocProvider.of<GlobalBloc>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Registro'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: globalBloc.state.isLoading
                  ? const CircularProgressIndicator()
                  : Padding(
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
                                  validator: 'name',
                                ),
                                const SizedBox(height: 20),
                                CustomInputField(
                                  labelText: 'Apellido',
                                  hintText: 'Ingrese su apellido',
                                  formProperty: 'lastName',
                                  formValues: formValues,
                                  validator: 'name',
                                ),
                                const SizedBox(height: 20),
                                CustomInputField(
                                  labelText: 'Fecha de nacimiento, DD/MM/YYYY',
                                  hintText: 'Ingrese su fecha de nacimiento',
                                  formProperty: 'birthDate',
                                  formValues: formValues,
                                  validator: 'date',
                                  keyboardType: TextInputType.datetime,
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
                                      // validar si las contraseñas coinciden
                                      if (formValues['password'] !=
                                          formValues['confirmPassword']) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Las contraseñas no coinciden, por favor verifique',
                                            ),
                                          ),
                                        );
                                        return;
                                      } else {
                                        globalBloc.add(
                                          SetIsLoading(true),
                                        );
                                        globalBloc.add(
                                          RegisterUser(
                                            context: context,
                                            username: formValues['username']!,
                                            password: formValues['password']!,
                                            name: formValues['name']!,
                                            lastName: formValues['lastName']!,
                                            birthDate: () {
                                              final List<String> date =
                                                  formValues['birthDate']!
                                                      .split('/');
                                              return DateTime(
                                                int.parse(date[2]),
                                                int.parse(date[1]),
                                                int.parse(date[0]),
                                              );
                                            }(),
                                          ),
                                        );
                                        Future<void>.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            debugPrint(
                                                'globalBloc.state.user: ${globalBloc.state.user}');
                                            if (globalBloc.state.user != null) {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                '/login',
                                                (Route<dynamic> route) => false,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'No se pudo registrar el usuario, por favor verifique',
                                                  ),
                                                ),
                                              );
                                            }
                                            globalBloc.add(
                                              SetIsLoading(false),
                                            );
                                          },
                                        );
                                      }
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
