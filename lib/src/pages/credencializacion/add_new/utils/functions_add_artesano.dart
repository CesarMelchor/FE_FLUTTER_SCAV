import 'package:flutter/material.dart';
import 'package:scav/src/pages/credencializacion/add_new/utils/variables_add_artesano.dart';

class FunctionAddArtesano {
  static void clean() {
    
    VarAddArtesano.fullRedes = " < < < < ";
    VarAddArtesano.sexoSelected = "";
    VarAddArtesano.nombre = TextEditingController();
    VarAddArtesano.paterno = TextEditingController();
    VarAddArtesano.materno = TextEditingController();
    VarAddArtesano.nacimiento = TextEditingController();
    VarAddArtesano.sexo = TextEditingController();
    VarAddArtesano.estadoCivil = TextEditingController();
    VarAddArtesano.curp = TextEditingController();
    VarAddArtesano.claveElector = TextEditingController();
    VarAddArtesano.rfc = TextEditingController();
    VarAddArtesano.telefono = TextEditingController();
    VarAddArtesano.celular = TextEditingController();
    VarAddArtesano.recados = TextEditingController();
    VarAddArtesano.correo = TextEditingController();
    VarAddArtesano.escolaridad = TextEditingController();
    VarAddArtesano.region = TextEditingController();
    VarAddArtesano.distrito = TextEditingController();
    VarAddArtesano.municipio = TextEditingController();
    VarAddArtesano.localidad = TextEditingController();
    VarAddArtesano.calle = TextEditingController();
    VarAddArtesano.numExterior = TextEditingController();
    VarAddArtesano.numInterior = TextEditingController();
    VarAddArtesano.cp = TextEditingController();
    VarAddArtesano.redesSociales = TextEditingController();
    VarAddArtesano.etnia = TextEditingController();
    VarAddArtesano.rama = TextEditingController();
    VarAddArtesano.tecnica = TextEditingController();
    VarAddArtesano.materiaPrima = TextEditingController();
    VarAddArtesano.ventaProducto = TextEditingController();
    VarAddArtesano.tipoComprador = TextEditingController();
    VarAddArtesano.comentarios = TextEditingController();
    VarAddArtesano.observaciones = TextEditingController();
    VarAddArtesano.tipoInscripcion = TextEditingController();
    VarAddArtesano.canalComercializacion = TextEditingController();
    VarAddArtesano.tallerT = TextEditingController();
    VarAddArtesano.searching = TextEditingController();

    //taller

    VarAddArtesano.nombreT = TextEditingController();
    VarAddArtesano.nombreRepresentanteT = TextEditingController();
    VarAddArtesano.rfcT = TextEditingController();
    VarAddArtesano.regionT = TextEditingController();
    VarAddArtesano.distritoT = TextEditingController();
    VarAddArtesano.municipioT = TextEditingController();
    VarAddArtesano.localidadT = TextEditingController();
    VarAddArtesano.calleT = TextEditingController();
    VarAddArtesano.numExteriorT = TextEditingController();
    VarAddArtesano.numInteriorT = TextEditingController();
    VarAddArtesano.cpT = TextEditingController();
    VarAddArtesano.correoT = TextEditingController();
    VarAddArtesano.telefonoT = TextEditingController();
    VarAddArtesano.celularT = TextEditingController();
    VarAddArtesano.totalHombresT = TextEditingController();
    VarAddArtesano.totalMujeresT = TextEditingController();
    VarAddArtesano.ramaT = TextEditingController();
    VarAddArtesano.tecnicaT = TextEditingController();
    VarAddArtesano.tipoOrganizacionT = TextEditingController();
    VarAddArtesano.descripcionT = TextEditingController();
    VarAddArtesano.talleres = TextEditingController();

    //organizacion
    VarAddArtesano.nombreO = TextEditingController();
    VarAddArtesano.nombreRepresentanteO = TextEditingController();
    VarAddArtesano.rfcO = TextEditingController();
    VarAddArtesano.regionO = TextEditingController();
    VarAddArtesano.distritoO = TextEditingController();
    VarAddArtesano.municipioO = TextEditingController();
    VarAddArtesano.localidadO = TextEditingController();
    VarAddArtesano.calleO = TextEditingController();
    VarAddArtesano.numExteriorO = TextEditingController();
    VarAddArtesano.numInteriorO = TextEditingController();
    VarAddArtesano.cpO = TextEditingController();
    VarAddArtesano.correoO = TextEditingController();
    VarAddArtesano.telefonoO = TextEditingController();
    VarAddArtesano.celularO = TextEditingController();
    VarAddArtesano.totalHombresO = TextEditingController();
    VarAddArtesano.totalMujeresO = TextEditingController();
    VarAddArtesano.ramaO = TextEditingController();
    VarAddArtesano.tecnicaO = TextEditingController();
    VarAddArtesano.tipoOrganizacionO = TextEditingController();
    VarAddArtesano.descripcionO = TextEditingController();
    VarAddArtesano.agrupacionO = TextEditingController();

    VarAddArtesano.tipoIns = "";
    VarAddArtesano.familiar = false;
    VarAddArtesano.grupal = false;

    VarAddArtesano.idGrupo = "";
    VarAddArtesano.idMateria = "";
    VarAddArtesano.idComprador = "";

    VarAddArtesano.idTallerCreated = "";
    VarAddArtesano.idAgrupacion = "";
    VarAddArtesano.idLengua = "";

    VarAddArtesano.idLocalidadArtesano = "";
    VarAddArtesano.idLocalidadTaller = "";
    VarAddArtesano.idLocalidadAgrupacion = "";

    VarAddArtesano.idDistritoArtesano = "";
    VarAddArtesano.idDistritoTaller = "";
    VarAddArtesano.idDistritoAgrupacion = "";

    VarAddArtesano.idMunicipioArtesano = "";
    VarAddArtesano.idMunicipioTaller = "";
    VarAddArtesano.idMunicipioAgrupacion = "";

    VarAddArtesano.idRegionArtesano = "";
    VarAddArtesano.idRegionTaller = "";
    VarAddArtesano.idRegionAgrupacion = "";

    VarAddArtesano.idRamaArtesano = "";
    VarAddArtesano.idRamaTaller = "";
    VarAddArtesano.idRamaAgrupacion = "";

    VarAddArtesano.idTecnicaArtesano = "";
    VarAddArtesano.idTecnicaTaller = "";
    VarAddArtesano.idTecnicaAgrupacion = "";
    VarAddArtesano.addTaller = false;
    VarAddArtesano.addGrupo = false;
  }

