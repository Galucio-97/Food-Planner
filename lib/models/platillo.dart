import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum CategoriaComida { desayuno, comida, cena, snack }
enum DiaSemana { lunes, martes, miercoles, jueves, viernes, sabado, domingo, sinAsignar }

const iconosCategorias = {
  CategoriaComida.desayuno: Icons.free_breakfast,
  CategoriaComida.comida: Icons.lunch_dining,
  CategoriaComida.cena: Icons.dinner_dining,
  CategoriaComida.snack: Icons.bakery_dining,
};

class Platillo {
  final String id;
  final String nombre;
  final CategoriaComida categoria;
  final int tiempoMinutos;
  final List<String> ingredientes;
  DiaSemana diaAsignado;
  bool esFavorito;

  Platillo({
    required this.nombre,
    required this.categoria,
    required this.tiempoMinutos,
    required this.ingredientes,
    this.diaAsignado = DiaSemana.sinAsignar,
    this.esFavorito = false,
    String? id,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'categoria': categoria.index,
      'tiempoMinutos': tiempoMinutos,
      'ingredientes': ingredientes,
      'diaAsignado': diaAsignado.index,
      'esFavorito': esFavorito,
    };
  }

  factory Platillo.fromJson(Map<String, dynamic> json) {
    return Platillo(
      id: json['id'],
      nombre: json['nombre'],
      categoria: CategoriaComida.values[json['categoria']],
      tiempoMinutos: json['tiempoMinutos'],
      ingredientes: List<String>.from(json['ingredientes']),
      diaAsignado: DiaSemana.values[json['diaAsignado']],
      esFavorito: json['esFavorito'] ?? false,
    );
  }
}