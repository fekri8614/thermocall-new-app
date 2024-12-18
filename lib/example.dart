import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController heightEditing = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: heightEditing,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Fill the box';
              }
              if (value.length < 2 || value.length > 3) {
                return 'enter true value';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Enter your height',
              labelText: 'Height',
              suffixText: 'Cm',
              helperText: 'Enter your height in cm format',
              icon: const Icon(Icons.height),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^([8-9][0-9]|1[0-9]{2}|20[0-9]|210)$'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
