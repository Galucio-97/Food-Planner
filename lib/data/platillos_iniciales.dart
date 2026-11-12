import '../models/platillo.dart';

final List<Platillo> platillosIniciales = [
  // --- DESAYUNOS ---
  Platillo(
    nombre: "Chilaquiles rojos con pollo",
    categoria: CategoriaComida.desayuno,
    tiempoMinutos: 20,
    ingredientes: [
      "Totopos de maíz",
      "Salsa roja de jitomate",
      "Pollo deshebrado",
      "Queso fresco",
      "Crema",
    ],
    diaAsignado: DiaSemana.lunes,
  ),
  Platillo(
    nombre: "Huevos a la mexicana",
    categoria: CategoriaComida.desayuno,
    tiempoMinutos: 15,
    ingredientes: [
      "3 Huevos",
      "Jitomate picado",
      "Cebolla picada",
      "Chile serrano",
      "Tortillas de maíz",
    ],
    diaAsignado: DiaSemana.martes,
  ),
  Platillo(
    nombre: "Hot cakes de avena y plátano",
    categoria: CategoriaComida.desayuno,
    tiempoMinutos: 15,
    ingredientes: [
      "Avena molida",
      "1 Plátano",
      "1 Huevo",
      "Chorrito de leche",
      "Canela en polvo",
    ],
    diaAsignado: DiaSemana.miercoles,
  ),

  // --- COMIDAS ---
  Platillo(
    nombre: "Pechuga a la plancha con brócoli y arroz",
    categoria: CategoriaComida.comida,
    tiempoMinutos: 25,
    ingredientes: [
      "Pechuga de pollo",
      "Brócoli al vapor",
      "Arroz blanco",
      "Aceite de oliva",
      "Ajo y pimienta",
    ],
    diaAsignado: DiaSemana.lunes,
  ),
  Platillo(
    nombre: "Picadillo de res con verduras",
    categoria: CategoriaComida.comida,
    tiempoMinutos: 30,
    ingredientes: [
      "Carne molida de res",
      "Papas en cubos",
      "Zanahorias",
      "Puré de jitomate",
      "Tortillas",
    ],
    diaAsignado: DiaSemana.martes,
  ),
  Platillo(
    nombre: "Bistec con nopales en salsa verde",
    categoria: CategoriaComida.comida,
    tiempoMinutos: 35,
    ingredientes: [
      "Bistec de res",
      "Nopales cocidos",
      "Tomatillo verde",
      "Cilantro",
      "Cebolla",
    ],
    diaAsignado: DiaSemana.miercoles,
  ),

  // --- CENAS ---
  Platillo(
    nombre: "Ensalada de atún con verduras",
    categoria: CategoriaComida.cena,
    tiempoMinutos: 10,
    ingredientes: [
      "Lata de atún en agua",
      "Mayonesa",
      "Elote en lata",
      "Zanahoria en cubos",
      "Galletas saladas",
    ],
    diaAsignado: DiaSemana.jueves,
  ),
  Platillo(
    nombre: "Sincronizadas de jamón y queso",
    categoria: CategoriaComida.cena,
    tiempoMinutos: 10,
    ingredientes: [
      "Tortillas de harina",
      "Jamón de pavo",
      "Queso Oaxaca / Manchego",
      "Aguacate",
    ],
    diaAsignado: DiaSemana.viernes,
  ),

  // --- SNACKS ---
  Platillo(
    nombre: "Manzana con crema de cacahuate",
    categoria: CategoriaComida.snack,
    tiempoMinutos: 5,
    ingredientes: [
      "1 Manzana verde",
      "2 cdas de Crema de cacahuate",
      "Granola",
    ],
    diaAsignado: DiaSemana.sinAsignar,
  ),
  Platillo(
    nombre: "Yogurt griego con frutos rojos",
    categoria: CategoriaComida.snack,
    tiempoMinutos: 5,
    ingredientes: [
      "Yogurt griego natural",
      "Fresas picadas",
      "Arándanos",
      "Un toque de miel",
    ],
    diaAsignado: DiaSemana.sinAsignar,
  ),
];