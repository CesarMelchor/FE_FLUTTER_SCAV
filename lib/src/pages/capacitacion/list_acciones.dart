import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListAccionesScreen extends StatefulWidget {
  const ListAccionesScreen({super.key});

  @override
  State<ListAccionesScreen> createState() => _ListAccionesScreenState();
}

class _ListAccionesScreenState extends State<ListAccionesScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController buscarRegisters = TextEditingController();

  TextEditingController area = TextEditingController();
  TextEditingController nombbre = TextEditingController();
  TextEditingController capacitador = TextEditingController();
  TextEditingController capacitador2 = TextEditingController();
  TextEditingController cargo2 = TextEditingController();
  TextEditingController objetivo = TextEditingController();
  TextEditingController poblacion = TextEditingController();
  TextEditingController duracion = TextEditingController();
  TextEditingController nivel = TextEditingController();
  TextEditingController cargo = TextEditingController();
  TextEditingController trimestre = TextEditingController();
  TextEditingController programa = TextEditingController();
  TextEditingController annio = TextEditingController();
  TextEditingController textoConstancia =
      TextEditingController(text: 'por su participación en la capacitación ');

  TextEditingController areaE = TextEditingController();
  TextEditingController nombbreE = TextEditingController();
  TextEditingController capacitadorE = TextEditingController();
  TextEditingController capacitador2E = TextEditingController();
  TextEditingController cargo2E = TextEditingController();
  TextEditingController objetivoE = TextEditingController();
  TextEditingController cargoE = TextEditingController();
  TextEditingController poblacionE = TextEditingController();
  TextEditingController duracionE = TextEditingController();
  TextEditingController nivelE = TextEditingController();
  TextEditingController trimestreE = TextEditingController();
  TextEditingController programaE = TextEditingController();
  TextEditingController annioE = TextEditingController();
  TextEditingController textoConstanciaE = TextEditingController();

  String programaid = "";
  String trimestreid = "";

  String programaidE = "";
  String trimestreidE = "";
  String accionId = "";
  String hintPrograma = "";
  String hintTrimestre = "";
  String hintNivel = "";
  String nivelEdit = "";
  bool creating = false;

  Dio dio = Dio();

  Response listTrimestres = Response(requestOptions: RequestOptions());
  Response listProgramas = Response(requestOptions: RequestOptions());
  Response newListAcciones = Response(requestOptions: RequestOptions());

  Response listAccionesSearch = Response(requestOptions: RequestOptions());

  Response listAcciones = Response(requestOptions: RequestOptions());

  Response resultSearch = Response(requestOptions: RequestOptions());
  Response addAccion = Response(requestOptions: RequestOptions());
  Response editAccion = Response(requestOptions: RequestOptions());

  bool actualizando = false;
  bool agregando = false;

  Future apiAddAccion(BuildContext context) async {
    setState(() {
      agregando = true;
    });
    addAccion = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/acciones/create', data: {
      "id_programa": programaid,
      "area": area.text,
      "nombre": nombbre.text,
      "capacitador": capacitador.text,
      "capacitador2": capacitador2.text,
      "objetivo": objetivo.text,
      "poblacion_objetivo": poblacion.text,
      "duracion": duracion.text,
      "nivel": nivel.text,
      "cargo": cargo.text,
      "cargo2": cargo2.text,
      "id_trimestre": trimestreid,
      "annio": annio.text,
      "texto_constancia": textoConstancia.text,
      "created_at": GlobalVariable.currentDate,
      "updated_at": GlobalVariable.currentDate,
    });

    if (addAccion.statusCode == 200) {
      setState(() {
        buscar.text = '';
        trimestreid = '';
        programaid = '';
        area = TextEditingController();
        nombbre = TextEditingController();
        capacitador = TextEditingController();
        capacitador2 = TextEditingController();
        cargo = TextEditingController();
        cargo2 = TextEditingController();
        objetivo = TextEditingController();
        poblacion = TextEditingController();
        duracion = TextEditingController();
        nivel = TextEditingController();
        annio = TextEditingController();
        programa = TextEditingController();
        trimestre = TextEditingController();
        textoConstancia = TextEditingController();
      });
      setState(() {
        agregando = false;
      });
      return true;
    } else {
      setState(() {
        agregando = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      return false;
    }
  }

  Future apiAEditAccion(BuildContext context) async {
    setState(() {
      actualizando = true;
    });
    editAccion = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/accion/update/$accionId',
        data: {
          "id_programa": programaidE,
          "area": areaE.text,
          "nombre": nombbreE.text,
          "capacitador": capacitadorE.text,
          "capacitador2": capacitador2E.text,
          "objetivo": objetivoE.text,
          "cargo": cargoE.text,
          "cargo2": cargo2E.text,
          "poblacion_objetivo": poblacionE.text,
          "duracion": duracionE.text,
          "nivel": nivelEdit,
          "id_trimestre": trimestreidE,
          "annio": annioE.text,
          "texto_constancia": textoConstanciaE.text,
          "updated_at": GlobalVariable.currentDate,
        });

    if (editAccion.statusCode == 200) {
      setState(() {
        accionId = "";
        hintPrograma = "";
        hintTrimestre = "";
        hintNivel = "";
        trimestreidE = '';
        programaidE = '';
        areaE = TextEditingController();
        nombbreE = TextEditingController();
        capacitadorE = TextEditingController();
        capacitador2E = TextEditingController();
        cargo2E = TextEditingController();
        objetivoE = TextEditingController();
        poblacionE = TextEditingController();
        duracionE = TextEditingController();
        nivelE = TextEditingController();
        cargoE = TextEditingController();
        annioE = TextEditingController();
        programaE = TextEditingController();
        trimestreE = TextEditingController();
        textoConstanciaE = TextEditingController();
      });
      setState(() {
        actualizando = false;
      });

      return true;
    } else {
      setState(() {
        actualizando = false;
      });
      return false;
    }
  }

  Future apiSearch(BuildContext context) async {
    setState(() {
      getSearch = true;
    });
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/acciones/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listAcciones.data = resultSearch.data;
      });

      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.green, Icons.done, 'LISTA ACTUALIZADA', context);
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
    setState(() {
      getSearch = false;
    });
  }

  Future apiGetAcciones() async {
    listAcciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/acciones/home');

    return listAcciones.data;
  }

  Future apiGetAccionesAfterChanges() async {
    newListAcciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/acciones/home');
    if (newListAcciones.statusCode == 200) {
      setState(() {
        listAcciones.data = newListAcciones.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future apiGetTrimestres() async {
    listTrimestres =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/trimestres');

    return listTrimestres.data;
  }

  Future apiGetProgramas() async {
    listProgramas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/programas');

    return listProgramas.data;
  }

  void idElementSelected(element, lista, tipo) {
    switch (tipo) {
      case 'programa':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_programa'] == element) {
            setState(() {
              programaid = lista.data[i]['id'];
            });
          }
        }
        break;
      case 'trimestre':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['meses'] == element) {
            setState(() {
              trimestreid = lista.data[i]['id'];
            });
          }
        }
        break;
      default:
    }
  }

  void idElementUpdate(element, lista, tipo) {
    switch (tipo) {
      case 'programa':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_programa'] == element) {
            setState(() {
              programaidE = lista.data[i]['id'];
            });
          }
        }
        break;
      case 'trimestre':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['meses'] == element) {
            setState(() {
              trimestreidE = lista.data[i]['id'];
            });
          }
        }
        break;
      default:
    }
  }

  Future apiSearchRegisters(BuildContext context) async {
    setState(() {
      getRegisters = true;
    });

    listAccionesSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/acciones/search',
        queryParameters: {"buscar": buscarRegisters.text});

    if (listAccionesSearch.statusCode == 200) {
      listAcciones.data = listAccionesSearch.data;
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.green, Icons.done, 'Lista actualizada', context);
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }

    setState(() {
      getRegisters = false;
    });

    return resultSearch.data;
  }

  bool getSearch = false;
  bool getRegisters = false;

  late final Future getAcciones = apiGetAcciones();

  late final Future getTrimestres = apiGetTrimestres();
  late final Future getProgramas = apiGetProgramas();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAcciones,
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
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            SizedBox(
                              width: Adaptive.w(35),
                              child: TextFormField(
                                controller: buscarRegisters,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  apiSearchRegisters(context);
                                },
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          apiSearchRegisters(context);
                                        },
                                        child: getRegisters == false
                                            ? const Icon(Icons.search)
                                            : const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              )),
                                    focusColor: Colors.black,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    floatingLabelStyle: TextStyle(
                                        color: Styles.rojo,
                                        fontWeight: FontWeight.bold),
                                    label: const Text(
                                        'BUSCAR ACCION POR NOMBRE :')),
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            Expanded(child: Container()),
                            ElevatedButton.icon(
                                icon: const Icon(Icons.add),
                                style: Styles.buttonAddArtesano,
                                onPressed: () {
                                  _createAccion(context);
                                },
                                label: Text(
                                  "AGREGAR ACCION",
                                  style: TextStyle(fontSize: Adaptive.sp(11)),
                                ))
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(3),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adaptive.w(2)),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: Adaptive.w(20),
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
                                  width: Adaptive.w(15),
                                  child: Text(
                                    "PROGRAMA",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(22),
                                  child: Text(
                                    "CAPACITADOR",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(5),
                                  child: Text(
                                    "NIVEL",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(15),
                                  child: Text(
                                    "TRIMESTRE",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(6),
                                  child: Text(
                                    "AÑO",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        Column(
                          children: [
                            for (var item in listAcciones.data)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Adaptive.w(1)),
                                child: ExpansionTile(
                                  trailing: IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          programaidE = item['id_programa'];
                                          trimestreidE = item['id_trimestre'];
                                          nivelEdit = item['nivel'];
                                          accionId = item['id'];
                                          hintPrograma =
                                              item['nombre_programa'];
                                          hintNivel = item['nivel'];
                                          hintTrimestre = item['meses'];
                                          areaE.text = item['area'];
                                          nombbreE.text = item['nombre'];
                                          capacitadorE.text =
                                              item['capacitador'];
                                          cargoE.text = item['cargo'] ?? '';
                                          objetivoE.text = item['objetivo'];
                                          textoConstanciaE.text =
                                              item['texto_constancia'];
                                          poblacionE.text =
                                              item['poblacion_objetivo'];
                                          duracionE.text = item['duracion'];
                                          annioE.text = item['annio'];
                                        });

                                        _editAccion(context);
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Styles.rojo,
                                      )),
                                  title: Row(
                                    children: [
                                      SizedBox(
                                          width: Adaptive.w(20),
                                          child: Text(
                                            item['nombre'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(15),
                                          child: Text(
                                            item['nombre_programa'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(22),
                                          child: Text(
                                            item['capacitador'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(5),
                                          child: Text(
                                            item['nivel'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(15),
                                          child: Text(
                                            item['meses'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(6),
                                          child: Text(
                                            item['annio'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              : Image.asset("assets/images/cargando.gif");
        });
  }

  _createAccion(BuildContext context) {
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              width: Adaptive.w(80),
              height: Adaptive.h(10),
              color: Styles.rojo,
              child: const Center(
                child:
                    Text("CREAR ACCIÓN", style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(125),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          child: TextFormField(
                            controller: area,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("AREA :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(40),
                          child: TextFormField(
                            controller: nombbre,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("NOMBRE : "),
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
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: capacitador,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("CAPACITADOR :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: capacitador2,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("CAPACITADOR 2:"),
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
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: cargo,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CARGO :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: cargo2,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CARGO 2:"),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(40),
                          child: TextFormField(
                            controller: objetivo,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("OBJETIVO : "),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(30),
                          child: TextFormField(
                            controller: poblacion,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles()
                                .inputStyleArtesano("POBLACION OBJETIVO :"),
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
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(20),
                          child: TextFormField(
                            controller: annio,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            maxLength: 4,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("AÑO :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(25),
                          child: TextFormField(
                            controller: duracion,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            onChanged: (value) {},
                            decoration: Styles()
                                .inputStyleArtesano("DURACION (Horas) : "),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(25),
                          child: CustomDropDownII.search(
                            controller: nivel,
                            hintText: 'NIVEL',
                            selectedStyle: TextStyle(color: Styles.rojo),
                            errorText: 'Sin resultados',
                            onChanged: (p0) {},
                            borderSide: BorderSide(color: Styles.rojo),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            items: const [
                              'PRINCIPIANTE',
                              'INTERMEDIO',
                              'AVANZADO'
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          child: FutureBuilder(
                            future: getProgramas,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return snapshot.hasData
                                  ? SizedBox(
                                      width: Adaptive.w(30),
                                      child: CustomDropDownII.search(
                                        controller: programa,
                                        hintText: 'PROGRAMA',
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          idElementSelected(
                                              p0, listProgramas, 'programa');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listProgramas.data)
                                            item['nombre_programa']
                                        ],
                                      ),
                                    )
                                  : const LinearProgressIndicator();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(2),
                        ),
                        SizedBox(
                          width: Adaptive.w(15),
                          child: FutureBuilder(
                            future: getTrimestres,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return snapshot.hasData
                                  ? SizedBox(
                                      width: Adaptive.w(18),
                                      child: CustomDropDownII.search(
                                        controller: trimestre,
                                        hintText: 'TRIMESTRE',
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          idElementSelected(
                                              p0, listTrimestres, 'trimestre');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listTrimestres.data)
                                            item['meses']
                                        ],
                                      ),
                                    )
                                  : const LinearProgressIndicator();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(2),
                        ),
                        SizedBox(
                          width: Adaptive.w(30),
                          child: TextFormField(
                            controller: textoConstancia,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles()
                                .inputStyleArtesano("TEXTO DE CONSTANCIA : "),
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
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: Adaptive.w(80),
                child: agregando == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text("GUARDAR"),
                              onPressed: () async {
                                if (int.parse(annio.text) >
                                    int.parse(GlobalVariable.currentYear)) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'El año no puede ser superior al año en curso',
                                      context);
                                } else {
                                  if (await apiAddAccion(context) == true) {
                                    // ignore: use_build_context_synchronously
                                    Message().mensaje(Colors.green, Icons.done,
                                        'Acción añadida', context);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    apiGetAccionesAfterChanges();
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    Message().mensaje(
                                        Colors.red,
                                        Icons.error,
                                        'Error al agregar, actualiza e intenta de nuevo',
                                        context);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  }
                                }
                              }),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          ElevatedButton(
                              child: const Text("CANCELAR"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    : Center(
                        child: SizedBox(
                            width: Adaptive.w(2),
                            height: Adaptive.h(2),
                            child: CircularProgressIndicator(
                              color: Styles.rojo,
                            )),
                      ),
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
        barrierDismissible: false,
        barrierColor: Colors.white70);
  }

  _editAccion(BuildContext context) {
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              width: Adaptive.w(80),
              height: Adaptive.h(10),
              color: Styles.rojo,
              child: const Center(
                child: Text("EDITAR ACCIÓN",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(125),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          child: TextFormField(
                            controller: areaE,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("AREA :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(40),
                          child: TextFormField(
                            controller: nombbreE,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("NOMBRE : "),
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
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: capacitadorE,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("CAPACITADOR :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: capacitador2E,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("CAPACITADOR 2:"),
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
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: cargoE,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CARGO :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(33),
                          child: TextFormField(
                            controller: cargo2E,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CARGO 2:"),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(40),
                          child: TextFormField(
                            controller: objetivoE,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("OBJETIVO : "),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(30),
                          child: TextFormField(
                            controller: poblacionE,
                            maxLines: 2,
                            onChanged: (value) {},
                            decoration: Styles()
                                .inputStyleArtesano("POBLACION OBJETIVO :"),
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
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(20),
                          child: TextFormField(
                            controller: annioE,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            maxLength: 4,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("AÑO :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(25),
                          child: TextFormField(
                            controller: duracionE,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                            ],
                            onChanged: (value) {},
                            decoration: Styles()
                                .inputStyleArtesano("DURACION (Horas) : "),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(25),
                          child: CustomDropDownII(
                            controller: nivelE,
                            hintText: hintNivel,
                            selectedStyle: TextStyle(color: Styles.rojo),
                            errorText: 'Sin resultados',
                            onChanged: (p0) {
                              setState(() {
                                nivelEdit = p0;
                              });
                            },
                            borderSide: BorderSide(color: Styles.rojo),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            items: const [
                              'PRINCIPIANTE',
                              'INTERMEDIO',
                              'AVANZADO'
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          child: FutureBuilder(
                            future: getProgramas,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return snapshot.hasData
                                  ? SizedBox(
                                      width: Adaptive.w(35),
                                      child: CustomDropDownII.search(
                                        controller: programaE,
                                        hintText: hintPrograma,
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          idElementUpdate(
                                              p0, listProgramas, 'programa');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listProgramas.data)
                                            item['nombre_programa']
                                        ],
                                      ),
                                    )
                                  : const LinearProgressIndicator();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(2),
                        ),
                        SizedBox(
                          width: Adaptive.w(15),
                          child: FutureBuilder(
                            future: getTrimestres,
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return snapshot.hasData
                                  ? SizedBox(
                                      width: Adaptive.w(30),
                                      child: CustomDropDownII.search(
                                        controller: trimestreE,
                                        hintText: hintTrimestre,
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          idElementUpdate(
                                              p0, listTrimestres, 'trimestre');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listTrimestres.data)
                                            item['meses']
                                        ],
                                      ),
                                    )
                                  : const LinearProgressIndicator();
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(2),
                        ),
                        SizedBox(
                          width: Adaptive.w(20),
                          child: TextFormField(
                            controller: textoConstanciaE,
                            onChanged: (value) {},
                            decoration: Styles()
                                .inputStyleArtesano("TEXTO DE CONSTANCIA : "),
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
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: Adaptive.w(80),
                child: actualizando == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text("ACTUALIZAR"),
                              onPressed: () async {
                                if (await apiAEditAccion(context) == true) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Acción actualizada', context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  apiGetAccionesAfterChanges();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Error al actualizar, actualiza la página e intenta de nuevo',
                                      context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              }),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          ElevatedButton(
                              child: const Text("CANCELAR"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    : Center(
                        child: SizedBox(
                            width: Adaptive.w(2),
                            height: Adaptive.h(2),
                            child: CircularProgressIndicator(
                              color: Styles.rojo,
                            )),
                      ),
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
        barrierDismissible: false,
        barrierColor: Colors.white70);
  }
}
