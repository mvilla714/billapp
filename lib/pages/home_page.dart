import 'package:billapp/db/db_admin.dart';
import 'package:billapp/models/bill_model.dart';
import 'package:billapp/pages/modals/register_modal.dart';
import 'package:billapp/widgets/item_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map> gastosList = [];
  List<BillModel> gastosBill = [];
  int action = 1;

  showRegisterModal(int index) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext ctx) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // height: 200,
          // color: Colors.white,
          child: RegisterModal(
            action: action,
            gastoBill: gastosBill[index],
          ),
        );
      },
    ).then((value) {
      getDataGeneralBillModel();
    });
  }

  // Future<void> getDataGeneralMap() async {
  //   gastosList = await DBAdmin().obtenerGastos();
  //   print("RECUPERANDO LA BD Y ASIGNANDOLA EN NUESTRA LISTA");
  //   print(gastosList);
  //   setState(() {});
  // }

  Future<void> getDataGeneralBillModel() async {
    gastosBill = await DBAdmin().getBills();
    print("RECUPERANDO LA BD Y ASIGNANDOLA EN NUESTRA LISTA de BILLS MODEL");
    print(gastosBill);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getDataGeneralMap();
    action = 1;
    getDataGeneralBillModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  action = 1;
                  showRegisterModal(0);
                  // DBAdmin().obtenerGastos();
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Agregar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(34),
                      bottomRight: Radius.circular(34),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Resumen de gastos",
                            style: TextStyle(
                              // color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text("Gestiona tus gastos de la mejor forma"),
                          Divider(
                            height: 24,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: gastosBill.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    // //ELIMINAR GASTO
                                    // DBAdmin()
                                    //     .delBill(gastosBill[index].id!)
                                    //     .then((value) {
                                    //   getDataGeneralBillModel();
                                    // });

                                    //ACTUALIZAR GASTO
                                    //DBAdmin()
                                    //    .updBill(gastosBill[index].id!)
                                    //    .then((value) {
                                    //  getDataGeneralBillModel();
                                    //});
                                    action = 2;
                                    showRegisterModal(index);
                                  },
                                  onDoubleTap: () {
                                    DBAdmin()
                                        .delBill(gastosBill[index].id!)
                                        .then((value) {
                                      getDataGeneralBillModel();
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                            "Se elimino el registro correctamente"),
                                      ),
                                    );
                                  },
                                  child: ItemWidget(
                                    billProduct: gastosBill[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
