import 'package:flutter/material.dart';
import '../models/platillo.dart';

class PlatilloItem extends StatelessWidget {
  const PlatilloItem({
    super.key, 
    required this.platillo,
    required this.onToggleFavorite,
  });

  final Platillo platillo;
  final void Function(Platillo platillo) onToggleFavorite;

  void _mostrarIngredientes(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              iconosCategorias[platillo.categoria],
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                platillo.nombre,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer, size: 18, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('Preparación: ${platillo.tiempoMinutos} min'),
                  ],
                ),
                const SizedBox(width: 15),
                Text(
                  'Categoría: ${platillo.categoria.name}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 25),
            const Text(
              'Ingredientes necesarios:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ...platillo.ingredientes.map(
                  (ingrediente) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 18, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(ingrediente, style: const TextStyle(fontSize: 15))),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              platillo.esFavorito ? Icons.favorite : Icons.favorite_border,
              color: platillo.esFavorito ? Colors.red : null,
            ),
            onPressed: () {
              onToggleFavorite(platillo);
              Navigator.pop(ctx);
            },
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _mostrarIngredientes(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  iconosCategorias[platillo.categoria],
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      platillo.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${platillo.tiempoMinutos} min',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.restaurant_menu, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${platillo.ingredientes.length} ingred.',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  platillo.esFavorito ? Icons.favorite : Icons.favorite_border,
                  color: platillo.esFavorito ? Colors.red : null,
                ),
                onPressed: () => onToggleFavorite(platillo),
              ),
              Chip(
                label: Text(
                  platillo.diaAsignado == DiaSemana.sinAsignar 
                      ? 'S/A' 
                      : platillo.diaAsignado.name.substring(0, 3).toUpperCase(),
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                backgroundColor: platillo.diaAsignado == DiaSemana.sinAsignar
                    ? Colors.grey.shade200
                    : Theme.of(context).colorScheme.secondaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}