import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_form_app/flutter/bloc/global/global_bloc.dart';
import 'package:my_form_app/flutter/widgets/custom_input_field.dart';
import 'package:my_form_app/services/storage/app_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = <String, String>{
      'address': '',
    };
    final GlobalBloc globalBloc = BlocProvider.of<GlobalBloc>(context);

    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Bienvenido ${globalBloc.state.user != null ? ', ${globalBloc.state.user['name']}' : ''}',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  globalBloc.add(SignOut());
                  debugPrint('Salir');
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
          body: Center(
            child: globalBloc.state.isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: myFormKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: CustomInputField(
                                labelText: 'Nueva Dirección',
                                hintText: 'Ingrese su nueva dirección',
                                formProperty: 'address',
                                formValues: formValues,
                                validator: 'address',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (myFormKey.currentState!.validate()) {
                                  myFormKey.currentState!.save();
                                  debugPrint(formValues.toString());

                                  debugPrint(
                                    'user: ${globalBloc.state.user}',
                                  );

                                  String? token = await AppStorage.getProperty(
                                    'token',
                                  );

                                  // Agregar dirección a la lista de direcciones del usuario
                                  globalBloc.add(
                                    GetAddresses(
                                      name: formValues['address'],
                                      userId: globalBloc.state.user != null
                                          ? globalBloc.state.user['id']
                                          : '',
                                      token: token ?? '',
                                    ),
                                  );
                                  // Limpia el formulario
                                  myFormKey.currentState!.reset();
                                }
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: globalBloc.state.user != null
                              ? globalBloc.state.user['addresses'].length
                              : 0,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                  globalBloc.state.user['addresses'][index]
                                      ['name'],
                                ),
                                // Boton de delete rojo con icono de basura, el icono es blanco, y el fondo es rojo
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    debugPrint(
                                      'Eliminar ${globalBloc.state.user['addresses'][index]['name']}',
                                    );

                                    String? token =
                                        await AppStorage.getProperty(
                                      'token',
                                    );

                                    // Eliminar dirección de la lista de direcciones del usuario
                                    globalBloc.add(
                                      DeleteAddress(
                                        addressId: globalBloc.state.user != null
                                            ? globalBloc.state.user['addresses']
                                                [index]['id']
                                            : '',
                                        token: token ?? '',
                                        userId: globalBloc.state.user != null
                                            ? globalBloc.state.user['id']
                                            : '',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
