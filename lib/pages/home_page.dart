import 'package:billapp/db/db_admin.dart';
import 'package:billapp/pages/modals/register_modal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  showRegisterModal() {
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
          child: RegisterModal(),
        );
      },
    );
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
                  showRegisterModal();
                  //sin patron singleton, cada ve se crea una instancia de dbaadmin
                  //DBAdmin dbAdmin = DBAdmin();
                  //dbAdmin.checkDataBase();
                  // dbAdmin.initDatabase();
                  //dbAdmin.insertarGasto();
                  //dbAdmin.obtenerGasto();

                  //con patron singleton, solo una instancia y es global
                  //DBAdmin().obtenerGasto();
                  //parametro
                  //DBAdmin().insertarGasto("Arroz", 3.5, "Kg.");
                  //map
                  /*DBAdmin().insertarGasto({
                    "product": "Gaseosa",
                    "price": 5.8,
                    "type": "Lt.",
                  });*/
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
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.shopping_cart,
                              ),
                              title: Text("1 kg Huevos"),
                              subtitle: Text("11/05/2023"),
                              trailing: Text("S/ 15.0"),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ],
      ),
    );
  }
}