  static void idLocalidadSelected(localidad, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['localidad'] == localidad) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idLocalidadArtesano = lista[i]['id_localidad'];
            break;
          case 'taller':
            VarAddArtesano.idLocalidadTaller = lista[i]['id_localidad'];
            break;
          case 'grupo':
            VarAddArtesano.idLocalidadAgrupacion =
                lista[i]['id_localidad'];
            break;
          default:
        }
      }
    }
  }

  static void idLocalidadSelectedOffline(localidad, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['localidad'] == localidad) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idLocalidadArtesano = lista[i]['id_localidad'];
            break;
          case 'taller':
            VarAddArtesano.idLocalidadTaller = lista[i]['id_localidad'];
            break;
          case 'grupo':
            VarAddArtesano.idLocalidadAgrupacion =
                lista[i]['id_localidad'];
            break;
          default:
        }
      }
    }
  }

  static void idDistritoSelected(distrito, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['distrito'] == distrito) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idDistritoArtesano = lista[i]['id_distrito'];
            break;
          case 'taller':
            VarAddArtesano.idDistritoTaller = lista[i]['id_distrito'];

            break;
          case 'grupo':
            VarAddArtesano.idDistritoAgrupacion = lista[i]['id_distrito'];
            break;
          default:
        }
      }
    }
  }

  static void idDistritoSelectedOffline(distrito, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['distrito'] == distrito) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idDistritoArtesano = lista[i]['id_distrito'];
            break;
          case 'taller':
            VarAddArtesano.idDistritoTaller = lista[i]['id_distrito'];

            break;
          case 'grupo':
            VarAddArtesano.idDistritoAgrupacion = lista[i]['id_distrito'];
            break;
          default:
        }
      }
    }
  }

  static void idMunicipioSelected(municipio, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['municipio'] == municipio) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idMunicipioArtesano = lista[i]['id_municipio'];
            break;
          case 'taller':
            VarAddArtesano.idMunicipioTaller = lista[i]['id_municipio'];
            break;
          case 'agrupacion':
            VarAddArtesano.idMunicipioAgrupacion =
                lista[i]['id_municipio'];
            break;
          default:
        }
      }
    }
  }

  static void idMunicipioSelectedOffline(municipio, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['municipio'] == municipio) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idMunicipioArtesano = lista[i]['id_municipio'];
            break;
          case 'taller':
            VarAddArtesano.idMunicipioTaller = lista[i]['id_municipio'];
            break;
          case 'agrupacion':
            VarAddArtesano.idMunicipioAgrupacion =
                lista[i]['id_municipio'];
            break;
          default:
        }
      }
    }
  }

  static void idRegionSelected(region, tipo, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['region'] == region) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idRegionArtesano = lista.data[i]['id_region'];
            break;
          case 'taller':
            VarAddArtesano.idRegionTaller = lista.data[i]['id_region'];
            break;
          case 'agrupacion':
            VarAddArtesano.idRegionAgrupacion = lista.data[i]['id_region'];
            break;
          default:
        }
      }
    }
  }

  static void idRegionSelectedOffline(region, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['region'] == region) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idRegionArtesano = lista[i]['id_region'];
            break;
          case 'taller':
            VarAddArtesano.idRegionTaller = lista[i]['id_region'];
            break;
          case 'agrupacion':
            VarAddArtesano.idRegionAgrupacion = lista[i]['id_region'];
            break;
          default:
        }
      }
    }
  }

  static void idRamaSelected(rama, tipo, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre_rama'] == rama) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idRamaArtesano = lista.data[i]['id_rama'];
            break;
          case 'taller':
            VarAddArtesano.idRamaTaller = lista.data[i]['id_rama'];
            break;
          case 'agrupacion':
            VarAddArtesano.idRamaAgrupacion = lista.data[i]['id_rama'];
            break;
          default:
        }
      }
    }
  }

  static void idRamaSelectedOffline(rama, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['nombre_rama'] == rama) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idRamaArtesano = lista[i]['id_rama'];
            break;
          case 'taller':
            VarAddArtesano.idRamaTaller = lista[i]['id_rama'];
            break;
          case 'agrupacion':
            VarAddArtesano.idRamaAgrupacion = lista[i]['id_rama'];
            break;
          default:
        }
      }
    }
  }

  static void idTecnicaSelected(tecnica, tipo, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre_subrama'] == tecnica) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idTecnicaArtesano = lista.data[i]['id_subrama'];
            break;
          case 'taller':
            VarAddArtesano.idTecnicaTaller = lista.data[i]['id_subrama'];
            break;
          case 'agrupacion':
            VarAddArtesano.idTecnicaAgrupacion = lista.data[i]['id_subrama'];
            break;
          default:
        }
      }
    }
  }

  static void idTecnicaSelectedOffline(tecnica, tipo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['nombre_subrama'] == tecnica) {
        switch (tipo) {
          case 'artesano':
            VarAddArtesano.idTecnicaArtesano = lista[i]['id_subrama'];
            break;
          case 'taller':
            VarAddArtesano.idTecnicaTaller = lista[i]['id_subrama'];
            break;
          case 'agrupacion':
            VarAddArtesano.idTecnicaAgrupacion = lista[i]['id_subrama'];
            break;
          default:
        }
      }
    }
  }

  static void idGrupoSelected(grupo, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre_etnia'] == grupo) {
        VarAddArtesano.idGrupo = lista.data[i]['id_grupo'];
      }
    }
  }

  static void idGrupoSelectedOffline(grupo, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['nombre_etnia'] == grupo) {
        VarAddArtesano.idGrupo = lista[i]['id_grupo'];
      }
    }
  }

  static void idOrganizacionSelected(organizacion, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre_organizacion'] == organizacion) {
        VarAddArtesano.idAgrupacion = lista.data[i]['id_organizacion'];
      }
    }
  }

  static void idOrganizacionSelectedOffline(organizacion, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['nombre_organizacion'] == organizacion) {
        VarAddArtesano.idAgrupacion = lista[i]['id_organizacion'];
      }
    }
  }

  static void idMateriaSelected(materia, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre'] == materia) {
        VarAddArtesano.idMateria = lista.data[i]['id_materiap'];
      }
    }
  }
  static void idLenguaSelected(lengua, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['lengua'] == lengua) {
        VarAddArtesano.idLengua = lista.data[i]['id_lengua'];
      }
    }
  }

  static void idMateriaSelectedOffline(materia, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['nombre'] == materia) {
        VarAddArtesano.idMateria = lista[i]['id_materiap'];
      }
    }
  }

  static void idCanalSelected(comprador, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre'] == comprador) {
        VarAddArtesano.idComprador = lista.data[i]['id_tipo_comprador'];
      }
    }
  }

  static void idCanalSelectedOffline(comprador, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['nombre'] == comprador) {
        VarAddArtesano.idComprador = lista[i]['id_tipo_comprador'];
      }
    }
  }

  static void idLenguaSelectedOffline(lengua, lista) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]['lengua'] == lengua) {
        VarAddArtesano.idLengua = lista[i]['id_lengua'];
      }
    }
  }
}
