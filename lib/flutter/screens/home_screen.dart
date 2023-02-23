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
      'address': '',
    };
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Bienvenido'),
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
                            labelText: 'Nueva Dirección',
                            hintText: 'Ingrese su nueva dirección',
                            formProperty: 'username',
                            formValues: formValues,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (myFormKey.currentState!.validate()) {
                                myFormKey.currentState!.save();
                                debugPrint(formValues.toString());
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        debugPrint('Cerrando sesión');
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text('Cerrar sesión'),
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
