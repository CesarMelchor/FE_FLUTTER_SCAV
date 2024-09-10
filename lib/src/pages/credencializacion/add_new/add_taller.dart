import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/styles.dart';

class AddTallerScreen extends StatefulWidget {
  const AddTallerScreen({super.key});

  @override
  State<AddTallerScreen> createState() => _AddTallerScreenState();
}

class _AddTallerScreenState extends State<AddTallerScreen> {
  
  TextEditingController nombre = TextEditingController();
  TextEditingController nombreRepresentante = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController distrito = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController localidad = TextEditingController();
  TextEditingController calle = TextEditingController();
  TextEditingController numExterior = TextEditingController();
  TextEditingController numInterior = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController totalHombres = TextEditingController();
  TextEditingController totalMujeres = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: [
              Row(
                children: [
                  ElevatedButton.icon(
                icon: const Icon(Icons.format_list_bulleted),
                style: Styles.buttonListArtesano,
                  onPressed: () {
                    Navigator.of(context).pushNamed("listTalleres");
                  },
                  label: Text("LISTA DE TALLERES", style: TextStyle(fontSize: Adaptive.sp(11)),)
                  ),
                  SizedBox(width: Adaptive.w(27),),
                  Text("AGREGAR TALLER", style: TextStyle(color: Styles.crema2, fontSize: Adaptive.sp(14)),),
                ],
              ),
            Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(1), vertical: Adaptive.h(3)),
              child: Container(
                      decoration: Styles().containerAdArtesano,
                      padding: EdgeInsets.symmetric(
              horizontal: Adaptive.w(2), vertical: Adaptive.h(3)),
                child: Column(
                  children: [
                    Row(
                          children: [
                          SizedBox(
                            width: Adaptive.w(45),
                            child: TextFormField(
                    controller: nombre,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("NOMBRE"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                          SizedBox(width: Adaptive.w(1),),
                          SizedBox(
                            width: Adaptive.w(46),
                            child: TextFormField(
                    controller: nombreRepresentante,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("NOMBRE DEL REPRESENTANTE"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                          SizedBox(width: Adaptive.w(1),),
                    ],),
                    SizedBox(height: Adaptive.h(3),),
                    
                      Row(
                        children: [
                          SizedBox(
                            width: Adaptive.w(27),
                            child: TextFormField(
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
                            child: TextFormField(
                              controller: numInterior,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles().inputStyleArtesano("NUM. INTERIOR"),
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
                            child: TextFormField(
                              controller: numExterior,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles().inputStyleArtesano("NUM. EXTERIOR"),
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
                            child: TextFormField(
                              controller: cp,
                              inputFormatters: [
                                CapitalLetters(),
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
                            child: TextFormField(
                              controller: localidad,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles().inputStyleArtesano("LOCALIDAD"),
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
                            child: TextFormField(
                              controller: municipio,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles().inputStyleArtesano("MUNICIPIO"),
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
                            child: TextFormField(
                              controller: distrito,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles().inputStyleArtesano("DISTRITO"),
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
                            child: TextFormField(
                              controller: region,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles().inputStyleArtesano("REGION"),
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
                    SizedBox(height: Adaptive.h(3),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(
                            width: Adaptive.w(30),
                            child: TextFormField(
                    controller: correo,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("CORREO"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                          SizedBox(width: Adaptive.w(1),),
                          SizedBox(
                            width: Adaptive.w(30),
                            child: TextFormField(
                    controller: celular,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("TELEFONO MOVIL"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                          SizedBox(width: Adaptive.w(1),),
                          SizedBox(
                            width: Adaptive.w(30),
                            child: TextFormField(
                    controller: telefono,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("TELEFONO LOCAL"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                    ],),
                    SizedBox(height: Adaptive.h(3),),
                    Row(
                      children: [
                        SizedBox(
                            width: Adaptive.w(30),
                            child: TextFormField(
                    controller: totalHombres,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("TOTAL DE HOMBRES"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                          SizedBox(width: Adaptive.w(1),),
                      SizedBox(
                            width: Adaptive.w(30),
                            child: TextFormField(
                    controller: totalMujeres,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("TOTAL DE MUJERES"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                          SizedBox(width: Adaptive.w(1),),
                      SizedBox(
                            width: Adaptive.w(30),
                            child: TextFormField(
                    controller: descripcion,
                    inputFormatters: [
                    CapitalLetters(),
                    ],
                    onChanged: (value) {
                      
                    },
                    decoration: Styles().inputStyleArtesano("DESCRIPCION"),
                    validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                            ),
                          ),
                    ],),
                          SizedBox(height: Adaptive.h(6),),
                          Center(child: OutlinedButton(
                            style: Styles.buttonStyleCred,
                            onPressed: (){}, child: const Text("GUARDAR"))),
                          SizedBox(height: Adaptive.h(3),),
                  ],
                ),
              ),
            )
        ],),
      )
    ;
  }
}