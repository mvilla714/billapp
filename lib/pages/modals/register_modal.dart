import 'package:billapp/db/db_admin.dart';
import 'package:billapp/widgets/textfield_normal_widget.dart';
import 'package:flutter/material.dart';

class RegisterModal extends StatefulWidget {
  const RegisterModal({super.key});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  TextEditingController _productController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34.0),
          topRight: Radius.circular(34.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Registra el gasto"),
          SizedBox(
            height: 16,
          ),
          TextFieldNormalWidget(
              hintText: "Ingresa el producto", controller: _productController),
          SizedBox(
            height: 16,
          ),
          TextFieldNormalWidget(
            hintText: "Ingresa el monto",
            controller: _priceController,
            isNumber: true,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.19),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Seleccione el tipo"),
                SizedBox(
                  width: 8,
                ),
                DropdownButton(
                  hint: Text("Seleccione"),
                  items: [
                    DropdownMenuItem(
                      value: "kg",
                      child: Text("Kg."),
                    ),
                    DropdownMenuItem(
                      value: "lt",
                      child: Text("Lt."),
                    ),
                    DropdownMenuItem(
                      value: "lata",
                      child: Text("Lata"),
                    ),
                  ],
                  onChanged: (seleccionActual) {
                    _typeController.text = seleccionActual!;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Map<String, dynamic> value = {
                  "product": _productController.text,
                  "price": double.parse(_priceController.text),
                  "type": _typeController.text,
                };
                DBAdmin().insertarGasto(value);
                DBAdmin().obtenerGasto();
              },
              child: const Text(
                "Agregar",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff101321),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
