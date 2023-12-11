import 'package:billapp/db/db_admin.dart';
import 'package:billapp/models/bill_model.dart';
import 'package:billapp/widgets/textfield_normal_widget.dart';
import 'package:flutter/material.dart';

class RegisterModal extends StatefulWidget {
  //const RegisterModal({super.key});
  int action;
  BillModel? gastoBill;
  RegisterModal({required this.action, required this.gastoBill});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  TextEditingController _productController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.action == 2) {
      _productController.text = widget.gastoBill!.product;
      _priceController.text = widget.gastoBill!.price.toString();
      _typeController.text = widget.gastoBill!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.action);
    print(widget.gastoBill!.product);
    print(widget.gastoBill!.id);

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
              hintText: "Ingresa el título", controller: _productController),
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
                Text("Seleccione tipo"),
                SizedBox(
                  width: 8,
                ),
                DropdownButton(
                  hint: Text("Seleccione"),
                  value: widget.action == 1 ? "kg" : _typeController.text,
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
                    print(_typeController.text);
                    setState(() {
                      _typeController.text = seleccionActual!;
                    });
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
                //SIN PATRÓN SINGLETON CADA QUE SE PRESIONA EL BOTÓN SE CREA UNA INSTANCIA DE DBadmin
                // DBAdmin dbAdmin = DBAdmin();
                // dbAdmin.checkDataBase();
                // dbAdmin.insertarGasto();

                //CON PATRÓN SINGLETON, SOLO EXISTE UNA SOLA INSTANCIA DE DBADMIN Y ES GLOBAL
                // DBAdmin().obtenerGastos();
                // DBAdmin().insertarGasto("Arrzon", 2.5, "Kg.");

                Map<String, dynamic> value = {
                  "product": _productController.text,
                  "price": double.parse(_priceController.text),
                  "type": _typeController.text,
                };

                BillModel model = BillModel(
                  product: _productController.text,
                  price: double.parse(_priceController.text),
                  type: _typeController.text,
                );
                if (widget.action == 1) {
                  DBAdmin().insertarGasto(model).then((value) {
                    if (value > 0) {
                      //se ha insertado correctamente
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          content: Text("Se inserto el registro correctamente"),
                        ),
                      );
                      Navigator.pop(context);
                    } else {}
                  }).catchError((error) {
                    print(error);
                  });
                } else {
                  DBAdmin().updBill(widget.gastoBill!.id, model).then((value) {
                    if (value > 0) {
                      //se ha insertado correctamente
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          content:
                              Text("Se actualizo el registro correctamente"),
                        ),
                      );
                      Navigator.pop(context);
                    } else {}
                  }).catchError((error) {
                    print(error);
                  });
                }

                // DBAdmin().obtenerGastos();
              },
              child: Text(
                widget.action == 1 ? "Agregar" : "Actualizar",
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
