import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Comentarios',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FormularioComentarios(),
    );
  }
}

class FormularioComentarios extends StatefulWidget {
  const FormularioComentarios({super.key});

  @override
  State<FormularioComentarios> createState() => _FormularioComentariosState();
}

class _FormularioComentariosState extends State<FormularioComentarios> {
  // Controladores para los campos de texto
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  // Clave para validar el formulario
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Limpieza de controladores al  el widget
    _nombreController.dispose();
    _emailController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  // Método para procesar el envío del formulario
  void _enviarComentario() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría la lógica para procesar el comentario
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enviando comentario...')),
      );

      // Imprimir datos en consola como ejemplo
      print('Nombre: ${_nombreController.text}');
      print('Email: ${_emailController.text}');
      print('Comentario: ${_comentarioController.text}');

      // Simulación de envío exitoso después de 1 segundo
      Future.delayed(const Duration(seconds: 1), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Comentario enviado correctamente!')),
        );

        // Limpiar los campos después de enviar
        setState(() {
          _nombreController.clear();
          _emailController.clear();
          _comentarioController.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentarios'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Deja un Comentario',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Campo Nombre
                  const Text(
                    'Nombre:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese su nombre',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Campo Email
                  const Text(
                    'Email:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese su email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese su email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Por favor ingrese un email válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Campo Comentario
                  const Text(
                    'Comentario:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _comentarioController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Escriba su comentario aquí',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un comentario';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Botón de envío
                  ElevatedButton(
                    onPressed: _enviarComentario,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'Enviar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}