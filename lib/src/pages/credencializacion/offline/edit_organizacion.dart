import 'dart:async';
import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/providers/credenciales_provider.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/data/offline.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ViewEditOrganizacionOfflineScreen extends StatefulWidget {
  const ViewEditOrganizacionOfflineScreen({super.key});

  @override
  State<ViewEditOrganizacionOfflineScreen> createState() =>
      _ViewEditOrganizacionOfflineScreenState();
}

class _ViewEditOrganizacionOfflineScreenState
    extends State<ViewEditOrganizacionOfflineScreen> {
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

  String regionSe = "";
  String distritoSe = "";
  String municipioSe = "";
  String localidadSe = "";
  String ramaSe = "";
  String productoSe = "";
  String tipoOrganizacionSe = "";

  // ignore: prefer_typing_uninitialized_variables
  var dataOrganizacion;

  Future<bool> apiUpdateOrganizacion(id, BuildContext context) async {

     for (var i = 0; i < Offline.organizacionesList.length; i++) {
      if (Offline.organizacionesList[i]['id_organizacion'] == id) {
        
        Offline.organizacionesList[i]['representante'] = nombreRepresentante.text;
        Offline.organizacionesList[i]['nombre_organizacion'] = nombre.text;
        Offline.organizacionesList[i]['rfc'] = rfc.text;
        Offline.organizacionesList[i]['calle'] = calle.text;
        Offline.organizacionesList[i]['num_exterior'] = numExterior.text;
        Offline.organizacionesList[i]['num_interior'] = numInterior.text;
        Offline.organizacionesList[i]['cp'] = cp.text;
        Offline.organizacionesList[i]['id_region'] = regionSe;
        Offline.organizacionesList[i]['id_distrito'] = distritoSe;
        Offline.organizacionesList[i]['id_municipio'] = municipioSe;
        Offline.organizacionesList[i]['id_localidad'] = localidadSe;
        Offline.organizacionesList[i]['tel_fijo'] = telefono.text;
        Offline.organizacionesList[i]['tel_celular'] = celular.text;
        Offline.organizacionesList[i]['correo'] = correo.text;
        Offline.organizacionesList[i]['hombres'] = totalHombres.text;
        Offline.organizacionesList[i]['mujeres'] = totalMujeres.text;
        Offline.organizacionesList[i]['descripcion'] = descripcion.text;
        Offline.organizacionesList[i]['tipo_org'] = tipoOrganizacionSe;
        Offline.organizacionesList[i]['updated_at'] = GlobalVariable.currentDate;
      }
    }

      // ignore: use_build_context_synchronously
      Message().mensaje(
          Colors.green, Icons.done, 'Información actualizada', context);
      return true;
  
  }

  bool estado = false;

  List localidades = Offline.localidades;
  List municipios = Offline.municipios;
  List distritos = Offline.distritos;
  List regiones = Offline.regiones;
  List ramas = Offline.ramas;
  List tecnicas = Offline.subramas;

  var regionT = "";
  var municipioT = "";
  var localidadT = "";
  var distritoT = "";

  Future apigetOrganizacion() async {
    for (var i = 0; i < Offline.organizacionesList.length; i++) {
      if (Offline.organizacionesList[i]['id_organizacion'] ==
          GlobalVariable.idOrganizacionEditCred) {
        dataOrganizacion = Offline.organizacionesList[i];
      }
    }

    for (var i = 0; i < Offline.regiones.length; i++) {
      if (Offline.regiones[i]['id_region'] == dataOrganizacion['id_region']) {
        regionT = Offline.regiones[i]['region'];
      }
    }

    for (var i = 0; i < Offline.municipios.length; i++) {
      if (Offline.municipios[i]['id_municipio'] ==
          dataOrganizacion['id_municipio']) {
        municipioT = Offline.municipios[i]['municipio'];
      }
    }

    for (var i = 0; i < Offline.localidades.length; i++) {
      if (Offline.localidades[i]['id_localidad'] ==
          dataOrganizacion['id_localidad']) {
        localidadT = Offline.localidades[i]['localidad'];
      }
    }

    for (var i = 0; i < Offline.distritos.length; i++) {
      if (Offline.distritos[i]['id_distrito'] ==
          dataOrganizacion['id_distrito']) {
        distritoT = Offline.distritos[i]['distrito'];
      }
    }

    nombre.text = dataOrganizacion['nombre_organizacion'];
    nombreRepresentante.text = dataOrganizacion['representante'];
    rfc.text = dataOrganizacion['rfc'];
    calle.text = dataOrganizacion['calle'];
    numExterior.text = dataOrganizacion['num_exterior'];
    numInterior.text = dataOrganizacion['num_interior'];
    cp.text = dataOrganizacion['cp'];
    correo.text = dataOrganizacion['correo'];
    telefono.text = dataOrganizacion['tel_fijo'];
    celular.text = dataOrganizacion['tel_celular'];
    totalHombres.text = dataOrganizacion['hombres'];
    totalMujeres.text = dataOrganizacion['mujeres'];
    descripcion.text = dataOrganizacion['descripcion'];
    setState(() {
      regionHi = regionT;
      regionSe = dataOrganizacion['id_region'];
      distritoHi = distritoT;
      distritoSe = dataOrganizacion['id_distrito'];
      municipioHi = municipioT;
      municipioSe = dataOrganizacion['id_municipio'];
      localidadHi = localidadT;
      localidadSe = dataOrganizacion['id_localidad'];
      tipoOrganizacionHi = dataOrganizacion['tipo_org'];
      tipoOrganizacionSe = dataOrganizacion['tipo_org'];
    });
  }

  @override
  void initState() {
    super.initState();
    apigetOrganizacion();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void idElementUpdated(element, lista, caso) {
    switch (caso) {
      case 'region':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['region'] == element) {
            setState(() {
              regionSe = lista[i]['id_region'];
            });
          }
        }
        break;

      case 'municipio':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['municipio'] == element) {
            setState(() {
              municipioSe = lista[i]['id_municipio'];
            });
          }
        }
        break;

      case 'distrito':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['distrito'] == element) {
            setState(() {
              distritoSe = lista[i]['id_distrito'];
            });
          }
        }
        break;

      case 'localidad':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['localidad'] == element) {
            setState(() {
              localidadSe = lista[i]['id_localidad'];
            });
          }
        }
        break;
      default:
    }
  }

  bool getEditing = false;

  @override
  Widget build(BuildContext context) {
    return Form(
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
                style:
                    TextStyle(color: Styles.crema2, fontSize: Adaptive.sp(14)),
              ),
              Expanded(child: Container()),
              ElevatedButton.icon(
                  icon: const Icon(Icons.format_list_bulleted),
                  style: Styles.buttonAddArtesano,
                  onPressed: () {
                    Navigator.of(context).pushNamed("organizaciones");
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
                  horizontal: Adaptive.w(2), vertical: Adaptive.h(3)),
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
                          decoration: Styles().inputStyleArtesano("NOMBRE"),
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
                          decoration: Styles()
                              .inputStyleArtesano("NOMBRE DEL REPRESENTANTE"),
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
                          decoration: Styles().inputStyleArtesano("RFC"),
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
                          decoration: Styles().inputStyleArtesano("CALLE"),
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
                          decoration:
                              Styles().inputStyleArtesano("NUM. INTERIOR"),
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
                          decoration:
                              Styles().inputStyleArtesano("NUM. EXTERIOR"),
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
                          decoration: Styles().inputStyleArtesano("CP"),
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
                        child: CustomDropDownII.search(
                          controller: region,
                          hintText: regionHi,
                          selectedStyle: TextStyle(color: Styles.rojo),
                          errorText: 'Sin resultados',
                          onChanged: (p0) {
                            idElementUpdated(p0, regiones, 'region');
                          },
                          borderSide: BorderSide(color: Styles.rojo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          items: [for (var item in regiones) item['region']],
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
                        child: CustomDropDownII.search(
                          controller: distrito,
                          hintText: distritoHi,
                          selectedStyle: TextStyle(color: Styles.rojo),
                          errorText: 'Sin resultados',
                          onChanged: (p0) {
                            idElementUpdated(p0, distritos, 'distrito');
                          },
                          borderSide: BorderSide(color: Styles.rojo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          items: [for (var item in distritos) item['distrito']],
                        ),
                      ),
                      SizedBox(
                        width: Adaptive.w(1),
                      ),
                      SizedBox(
                        width: Adaptive.w(30),
                            height: Adaptive.h(5),
                        child: CustomDropDownII.search(
                          controller: municipio,
                          hintText: municipioHi,
                          selectedStyle: TextStyle(color: Styles.rojo),
                          errorText: 'Sin resultados',
                          onChanged: (p0) {
                            idElementUpdated(p0, municipios, 'municipio');
                          },
                          borderSide: BorderSide(color: Styles.rojo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          items: [
                            for (var item in municipios) item['municipio']
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Adaptive.w(1),
                      ),
                      SizedBox(
                        width: Adaptive.w(30),
                            height: Adaptive.h(5),
                        child: CustomDropDownII.search(
                          controller: localidad,
                          hintText: localidadHi,
                          selectedStyle: TextStyle(color: Styles.rojo),
                          errorText: 'Sin resultados',
                          onChanged: (p0) {
                            idElementUpdated(p0, localidades, 'localidad');
                          },
                          borderSide: BorderSide(color: Styles.rojo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          items: [
                            for (var item in localidades) item['localidad']
                          ],
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
                          decoration: Styles().inputStyleArtesano("CORREO"),
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
                          decoration:
                              Styles().inputStyleArtesano("TELEFONO MOVIL"),
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
                          decoration:
                              Styles().inputStyleArtesano("TELEFONO LOCAL"),
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
                          decoration:
                              Styles().inputStyleArtesano("TOTAL DE HOMBRES"),
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
                          decoration:
                              Styles().inputStyleArtesano("TOTAL DE MUJERES"),
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
                          selectedStyle: TextStyle(color: Styles.rojo),
                          errorText: 'Sin resultados',
                          onChanged: (p0) {
                            setState(() {
                              tipoOrganizacionSe = p0;
                            });
                          },
                          borderSide: BorderSide(color: Styles.rojo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
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
                        child: CustomDropDownII.search(
                          controller: rama,
                          hintText: 'RAMA / EN PROCESO DE ADAPTACION',
                          selectedStyle: TextStyle(color: Styles.rojo),
                          errorText: 'Sin resultados',
                          onChanged: (p0) {},
                          borderSide: BorderSide(color: Styles.rojo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          items: [
                            for (var item in ramas) item['nombre_rama']
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Adaptive.w(1),
                      ),
                      SizedBox(
                        width: Adaptive.w(30),
                            height: Adaptive.h(5),
                        child: CustomDropDownII.search(
                          controller: producto,
                          hintText: 'Producto/EN PROCESO DE ADAPTACION',
                          selectedStyle: TextStyle(color: Styles.rojo),
                          errorText: 'Sin resultados',
                          onChanged: (p0) {},
                          borderSide: BorderSide(color: Styles.rojo),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          items: [
                            for (var item in tecnicas)
                              item['nombre_subrama']
                          ],
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
                          decoration:
                              Styles().inputStyleArtesano("DESCRIPCION"),
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
                          loadingLabel: const Text('Actualizando...'),
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
                                          dataOrganizacion['id_organizacion'],
                                          context) ==
                                      true) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context)
                                        .pushNamed("organizaciones");
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
    );
  }
}
