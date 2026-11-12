import 'package:flutter/material.dart';
import '../models/platillo.dart';

class AgregarPlatilloScreen extends StatefulWidget {
  const AgregarPlatilloScreen({super.key, required this.onAddPlatillo});

  final void Function(Platillo platillo) onAddPlatillo;

  @override
  State<AgregarPlatilloScreen> createState() => _AgregarPlatilloScreenState();
}

class _AgregarPlatilloScreenState extends State<AgregarPlatilloScreen> {
  final _nombreController = TextEditingController();
  final _tiempoController = TextEditingController();
  final _ingredientesController = TextEditingController();

  CategoriaComida _categoriaSeleccionada = CategoriaComida.comida;
  DiaSemana _diaSeleccionado = DiaSemana.sinAsignar;

  @override
  void dispose() {
    _nombreController.dispose();
    _tiempoController.dispose();
    _ingredientesController.dispose();
    super.dispose();
  }

  void _guardarPlatillo() {
    final tiempo = int.tryParse(_tiempoController.text);
    final tiempoEsInvalido = tiempo == null || tiempo <= 0;
    final nombreEsInvalido = _nombreController.text.trim().isEmpty;
    final ingredientesTexto = _ingredientesController.text.trim();

    if (nombreEsInvalido || tiempoEsInvalido || ingredientesTexto.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Datos incompletos'),
          content: const Text(
            'Por favor, asegúrate de ingresar un nombre válido, tiempo en minutos y al menos un ingrediente.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Entendido'),
            ),
          ],
        ),
      );
      return;
    }

    final listaIngredientes = ingredientesTexto
        .split('\n')
        .map((ing) => ing.trim())
        .where((ing) => ing.isNotEmpty)
        .toList();

    widget.onAddPlatillo(
      Platillo(
        nombre: _nombreController.text.trim(),
        categoria: _categoriaSeleccionada,
        tiempoMinutos: tiempo,
        ingredientes: listaIngredientes,
        diaAsignado: _diaSeleccionado,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 24, 16, keyboardSpace + 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Agregar Nuevo Platillo',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            // Campo Nombre
            TextField(
              controller: _nombreController,
              maxLength: 60,
              buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
              decoration: const InputDecoration(
                labelText: 'Nombre del Platillo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Campo Tiempo
                Expanded(
                  child: TextField(
                    controller: _tiempoController,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                    decoration: const InputDecoration(
                      labelText: 'Tiempo (min)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Selector de Categoría
                Expanded(
                  child: DropdownButtonFormField<CategoriaComida>(
                    value: _categoriaSeleccionada,
                    decoration: const InputDecoration(
                      labelText: 'Categoría',
                      border: OutlineInputBorder(),
                    ),
                    items: CategoriaComida.values
                        .map(
                          (cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat.name[0].toUpperCase() + cat.name.substring(1)),
                      ),
                    )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _categoriaSeleccionada = val);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Selector de Día Asignado
            DropdownButtonFormField<DiaSemana>(
              value: _diaSeleccionado,
              decoration: const InputDecoration(
                labelText: 'Asignar a día de la semana',
                border: OutlineInputBorder(),
              ),
              items: DiaSemana.values
                  .map(
                    (dia) => DropdownMenuItem(
                  value: dia,
                  child: Text(dia == DiaSemana.sinAsignar ? 'Sin asignar' : dia.name[0].toUpperCase() + dia.name.substring(1)),
                ),
              )
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _diaSeleccionado = val);
                }
              },
            ),
            const SizedBox(height: 16),
            // Campo Ingredientes
            TextField(
              controller: _ingredientesController,
              maxLines: null,
              maxLength: 500,
              buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Ingredientes (uno por línea)',
                hintText: 'Ejemplo:\nPollo\nArroz\nVerduras',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            // Botones de Acción
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _guardarPlatillo,
                  icon: const Icon(Icons.save),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  label: const Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}