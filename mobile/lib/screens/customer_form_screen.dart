import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({super.key});

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _jobLocationController = TextEditingController();
  
  String _openingOverlay = '';
  String _finishSizes = '';
  String _hinges = '';
  String _woodType = '';
  String _doorStyle = '';
  String _edgeProfile = '';
  String _panelCut = '';
  String _stickingCut = '';
  String _appliedMolding = '';
  String _doorThickness = '';

  @override
  void dispose() {
    _customerNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _jobLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Cliente'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información del cliente
              _buildSectionTitle('Información del Cliente'),
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _customerNameController,
                label: 'Nombre del Cliente',
                hint: 'Ingresa el nombre completo',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _addressController,
                label: 'Dirección',
                hint: 'Dirección completa del cliente',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _phoneController,
                label: 'Teléfono',
                hint: 'Número de teléfono',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _emailController,
                label: 'Correo Electrónico',
                hint: 'email@ejemplo.com',
                keyboardType: TextInputType.emailAddress,
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _contactController,
                label: 'Persona de Contacto',
                hint: 'Nombre de la persona de contacto',
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _jobLocationController,
                label: 'Ubicación del Trabajo',
                hint: 'Dirección donde se realizará el trabajo',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              
              // Especificaciones técnicas
              _buildSectionTitle('Especificaciones Técnicas'),
              const SizedBox(height: 16),
              
              _buildDropdownField(
                label: 'Opening Overlay',
                value: _openingOverlay,
                items: const ['1/2"', '1/4"', '3/4"', 'Full Overlay'],
                onChanged: (value) {
                  setState(() {
                    _openingOverlay = value ?? '';
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Finish Sizes',
                hint: 'Especificaciones de acabado',
                onChanged: (value) {
                  setState(() {
                    _finishSizes = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Hinges',
                hint: 'Tipo de bisagras',
                onChanged: (value) {
                  setState(() {
                    _hinges = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildDropdownField(
                label: 'Wood Type',
                value: _woodType,
                items: const ['Oak', 'Maple', 'Cherry', 'Pine', 'Walnut', 'Mahogany'],
                onChanged: (value) {
                  setState(() {
                    _woodType = value ?? '';
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Door Style',
                hint: 'Estilo de puerta',
                onChanged: (value) {
                  setState(() {
                    _doorStyle = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Edge Profile',
                hint: 'Perfil del borde',
                onChanged: (value) {
                  setState(() {
                    _edgeProfile = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Panel Cut',
                hint: 'Corte del panel',
                onChanged: (value) {
                  setState(() {
                    _panelCut = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Sticking Cut',
                hint: 'Corte de sticking',
                onChanged: (value) {
                  setState(() {
                    _stickingCut = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Applied Molding',
                hint: 'Moldura aplicada',
                onChanged: (value) {
                  setState(() {
                    _appliedMolding = value;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildDropdownField(
                label: 'Door Thickness',
                value: _doorThickness,
                items: const ['3/4"', '1"', '1 1/4"', '1 1/2"'],
                onChanged: (value) {
                  setState(() {
                    _doorThickness = value ?? '';
                  });
                },
              ),
              
              const SizedBox(height: 32),
              
              // Botón de guardar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveCustomer,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Guardar Cliente',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF333333),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: GoogleFonts.inter(
          color: const Color(0xFF666666),
        ),
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF999999),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          color: const Color(0xFF666666),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: GoogleFonts.inter(),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  void _saveCustomer() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar lógica de guardado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cliente ${_customerNameController.text} guardado exitosamente',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
      
      // Limpiar formulario
      _formKey.currentState!.reset();
      _customerNameController.clear();
      _addressController.clear();
      _phoneController.clear();
      _emailController.clear();
      _contactController.clear();
      _jobLocationController.clear();
      
      setState(() {
        _openingOverlay = '';
        _finishSizes = '';
        _hinges = '';
        _woodType = '';
        _doorStyle = '';
        _edgeProfile = '';
        _panelCut = '';
        _stickingCut = '';
        _appliedMolding = '';
        _doorThickness = '';
      });
    }
  }
}
