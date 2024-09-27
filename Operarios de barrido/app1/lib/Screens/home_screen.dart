import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0), 
        child: AppBar(
          backgroundColor: const Color(0xFF8CBE2A),
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0), 
              child: Text(
                'Enviaseo E.S.P.',
                style: TextStyle(
                  fontFamily: 'Averta',
                  fontWeight: FontWeight.bold,
                  fontSize: 43, 
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Bienvenido a la App de operarios de barrido',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Averta',
                    color: Color(0xFF706F6F),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60), // Espacio entre el texto y los botones
              SizedBox(
                width: double.infinity, // Los botones ocuparán todo el ancho disponible
                child: _buildElevatedButton(
                  context,
                  icon: Icons.list,
                  text: 'Mis rutas',
                  onPressed: () {
                    Navigator.pushNamed(context, '/routes');
                  },
                ),
              ),
              const SizedBox(height: 30), // Espacio entre los botones
              SizedBox(
                width: double.infinity, // Los botones ocuparán todo el ancho disponible
                child: _buildElevatedButton(
                  context,
                  icon: Icons.map,
                  text: 'Ver ruta asignada',
                  onPressed: () {
                    Navigator.pushNamed(context, '/maps');
                  },
                ),
              ),
              const SizedBox(height: 30), // Espacio entre los botones
              SizedBox(
                width: double.infinity, // Los botones ocuparán todo el ancho disponible
                child: _buildElevatedButton(
                  context,
                  icon: Icons.insert_chart,
                  text: 'Ver progreso',
                  onPressed: () {
                    Navigator.pushNamed(context, '/analytics');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton(BuildContext context, {required IconData icon, required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8CBE2A),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'Century Gothic',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        shadowColor: const Color(0xFFE97E03),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 24),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}