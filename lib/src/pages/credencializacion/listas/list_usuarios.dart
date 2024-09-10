import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/services/api_calls.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ListUsuariosPage extends StatefulWidget {
  const ListUsuariosPage({super.key});

  @override
  State<ListUsuariosPage> createState() => _ListUsuariosPageState();
}

class _ListUsuariosPageState extends State<ListUsuariosPage> {
  TextEditingController buscar = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController paterno = TextEditingController();
  TextEditingController materno = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController rol = TextEditingController();
  SingleValueDropDownController cnt = SingleValueDropDownController(
    data: const DropDownValueModel(name: '', value: ''),
  );
  Dio dio = Dio();

  Response listUsuarios = Response(requestOptions: RequestOptions());
  Response newListUsuarios = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());

  bool adduser = false;
  bool restorePass = false;
  bool activo = false;
  String idUpdate = "";

  Future apiGetUsers() async {
    listUsuarios = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/users',
        queryParameters: {"tipo": '1'});

    return listUsuarios.data;
  }

  Future apiGetUsersAfterAddOrModify() async {
    newListUsuarios = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/users',
        queryParameters: {"tipo": '1'});
    if (newListUsuarios.statusCode == 200) {
      setState(() {
        listUsuarios.data = newListUsuarios.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/user/search',
        queryParameters: {'buscar': buscar.text, 'tipo': '1'});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listUsuarios.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getUsers = apiGetUsers();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsers,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Adaptive.h(1),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton.icon(
                              icon: const Icon(Icons.settings),
                              style: Styles.buttonListArtesano,
                              onPressed: () {
                                Navigator.of(context).pushNamed("herramientas");
                              },
                              label: Text(
                                "HERRAMIENTAS",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                          Expanded(child: Container()),
                          SizedBox(
                            width: Adaptive.w(3),
                          ),
                          SizedBox(
                            width: Adaptive.w(35),
                            height: Adaptive.h(5),
                            child: TextFormField(
                              cursorWidth: 2,
                              cursorHeight: 15,
                              controller: buscar,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onFieldSubmitted: (value) {
                                apiSearch(context);
                              },
                              onChanged: (value) {},
                              decoration: Styles().inputStyleSearch(
                                  "BUSCAR", const Icon(Icons.search)),
                            ),
                          ),
                          SizedBox(
                            width: Adaptive.w(23),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Adaptive.h(3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(2)),
                    child: Row(
                      children: [
                        SizedBox(
                            width: Adaptive.w(40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AnimatedToggleSwitch<bool>.dual(
                                  current: adduser,
                                  first: false,
                                  second: true,
                                  spacing: 50.0,
                                  style: const ToggleStyle(
                                    borderColor: Colors.transparent,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  borderWidth: 5.0,
                                  onChanged: (bool state) {
                                    setState(() {
                                      adduser = state;
                                      if (adduser == true) {
                                        setState(() {
                                          activo = true;
                                        });
                                        nombre.text = '';
                                        paterno.text = '';
                                        materno.text = '';
                                        telefono.text = '';
                                        correo.text = '';
                                        cnt = SingleValueDropDownController(
                                            data: const DropDownValueModel(
                                                name: '', value: ''));
                                      }
                                    });
                                  },
                                  styleBuilder: (b) => ToggleStyle(
                                      indicatorColor:
                                          b ? Colors.white : Colors.white,
                                      backgroundColor:
                                          b ? Styles.rojo : Styles.crema2),
                                  iconBuilder: (value) => value
                                      ? const Icon(Icons.person_add)
                                      : const Icon(Icons.edit),
                                  textBuilder: (value) => value
                                      ? const Center(
                                          child: Text(
                                          'NUEVO',
                                          style: TextStyle(color: Colors.white),
                                        ))
                                      : const Center(child: Text('EDITAR')),
                                ),
                                adduser == false
                                    ? Expanded(child: Container())
                                    : Container(),
                                adduser == true
                                    ? Container()
                                    : AnimatedToggleSwitch<bool>.dual(
                                        current: restorePass,
                                        first: false,
                                        second: true,
                                        spacing: 50.0,
                                        style: const ToggleStyle(
                                          borderColor: Colors.transparent,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: Offset(0, 1.5),
                                            ),
                                          ],
                                        ),
                                        borderWidth: 5.0,
                                        onChanged: (bool state) {
                                          setState(() {
                                            restorePass = state;
                                          });
                                        },
                                        styleBuilder: (b) => ToggleStyle(
                                            indicatorColor:
                                                b ? Colors.white : Colors.white,
                                            backgroundColor: b
                                                ? Colors.green
                                                : Styles.crema2),
                                        iconBuilder: (value) => value
                                            ? const Icon(Icons.edit)
                                            : const Icon(Icons.edit),
                                        textBuilder: (value) => value
                                            ? Center(
                                                child: Text(
                                                'CAMBIAR CONTRASEÑA',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Adaptive.sp(10)),
                                              ))
                                            : Center(
                                                child: Text(
                                                'CAMBIAR CONTRASEÑA',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(10)),
                                              )),
                                      ),
                                adduser == false
                                    ? SizedBox(
                                        width: Adaptive.w(2),
                                      )
                                    : Container()
                              ],
                            )),
                        SizedBox(
                          width: Adaptive.w(55),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: Adaptive.w(30),
                                  child: Text(
                                    "NOMBRE",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(20),
                                  child: Text(
                                    "CORREO",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(2)),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: Adaptive.w(18),
                                  height: Adaptive.h(5),
                                  child: TextFormField(
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    controller: nombre,
                                    inputFormatters: [
                                      CapitalLetters(),
                                    ],
                                    onChanged: (value) {},
                                    decoration:
                                        Styles().inputStyleArtesano("NOMBRE"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Adaptive.w(2),
                                ),
                                SizedBox(
                                  width: Adaptive.w(18),
                                  height: Adaptive.h(5),
                                  child: TextFormField(
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    controller: paterno,
                                    inputFormatters: [
                                      CapitalLetters(),
                                    ],
                                    onChanged: (value) {},
                                    decoration: Styles()
                                        .inputStyleArtesano("APELLIDO PATERNO"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Adaptive.w(18),
                                  height: Adaptive.h(5),
                                  child: TextFormField(
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    controller: materno,
                                    inputFormatters: [
                                      CapitalLetters(),
                                    ],
                                    onChanged: (value) {},
                                    decoration: Styles()
                                        .inputStyleArtesano("APELLIDO MATERNO"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Adaptive.w(2),
                                ),
                                SizedBox(
                                  width: Adaptive.w(18),
                                  height: Adaptive.h(5),
                                  child: TextFormField(
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    controller: correo,
                                    onChanged: (value) {},
                                    decoration:
                                        Styles().inputStyleArtesano("CORREO"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(2),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Adaptive.w(18),
                                  height: Adaptive.h(5),
                                  child: TextFormField(
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    controller: telefono,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]")),
                                      LengthLimitingTextInputFormatter(10)
                                    ],
                                    onChanged: (value) {},
                                    decoration:
                                        Styles().inputStyleArtesano("TELEFONO"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Adaptive.w(2),
                                ),
                                SizedBox(
                                  width: Adaptive.w(18),
                                  height: Adaptive.h(5),
                                  child: DropDownTextField(
                                    controller: cnt,
                                    clearOption: true,
                                    textFieldDecoration:
                                        Styles().inputListUser('ROL'),
                                    searchDecoration:
                                        Styles().inputListUser('Buscar'),
                                    validator: (value) {
                                      if (value == null) {
                                        return "Rol requerido";
                                      } else {
                                        return null;
                                      }
                                    },
                                    dropDownItemCount: 6,
                                    enableSearch: true,
                                    dropDownList: const [
                                      DropDownValueModel(
                                          name: 'Administrador',
                                          value: "Administrador",
                                          toolTipMsg: ''),
                                      DropDownValueModel(
                                          name: 'Capturista',
                                          value: "Capturista",
                                          toolTipMsg: ''),
                                      DropDownValueModel(
                                          name: 'Consultor',
                                          value: "Consultor",
                                          toolTipMsg: ''),
                                    ],
                                    onChanged: (val) {},
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(2),
                            ),
                            Row(
                              children: [
                                AnimatedToggleSwitch<bool>.dual(
                                  current: activo,
                                  first: false,
                                  second: true,
                                  spacing: 50.0,
                                  style: const ToggleStyle(
                                    borderColor: Colors.transparent,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(0, 1.5),
                                      ),
                                    ],
                                  ),
                                  borderWidth: 5.0,
                                  onChanged: (bool state) {
                                    setState(() {
                                      activo = state;
                                    });
                                  },
                                  styleBuilder: (b) => ToggleStyle(
                                      indicatorColor:
                                          b ? Colors.white : Colors.white,
                                      backgroundColor:
                                          b ? Colors.green : Styles.crema2),
                                  iconBuilder: (value) => value
                                      ? const Icon(Icons.done)
                                      : const Icon(Icons.error),
                                  textBuilder: (value) => value
                                      ? Center(
                                          child: Text(
                                          'ACTIVO',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Adaptive.sp(10)),
                                        ))
                                      : Center(
                                          child: Text(
                                          'INACTIVO',
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(10)),
                                        )),
                                ),
                                SizedBox(
                                  width: Adaptive.w(2),
                                ),
                                SizedBox(
                                  width: Adaptive.w(25),
                                  height: Adaptive.h(5),
                                  child: TextFormField(
                                    cursorWidth: 2,
                                    cursorHeight: 15,
                                    controller: password,
                                    onChanged: (value) {},
                                    decoration: Styles().inputStyleArtesano(
                                        adduser == false
                                            ? "NUEVA CONTRASEÑA"
                                            : "CONTRASEÑA"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(5),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                      onPressed: () async {
                                        var acti = 1;
                                        if (activo == true) {
                                          acti = 1;
                                        } else {
                                          acti = 0;
                                        }
                                        if (adduser == true) {
                                          var data = {
                                            "email": correo.text,
                                            "rol": cnt.dropDownValue!.name,
                                            "activo": acti,
                                            "nombre": nombre.text,
                                            "ap_paterno": paterno.text,
                                            "ap_materno": materno.text,
                                            "telefono": telefono.text,
                                            "password": password.text,
                                            "tipo": '1',
                                          };
                                          if (await ApiCalls()
                                              .addUser(data, context)) {
                                            apiGetUsersAfterAddOrModify();
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Usuario añadido',
                                                context);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.red,
                                                Icons.error,
                                                'Error, inténtalo de nuevo',
                                                context);
                                          }
                                        } else {
                                          var data = {
                                            "email": correo.text,
                                            "rol": cnt.dropDownValue!.name,
                                            "activo": acti,
                                            "nombre": nombre.text,
                                            "ap_paterno": paterno.text,
                                            "ap_materno": materno.text,
                                            "telefono": telefono.text
                                          };

                                          if (await ApiCalls().updateUser(
                                              data, idUpdate, context)) {
                                            apiGetUsersAfterAddOrModify();
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Información actualizada',
                                                context);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.red,
                                                Icons.error,
                                                'Error, inténtalo de nuevo',
                                                context);
                                          }
                                        }
                                      },
                                      child: Text(adduser == false
                                          ? "ACTUALIZAR"
                                          : "CREAR")),
                                  restorePass == true
                                      ? SizedBox(
                                          width: Adaptive.w(3),
                                        )
                                      : Container(),
                                  restorePass == true
                                      ? OutlinedButton(
                                          onPressed: () async {
                                            if (restorePass == true) {
                                              var data = {
                                                "password": password.text,
                                              };

                                              if (await ApiCalls()
                                                  .updatePassUser(data,
                                                      idUpdate, context)) {
                                                apiGetUsersAfterAddOrModify();
                                                // ignore: use_build_context_synchronously
                                                Message().mensaje(
                                                    Colors.green,
                                                    Icons.done,
                                                    'Contraseña actualizada',
                                                    context);
                                              } else {
                                                // ignore: use_build_context_synchronously
                                                Message().mensaje(
                                                    Colors.red,
                                                    Icons.error,
                                                    'Error, inténtalo de nuevo',
                                                    context);
                                              }
                                            } else {
                                              Message().mensaje(
                                                  Colors.amber,
                                                  Icons.warning,
                                                  'Marca la opción de cambiar contraseña',
                                                  context);
                                            }
                                          },
                                          child:
                                              const Text("CAMBIAR CONTRASEÑA"))
                                      : Container()
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: Adaptive.w(55),
                          height: Adaptive.h(50),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (var item in listUsuarios.data)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        adduser = false;
                                        idUpdate = item['id_usuario'];
                                        nombre.text = item['nombre'];
                                        paterno.text = item['ap_paterno'];
                                        materno.text = item['ap_materno'];
                                        correo.text = item['email'];
                                        telefono.text = item['telefono'];
                                        cnt = SingleValueDropDownController(
                                          data: DropDownValueModel(
                                              name: item['rol'], value: ''),
                                        );
                                        if (item['activo'] == '1') {
                                          activo = true;
                                        } else {
                                          activo = false;
                                        }
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Adaptive.h(3),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: Adaptive.w(30),
                                                child: Text(
                                                  item['nombre'] +
                                                      ' ' +
                                                      item['ap_paterno'] +
                                                      ' ' +
                                                      item['ap_materno'],
                                                  style: TextStyle(
                                                      fontSize: Adaptive.sp(11),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            SizedBox(
                                              width: Adaptive.w(1),
                                            ),
                                            SizedBox(
                                                width: Adaptive.w(20),
                                                child: Text(
                                                  item['email'],
                                                  style: TextStyle(
                                                      fontSize: Adaptive.sp(11),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Image.asset("assets/images/cargando.gif");
      },
    );
  }
}
