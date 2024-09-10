
class OfflineDataCapacitacion{

  static List inscripciones = [];
  static List comprobaciones = [];
  
  static List inscripcionesOffline = [];
  static List comprobacionesOffline = [];



  static List acciones = [
    {
        "id": "1",
        "id_programa": "2",
        "area": "nuevo",
        "nombre": "nuevo",
        "capacitador": "nuevo",
        "objetivo": "nuevo",
        "poblacion_objetivo": "nuevo",
        "duracion": "4",
        "nivel": "AVANZADO",
        "id_trimestre": "4",
        "annio": "2023",
        "cargo": "Director general del Instituto para el fomento y la proteccion de las artesanias",
        "created_at": "2023-12-12 00:00:00",
        "updated_at": "2023-12-05 00:08:57"
    },
    {
        "id": "3",
        "id_programa": "1",
        "area": "asd",
        "nombre": "asd",
        "capacitador": "asd",
        "objetivo": "asd",
        "poblacion_objetivo": "asd",
        "duracion": "12",
        "nivel": "PRINCIPIANTE",
        "id_trimestre": "1",
        "annio": "1212",
        "cargo": "Director general del Instituto para el fomento y la proteccion de las artesanias",
        "created_at": "2023-12-03 23:35:36",
        "updated_at": null
    },
    {
        "id": "4",
        "id_programa": "2",
        "area": "sergio",
        "nombre": "sergio",
        "capacitador": "sergio",
        "objetivo": "sergio",
        "poblacion_objetivo": "sergio",
        "duracion": "2",
        "nivel": "PRINCIPIANTE",
        "id_trimestre": "2",
        "annio": "2023",
        "cargo": "Director general del Instituto para el fomento y la proteccion de las artesanias",
        "created_at": "2023-12-05 13:28:56",
        "updated_at": "2023-12-05 13:28:56"
    }
];

  static List trimestres = [
    {
        "id": "1",
        "mes_inicio": "1",
        "mes_termino": "3",
        "activo": "0",
        "created_at": "2023-11-24 00:00:00",
        "updated_at": "2023-11-24 00:00:00",
        "meses": "Enero - Marzo"
    },
    {
        "id": "2",
        "mes_inicio": "4",
        "mes_termino": "6",
        "activo": "0",
        "created_at": "2023-11-24 00:00:00",
        "updated_at": "2023-11-24 00:00:00",
        "meses": "Abril - Junio"
    },
    {
        "id": "3",
        "mes_inicio": "7",
        "mes_termino": "9",
        "activo": "0",
        "created_at": "2023-11-24 00:00:00",
        "updated_at": "2023-11-24 00:00:00",
        "meses": "Julio - Septiembre"
    },
    {
        "id": "4",
        "mes_inicio": "10",
        "mes_termino": "12",
        "activo": "0",
        "created_at": "2023-11-24 00:00:00",
        "updated_at": "2023-11-24 00:00:00",
        "meses": "Octubre - Diciembre"
    }
];
  static List programas = [
    {
        "id": "1",
        "nombre_programa": "CAPACITACION",
        "created_at": "2023-11-24 22:05:19",
        "updated_at": "2023-11-24 22:05:19"
    },
    {
        "id": "2",
        "nombre_programa": "SUBSIDIOS A LA PRODUCCION ARTESANAL",
        "created_at": "2023-11-24 22:05:19",
        "updated_at": "2023-11-24 22:05:19"
    },
    {
        "id": "3",
        "nombre_programa": "APOYOS PARA IMPULSAR LA PRODUCCION",
        "created_at": "2023-11-24 22:05:18",
        "updated_at": "2023-11-24 22:05:18"
    },
    {
        "id": "5",
        "nombre_programa": "PROYECTOS ESTRATEGICOS",
        "created_at": "2023-03-31 17:02:45",
        "updated_at": "2023-03-31 17:02:45"
    },
    {
        "id": "4",
        "nombre_programa": "SALUD OCUPACIONAL",
        "created_at": "2023-03-31 17:02:45",
        "updated_at": "2023-03-31 17:02:45"
    }
];

}