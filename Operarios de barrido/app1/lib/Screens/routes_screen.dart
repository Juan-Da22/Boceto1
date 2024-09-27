import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final List<Map<String, dynamic>> _routes = [];
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rutas',
          style: TextStyle(
            fontFamily: 'Century Gothic',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF8CBE2A), // Color primario
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildFloatingActionButton(
          icon: Icons.add,
          label: 'Crear Ruta',
          onPressed: () => _showCreateRouteDialog(context),
          heroTag: 'createRouteButton',
        ),
        const SizedBox(height: 16.0),
        _buildFloatingActionButton(
          icon: Icons.edit,
          label: 'Modificar Ruta',
          onPressed: _routes.isEmpty ? null : () => _showModifyRouteDialog(context),
          heroTag: 'modifyRouteButton',
          disabledColor: Colors.grey,
        ),
        const SizedBox(height: 16.0),
        _buildFloatingActionButton(
          icon: Icons.delete,
          label: 'Eliminar Ruta',
          onPressed: _routes.isEmpty ? null : () => _showDeleteRouteDialog(context),
          heroTag: 'deleteRouteButton',
          disabledColor: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required String heroTag,
    Color? disabledColor,
  }) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: onPressed != null ? const Color(0xFF8CBE2A) : disabledColor,
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(fontFamily: 'Century Gothic'),
      ),
      heroTag: heroTag,
    );
  }

  Widget _buildBody() {
    return _routes.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.route,
                  size: 64.0,
                  color: Color(0xFFE97E03), // Color complementario
                ),
                SizedBox(height: 16.0),
                Text(
                  'No hay rutas creadas.',
                  style: TextStyle(
                    fontFamily: 'Century Gothic',
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: _routes.length,
            itemBuilder: (context, index) {
              final route = _routes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE97E03),
                    child: Icon(Icons.route, color: Colors.white),
                  ),
                  title: Text(
                    'Ruta ${index + 1}',
                    style: const TextStyle(
                      fontFamily: 'Century Gothic',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Puntos: ${route['points'].length}',
                    style: const TextStyle(fontFamily: 'Century Gothic'),
                  ),
                ),
              );
            },
          );
  }

  Future<void> _showCreateRouteDialog(BuildContext context) async {
    _latController.clear();
    _lngController.clear();
    await showDialog(
      context: context,
      builder: (context) {
 return AlertDialog(
          title: const Text(
            'Crear Ruta',
            style: TextStyle(
              fontFamily: 'Averta',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCoordinateInput('Latitud:', _latController),
                _buildCoordinateInput('Longitud:', _lngController),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _addPointToRoute(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE97E03), // Color complementario
                  ),
                  child: const Text(
                    'Agregar un nuevo punto',
                    style: TextStyle(fontFamily: 'Averta'),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _loadRouteFromFile(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE97E03), // Color complementario
                  ),
                  child: const Text(
                    'Cargar ruta',
                    style: TextStyle(fontFamily: 'Averta'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCoordinateInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontFamily: 'Century Gothic'),
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  void _addPointToRoute() {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);
    if (lat != null && lng != null) {
      setState(() {
        _routes.add({
          'points': [
            {'lat': lat, 'lng': lng}
          ],
        });
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Coordenadas inválidas.',
          style: TextStyle(fontFamily: 'Century Gothic'),
        ),
      ));
    }
  }

  Future<void> _loadRouteFromFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv'], // Add more extensions if needed
    );
    if (result != null) {
      // Implementar lógica para cargar ruta desde archivo
      print('Cargar ruta desde archivo');
    }
  }

  Future<void> _showModifyRouteDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Modificar Ruta',
            style: TextStyle(
              fontFamily: 'Averta',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Seleccione una ruta para modificar:',
            style: TextStyle(fontFamily: 'Century Gothic'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE97E03), // Color complementario
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(fontFamily: 'Averta'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _modifyRoute(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE97E03), // Color complementario
              ),
              child: const Text(
                'Modificar',
                style: TextStyle(fontFamily: 'Averta'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _modifyRoute() {
    // Implementar lógica para modificar ruta
    print('Modificar ruta');
  }

  Future<void> _showDeleteRouteDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Eliminar Ruta',
            style: TextStyle(
              fontFamily: 'Averta',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            '¿Estás seguro de que deseas eliminar esta ruta?',
            style: TextStyle(fontFamily: 'Century Gothic'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE97E03), // Color complementario
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(fontFamily: 'Averta'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _deleteRoute(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE97E03), // Color complementario
              ),
              child: const Text(
                'Eliminar',
                style: TextStyle(fontFamily: 'Averta'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteRoute() {
    setState(() {
      _routes.removeAt(0); // Remove the first route for now
    });
  }
}