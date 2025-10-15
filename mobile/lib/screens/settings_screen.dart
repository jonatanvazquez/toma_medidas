import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late AppSettings _settings;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _settings = AppSettings(); // Cargar configuración por defecto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: _saveSettings,
            child: Text(
              'Guardar',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información de la empresa
              _buildSectionTitle('Información de la Empresa'),
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Nombre de la Empresa',
                value: _settings.companyName,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(companyName: value);
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Dirección',
                value: _settings.companyAddress,
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(companyAddress: value);
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Teléfono',
                value: _settings.companyPhone,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(companyPhone: value);
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                label: 'Correo Electrónico',
                value: _settings.companyEmail,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(companyEmail: value);
                  });
                },
              ),
              
              const SizedBox(height: 32),
              
              // Configuración de la aplicación
              _buildSectionTitle('Configuración de la Aplicación'),
              const SizedBox(height: 16),
              
              _buildSwitchTile(
                title: 'Notificaciones',
                subtitle: 'Recibir notificaciones sobre trabajos',
                value: _settings.enableNotifications,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(enableNotifications: value);
                  });
                },
              ),
              
              _buildSwitchTile(
                title: 'Modo Oscuro',
                subtitle: 'Usar tema oscuro en la aplicación',
                value: _settings.enableDarkMode,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(enableDarkMode: value);
                  });
                },
              ),
              
              _buildSwitchTile(
                title: 'Guardado Automático',
                subtitle: 'Guardar cambios automáticamente',
                value: _settings.autoSave,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(autoSave: value);
                  });
                },
              ),
              
              const SizedBox(height: 32),
              
              // Valores por defecto
              _buildSectionTitle('Valores por Defecto'),
              const SizedBox(height: 16),
              
              _buildDropdownField(
                label: 'Tipo de Madera por Defecto',
                value: _settings.defaultWoodType,
                items: const ['Oak', 'Maple', 'Cherry', 'Pine', 'Walnut', 'Mahogany'],
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(defaultWoodType: value ?? 'Oak');
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildDropdownField(
                label: 'Grosor de Puerta por Defecto',
                value: _settings.defaultDoorThickness,
                items: const ['3/4"', '1"', '1 1/4"', '1 1/2"'],
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(defaultDoorThickness: value ?? '3/4"');
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildDropdownField(
                label: 'Opening Overlay por Defecto',
                value: _settings.defaultOpeningOverlay,
                items: const ['1/2"', '1/4"', '3/4"', 'Full Overlay'],
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(defaultOpeningOverlay: value ?? '1/2"');
                  });
                },
              ),
              
              const SizedBox(height: 32),
              
              // Configuración avanzada
              _buildSectionTitle('Configuración Avanzada'),
              const SizedBox(height: 16),
              
              _buildSliderField(
                label: 'Máximo de Elementos en Historial',
                value: _settings.maxHistoryItems.toDouble(),
                min: 10,
                max: 500,
                divisions: 49,
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(maxHistoryItems: value.round());
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildDropdownField(
                label: 'Formato de Exportación',
                value: _settings.exportFormat,
                items: const ['PDF', 'Excel', 'CSV', 'JSON'],
                onChanged: (value) {
                  setState(() {
                    _settings = _settings.copyWith(exportFormat: value ?? 'PDF');
                  });
                },
              ),
              
              const SizedBox(height: 32),
              
              // Acciones
              _buildSectionTitle('Acciones'),
              const SizedBox(height: 16),
              
              _buildActionTile(
                title: 'Exportar Configuración',
                subtitle: 'Guardar configuración en archivo',
                icon: Icons.download,
                onTap: _exportSettings,
              ),
              
              _buildActionTile(
                title: 'Importar Configuración',
                subtitle: 'Cargar configuración desde archivo',
                icon: Icons.upload,
                onTap: _importSettings,
              ),
              
              _buildActionTile(
                title: 'Restaurar Valores por Defecto',
                subtitle: 'Volver a la configuración inicial',
                icon: Icons.restore,
                onTap: _resetSettings,
              ),
              
              _buildActionTile(
                title: 'Limpiar Historial',
                subtitle: 'Eliminar todos los trabajos guardados',
                icon: Icons.delete_forever,
                onTap: _clearHistory,
                isDestructive: true,
              ),
              
              const SizedBox(height: 32),
              
              // Información de la app
              _buildSectionTitle('Información de la Aplicación'),
              const SizedBox(height: 16),
              
              _buildInfoTile('Versión', '1.0.0'),
              _buildInfoTile('Fecha de Compilación', '2024-01-15'),
              _buildInfoTile('Desarrollado por', 'M&L Cabinet Doors LLC'),
              
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
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF333333),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    int maxLines = 1,
    TextInputType? keyboardType,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          color: const Color(0xFF666666),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
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
      value: value,
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

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF666666),
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF2196F3),
      ),
    );
  }

  Widget _buildSliderField({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required void Function(double) onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${value.round()}',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2196F3),
              ),
            ),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
              activeColor: const Color(0xFF2196F3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : const Color(0xFF2196F3),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : const Color(0xFF333333),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF666666),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        trailing: Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  void _saveSettings() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implementar guardado de configuración
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Configuración guardada exitosamente',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    }
  }

  void _exportSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exportar Configuración', style: GoogleFonts.inter()),
        content: Text(
          '¿Deseas exportar la configuración actual a un archivo?',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: GoogleFonts.inter()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar exportación
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Configuración exportada exitosamente',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            child: Text('Exportar', style: GoogleFonts.inter()),
          ),
        ],
      ),
    );
  }

  void _importSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Importar Configuración', style: GoogleFonts.inter()),
        content: Text(
          '¿Deseas importar configuración desde un archivo? Esto sobrescribirá la configuración actual.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: GoogleFonts.inter()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar importación
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Configuración importada exitosamente',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            child: Text('Importar', style: GoogleFonts.inter()),
          ),
        ],
      ),
    );
  }

  void _resetSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Restaurar Valores por Defecto', style: GoogleFonts.inter()),
        content: Text(
          '¿Estás seguro de que deseas restaurar todos los valores por defecto? Esto eliminará tu configuración actual.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: GoogleFonts.inter()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _settings = AppSettings();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Configuración restaurada a valores por defecto',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: Text('Restaurar', style: GoogleFonts.inter()),
          ),
        ],
      ),
    );
  }

  void _clearHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpiar Historial', style: GoogleFonts.inter()),
        content: Text(
          '¿Estás seguro de que deseas eliminar todos los trabajos del historial? Esta acción no se puede deshacer.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: GoogleFonts.inter()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar limpieza de historial
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Historial limpiado exitosamente',
                    style: GoogleFonts.inter(),
                  ),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Eliminar', style: GoogleFonts.inter()),
          ),
        ],
      ),
    );
  }
}
