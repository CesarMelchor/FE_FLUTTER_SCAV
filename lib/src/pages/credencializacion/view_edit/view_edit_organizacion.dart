import 'dart:async';

import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/providers/credenciales_provider.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ViewEditOrganizacionScreen extends StatefulWidget {
  const ViewEditOrganizacionScreen({super.key});

  @override
  State<ViewEditOrganizacionScreen> createState() =>
      _ViewEditOrganizacionScreenState();
}

class _ViewEditOrganizacionScreenState
    extends State<ViewEditOrganizacionScreen> {
  TextEditingController nombre = TextEditingController();
  TextEditingController nombreRepresentante = TextEditingController();
  TextEditingController rfc = TextEditingController();
  TextEditingController calle = TextEditingController();
  TextEditingController numExterior = TextEditingController();
  TextEditingController numInterior = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController distrito = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController localidad = TextEditingController();
  TextEditingController tiOrganizacion = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController totalHombres = TextEditingController();
  TextEditingController totalMujeres = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController rama = TextEditingController();
  TextEditingController producto = TextEditingController();

  String regionHi = "";
  String distritoHi = "";
  String municipioHi = "";
  String localidadHi = "";
  String ramaHi = "";
  String productoHi = "";
  String tipoOrganizacionHi = "";
  String tecnicaHi = "";

  String regionSe = "";
  String distritoSe = "";
  String municipioSe = "";
  String localidadSe = "";
  String ramaSe = "";
  String tecnicaSe = "";
  String productoSe = "";
  String tipoOrganizacionSe = "";

  Dio dio = Dio();

  Response dataOrganizacion = Response(requestOptions: RequestOptions());
  Response updateOrganizacion = Response(requestOptions: RequestOptions());

  Future<bool> apiUpdateOrganizacion(id, BuildContext context) async {
    updateOrganizacion = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/organizacion/update/$id',
        data: {
          "representante": nombreRepresentante.text,
          "nombre_organizacion": nombre.text,
          "rfc": rfc.text,
          "calle": calle.text,
          "num_exterior": numExterior.text,
          "num_interior": numInterior.text,
          "cp": cp.text,
          "id_region": regionSe,
          "id_distrito": distritoSe,
          "id_municipio": municipioSe,
          "id_localidad": localidadSe,
          "tel_fijo": telefono.text,
          "tel_celular": celular.text,
          "correo": correo.text,
          "hombres": totalHombres.text,
          "mujeres": totalMujeres.text,
          "updated_at": GlobalVariable.currentDate,
          "descripcion": descripcion.text,
          "tipo_org": tipoOrganizacionSe,
          "id_rama": ramaSe,
          "id_tecnica": tecnicaSe
        });

    if (updateOrganizacion.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Message().mensaje(
          Colors.green, Icons.done, 'Información actualizada', context);
      return true;
    } else {
      return false;
    }
  }

  bool estado = false;

  Future apigetOrganizacion() async {
    dataOrganizacion = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/organizacion/detail',
        queryParameters: {
          "organizacion": GlobalVariable.idOrganizacionEditCred
        });

    if (dataOrganizacion.statusCode == 200) {
      nombre.text = dataOrganizacion.data['nombre_organizacion'] ?? '';
      nombreRepresentante.text = dataOrganizacion.data['representante'] ?? '';
      rfc.text = dataOrganizacion.data['rfc'] ?? '';
      calle.text = dataOrganizacion.data['calle'] ?? '';
      numExterior.text = dataOrganizacion.data['num_exterior'] ?? '';
      numInterior.text = dataOrganizacion.data['num_interior'] ?? '';
      cp.text = dataOrganizacion.data['cp'] ?? '';
      correo.text = dataOrganizacion.data['correo'] ?? '';
      telefono.text = dataOrganizacion.data['tel_fijo'] ?? '';
      celular.text = dataOrganizacion.data['tel_celular'] ?? '';
      totalHombres.text = dataOrganizacion.data['hombres'] ?? '';
      totalMujeres.text = dataOrganizacion.data['mujeres'] ?? '';
      descripcion.text = dataOrganizacion.data['descripcion'] ?? '';
      setState(() {
        regionHi = dataOrganizacion.data['region'] ?? '';
        ramaHi = dataOrganizacion.data['nombre_rama'] ?? '';
        tecnicaHi = dataOrganizacion.data['nombre_subrama'] ?? '';
        regionSe = dataOrganizacion.data['id_region'] ?? '';
        distritoHi = dataOrganizacion.data['distrito'] ?? '';
        distritoSe = dataOrganizacion.data['id_distrito'] ?? '';
        municipioHi = dataOrganizacion.data['municipio'] ?? '';
        municipioSe = dataOrganizacion.data['id_municipio'] ?? '';
        localidadHi = dataOrganizacion.data['localidad'] ?? '';
        localidadSe = dataOrganizacion.data['id_localidad'] ?? '';
        ramaSe = dataOrganizacion.data['id_rama'];
        tecnicaSe = dataOrganizacion.data['id_tecnica'];
        tipoOrganizacionHi = dataOrganizacion.data['tipo_org'] ?? '';
        tipoOrganizacionSe = dataOrganizacion.data['tipo_org'] ?? '';
      });

      return dataOrganizacion.data;
    } else {
      setState(() {
        estado = true;
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Response listLocalidades = Response(requestOptions: RequestOptions());
  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response listDistritos = Response(requestOptions: RequestOptions());
  Response listRegiones = Response(requestOptions: RequestOptions());
  Response listRamas = Response(requestOptions: RequestOptions());
  Response listTecnicas = Response(requestOptions: RequestOptions());

  Future apiGetLocalidades() async {
    listLocalidades =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/localidades/all');

    return listLocalidades.data;
  }

  Future apiGetMunicipios() async {
    listMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios');

    return listMunicipios.data;
  }

  Future apiGetDistritos() async {
    listDistritos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/distritos');

    return listDistritos.data;
  }

  Future apiGetRegiones() async {
    listRegiones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones');

    return listRegiones.data;
  }

  Future apiGetRamas() async {
    listRamas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/ramas');

    return listRamas.data;
  }

  Future apiGetTecnicas() async {
    listTecnicas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/tecnicas');

    return listTecnicas.data;
  }

  void idElementUpdated(element, lista, caso) {
    switch (caso) {
      case 'region':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['region'] == element) {
            setState(() {
              regionSe = lista.data[i]['id_region'];
            });
          }
        }
        break;

      case 'municipio':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['municipio'] == element) {
            setState(() {
              municipioSe = lista.data[i]['id_municipio'];
            });
          }
        }
        break;

      case 'distrito':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['distrito'] == element) {
            setState(() {
              distritoSe = lista.data[i]['id_distrito'];
            });
          }
        }
        break;

      case 'localidad':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['localidad'] == element) {
            setState(() {
              localidadSe = lista.data[i]['id_localidad'];
            });
          }
        }
        break;
      default:
    }
  }

  late final Future getDistritos = apiGetDistritos();
  late final Future getMunicipios = apiGetMunicipios();
  late final Future getRegiones = apiGetRegiones();
  late final Future getRamas = apiGetRamas();
  late final Future getTecnicas = apiGetTecnicas();
  bool getEditing = false;
  late final Future getOrganizacion = apigetOrganizacion();
  late final Future getLocalidades = apiGetLocalidades();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOrganizacion,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                              icon: const Icon(Icons.edit),
                              style: Styles().buttonEditOrganizacion(context),
                              onPressed: () {
                                context
                                    .read<CredencialProvider>()
                                    .setButtonEditOrganizacion();
                              },
                              label: Text(
                                "EDITAR",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                          SizedBox(
                            width: Adaptive.w(27),
                          ),
                          Text(
                            "VER / EDITAR INFORMACION DE ORGANIZACION",
                            style: TextStyle(
                                color: Styles.crema2,
                                fontSize: Adaptive.sp(14)),
                          ),
                          Expanded(child: Container()),
                          ElevatedButton.icon(
                              icon: const Icon(Icons.format_list_bulleted),
                              style: Styles.buttonAddArtesano,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("organizaciones");
                              },
                              label: Text(
                                "LISTA DE ORGANIZACIONES",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Adaptive.w(1), vertical: Adaptive.h(3)),
                        child: Container(
                          decoration: Styles().containerAdArtesano,
                          padding: EdgeInsets.symmetric(
                              horizontal: Adaptive.w(2),
                              vertical: Adaptive.h(3)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      controller: nombre,
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
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
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: nombreRepresentante,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles().inputStyleArtesano(
                                          "NOMBRE DEL REPRESENTANTE"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      controller: rfc,
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(12),
                                      ],
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("RFC"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adaptive.h(3),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: Adaptive.w(27),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: calle,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("CALLE"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(12),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: numInterior,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("NUM. INTERIOR"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(12),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: numExterior,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("NUM. EXTERIOR"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(10),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: cp,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(5),
                                      ],
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("CP"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(27),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                      future: getRegiones,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller: region,
                                                hintText: regionHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(p0,
                                                      listRegiones, 'region');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listRegiones.data)
                                                    item['region']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
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
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                      future: getDistritos,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller: distrito,
                                                hintText: distritoHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0,
                                                      listDistritos,
                                                      'distrito');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listDistritos.data)
                                                    item['distrito']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                      future: getMunicipios,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller: municipio,
                                                hintText: municipioHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0,
                                                      listMunicipios,
                                                      'municipio');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listMunicipios.data)
                                                    item['municipio']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                      future: getLocalidades,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller: localidad,
                                                hintText: localidadHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0,
                                                      listLocalidades,
                                                      'localidad');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listLocalidades.data)
                                                    item['localidad']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adaptive.h(3),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: correo,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
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
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: celular,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("TELEFONO MOVIL"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: telefono,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("TELEFONO LOCAL"),
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
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: totalHombres,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles().inputStyleArtesano(
                                          "TOTAL DE HOMBRES"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: totalMujeres,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles().inputStyleArtesano(
                                          "TOTAL DE MUJERES"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Este campo no puede estar vacío";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: CustomDropDownII.search(
                                      controller: tiOrganizacion,
                                      hintText: tipoOrganizacionHi,
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        setState(() {
                                          tipoOrganizacionSe = p0;
                                        });
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      items: const ['ONG', 'PUBLICA'],
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
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                      future: getRamas,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller: rama,
                                                hintText: ramaHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {},
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listRamas.data)
                                                    item['nombre_rama']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                      future: getTecnicas,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller: producto,
                                                hintText: tecnicaHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {},
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listTecnicas.data)
                                                    item['nombre_subrama']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .editOrganizacion,
                                      controller: descripcion,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("DESCRIPCION"),
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
                                height: Adaptive.h(12),
                              ),
                              Center(
                                  child: OutlinedLoadingButton(
                                      isLoading: getEditing,
                                      loadingIcon: const Icon(Icons.update),
                                      loadingLabel:
                                          const Text('Actualizando...'),
                                      style: Styles.buttonStyleCred,
                                      onPressed: context
                                                  .watch<CredencialProvider>()
                                                  .editOrganizacion ==
                                              false
                                          ? null
                                          : () async {
                                              setState(() {
                                                getEditing = true;
                                              });
                                              if (await apiUpdateOrganizacion(
                                                      dataOrganizacion.data[
                                                          'id_organizacion'],
                                                      context) ==
                                                  true) {
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pushNamed(
                                                    "organizaciones");
                                              }
                                              setState(() {
                                                getEditing = false;
                                              });
                                            },
                                      child: const Text("GUARDAR"))),
                              SizedBox(
                                height: Adaptive.h(3),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Image.asset("assets/images/cargando.gif");
        });
  }
}
