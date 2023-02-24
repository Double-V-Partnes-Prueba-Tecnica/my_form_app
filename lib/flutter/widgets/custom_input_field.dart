import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final int? minCharacters;
  final int? maxCharacters;
  final bool? autofocus;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? validator;
  final String formProperty;
  final Map<String, String> formValues;
  final bool? isPassword;

  const CustomInputField({
    Key? key,
    this.hintText,
    this.labelText,
    this.helperText,
    this.icon,
    this.suffixIcon,
    this.minCharacters,
    this.maxCharacters,
    this.autofocus,
    this.isPassword,
    this.initialValue,
    this.keyboardType,
    this.validator,
    required this.formProperty,
    required this.formValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic validador = {
      'email': {
        'regex': RegExp(
            r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'),
        'message': 'Correo no válido'
      },
      'password': {
        'regex': RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$'),
        'message':
            'Contraseña no válida.\nDebe tener al menos 6 caracteres.\nUna mayúscula una minúscula y un número.'
      },
      'number': {
        'regex': RegExp(r'^[0-9]{8,}$'),
        'message': 'Número no válido',
      },
      'name': {
        'regex': RegExp(r'^[a-zA-Z ]{3,}$'),
        'message':
            'Nombre no válido, debe tener al menos 3 caracteres y solo letras',
      },
      'date': {
        'regex': RegExp(r'^[0-9]{2}\/[0-9]{2}\/[0-9]{4}$'),
        'message': 'Fecha de nacimiento no válida',
      },
      'username': {
        'regex': RegExp(r'^[a-zA-Z0-9._-]{6,}$'),
        'message': 'Usuario no válido, debe tener al menos 6 caracteres',
      },
      'address': {
        // Caracteres validos: letras, numeros y espacios # - . ,
        'regex': RegExp(r'^[a-zA-Z0-9 #.,-]{6,}$'),
        'message': 'Dirección no válida, debe tener al menos 6 caracteres',
      },
    };
    if (initialValue != null && initialValue!.isNotEmpty) {
      formValues[formProperty] = initialValue!;
    }

    return TextFormField(
      autofocus: autofocus ?? false,
      initialValue: initialValue,
      textCapitalization: TextCapitalization.words,
      onChanged: (value) {
        try {
          formValues[formProperty] = value;
        } catch (e) {
          print(e);
        }
      },
      validator: (value) {
        try {
          if (value == null || value.isEmpty) {
            return 'Este campo no puede estar vacio';
          }
          if (minCharacters != null && value.length < minCharacters!) {
            return 'Este campo debe tener al menos $minCharacters caracteres';
          }
          if (maxCharacters != null && value.length > maxCharacters!) {
            return 'Este campo no puede tener mas de $maxCharacters caracteres';
          }
          if (validador != null) {
            if (!validador[validator]!['regex'].hasMatch(value)) {
              return validador[validator]!['message'];
            }
          }
          if (value == null || value.isEmpty) {
            return 'Este campo no puede estar vacio';
          }
          // validar fecha de nacimiento DD/MM/YYYY
          if (validator == 'date') {
            List<String> date = value.split('/');
            int day = int.parse(date[0]);
            int month = int.parse(date[1]);
            int year = int.parse(date[2]);

            if (day < 1 || day > 31) {
              return 'El día no es válido';
            }
            if (month < 1 || month > 12) {
              return 'El mes no es válido';
            }
            if (year < 1900 || year > 2023) {
              return 'El año no es válido';
            }
            // validar bisiesto
            if (month == 2) {
              if (day > 29) {
                return 'El día no es válido';
              }
              if (day == 29) {
                if (year % 4 != 0) {
                  return 'El día no es válido';
                }
                if (year % 100 == 0) {
                  if (year % 400 != 0) {
                    return 'El día no es válido';
                  }
                }
              }
            }
          }
          return null;
        } catch (e) {
          return 'Error en el campo';
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        icon: icon != null ? Icon(icon) : null,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
      ),
      obscureText: isPassword ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
    );
  }
}
