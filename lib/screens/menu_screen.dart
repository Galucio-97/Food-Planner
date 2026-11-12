import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/platillo.dart';
import '../widgets/platillo_item.dart';
import 'agregar_platillo_screen.dart';
import '../data/platillos_iniciales.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Platillo> _platillosRegistrados = [];
  bool _estaCargando = true;
  int _indiceSeleccionado = 0; // 0: Inicio, 1: Agregar (modal), 2: Favoritos

  // Estado de búsqueda y filtros
  bool _mostrandoBusqueda = false;
  final _searchController = TextEditingController();
  CategoriaComida? _filtroCategoria;
  DiaSemana? _filtroDia;

  @override
  void initState() {
    super.initState();
    _cargarPlatillosDeMemoria();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // --- Lógica de Almacenamiento Local ---
  Future<void> _guardarPlatillosEnMemoria() async {
    final prefs = await SharedPreferences.getInstance();
    final String datosJson = jsonEncode(
      _platillosRegistrados.map((p) => p.toJson()).toList(),
    );
    await prefs.setString('platillos_guardados', datosJson);
  }

  Future<void> _cargarPlatillosDeMemoria() async {
    final prefs = await SharedPreferences.getInstance();
    final String? datosJson = prefs.getString('platillos_guardados');

    if (datosJson != null) {
      final List<dynamic> listaMapas = jsonDecode(datosJson);
      setState(() {
        _platillosRegistrados = listaMapas
            .map((mapa) => Platillo.fromJson(mapa))
            .toList();
        _estaCargando = false;
      });
    } else {
      setState(() {
        _platillosRegistrados = List.from(platillosIniciales);
        _estaCargando = false;
      });
      await _guardarPlatillosEnMemoria();
    }
  }

  // --- Operaciones ---
  void _agregarNuevoPlatillo(Platillo platillo) {
    setState(() {
      _platillosRegistrados.add(platillo);
    });
    _guardarPlatillosEnMemoria();
  }

  void _borrarPlatillo(Platillo platillo) {
    final index = _platillosRegistrados.indexOf(platillo);
    setState(() {
      _platillosRegistrados.remove(platillo);
    });
    _guardarPlatillosEnMemoria();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text('${platillo.nombre} eliminado.'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            setState(() {
              _platillosRegistrados.insert(index, platillo);
            });
            _guardarPlatillosEnMemoria();
          },
        ),
      ),
    );
  }

  void _alternarFavorito(Platillo platillo) {
    setState(() {
      platillo.esFavorito = !platillo.esFavorito;
    });
    _guardarPlatillosEnMemoria();
  }

  void _abrirModalAgregarPlatillo() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => AgregarPlatilloScreen(
        onAddPlatillo: _agregarNuevoPlatillo,
      ),
    );
  }

  // --- Lógica de Filtrado ---
  List<Platillo> get _platillosAMostrar {
    Iterable<Platillo> filtrados = _platillosRegistrados;

    // Si estamos en la pestaña de favoritos, filtramos primero por favoritos
    if (_indiceSeleccionado == 2) {
      filtrados = filtrados.where((p) => p.esFavorito);
    }

    // Aplicamos filtros de búsqueda si están activos
    if (_mostrandoBusqueda) {
      final query = _searchController.text.toLowerCase();
      filtrados = filtrados.where((p) {
        final coincideNombre = p.nombre.toLowerCase().contains(query);
        final coincideCategoria = _filtroCategoria == null || p.categoria == _filtroCategoria;
        final coincideDia = _filtroDia == null || p.diaAsignado == _filtroDia;
        return coincideNombre && coincideCategoria && coincideDia;
      });
    }

    return filtrados.toList();
  }

  Widget _buildSearchPanel() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _mostrandoBusqueda ? null : 0,
      child: _mostrandoBusqueda
          ? Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "Buscar por nombre...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<CategoriaComida?>(
                          value: _filtroCategoria,
                          decoration: InputDecoration(
                            labelText: 'Categoría',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          items: [
                            const DropdownMenuItem(value: null, child: Text('Todas')),
                            ...CategoriaComida.values.map(
                              (cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat.name[0].toUpperCase() + cat.name.substring(1)),
                              ),
                            ),
                          ],
                          onChanged: (val) => setState(() => _filtroCategoria = val),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<DiaSemana?>(
                          value: _filtroDia,
                          decoration: InputDecoration(
                            labelText: 'Día',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                          items: [
                            const DropdownMenuItem(value: null, child: Text('Todos')),
                            ...DiaSemana.values.map(
                              (dia) => DropdownMenuItem(
                                value: dia,
                                child: Text(dia == DiaSemana.sinAsignar 
                                  ? 'Sin asignar' 
                                  : dia.name[0].toUpperCase() + dia.name.substring(1)),
                              ),
                            ),
                          ],
                          onChanged: (val) => setState(() => _filtroDia = val),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildList(List<Platillo> platillos, String emptyMessage) {
    if (platillos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            emptyMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: platillos.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(platillos[index].id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.delete_forever, color: Colors.white, size: 30),
        ),
        onDismissed: (_) => _borrarPlatillo(platillos[index]),
        child: PlatilloItem(
          platillo: platillos[index],
          onToggleFavorite: _alternarFavorito,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_estaCargando) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    String title = _indiceSeleccionado == 2 ? "Favoritos" : "Mis Recetas";
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(_mostrandoBusqueda ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _mostrandoBusqueda = !_mostrandoBusqueda;
                if (!_mostrandoBusqueda) {
                  // Limpiar filtros al cerrar búsqueda
                  _searchController.clear();
                  _filtroCategoria = null;
                  _filtroDia = null;
                }
              });
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildSearchPanel(),
          Expanded(
            child: _buildList(
              _platillosAMostrar, 
              _indiceSeleccionado == 2 
                  ? "No tienes recetas favoritas." 
                  : (_mostrandoBusqueda ? "No hay resultados para tu búsqueda." : "No hay recetas registradas.")
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indiceSeleccionado,
        onDestinationSelected: (index) {
          if (index == 1) {
            _abrirModalAgregarPlatillo();
          } else {
            setState(() {
              _indiceSeleccionado = index;
            });
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline, size: 35),
            selectedIcon: Icon(Icons.add_circle, size: 35),
            label: 'Agregar',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}