import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/work_job.dart';

class MeasurementsScreen extends StatefulWidget {
  const MeasurementsScreen({super.key});

  @override
  State<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends State<MeasurementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<DoorMeasurement> _doors = [];
  final List<DrawerMeasurement> _drawers = [];
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toma de Medidas'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.door_front_door, size: 20),
                  const SizedBox(width: 8),
                  Text('Puertas (${_doors.length})', style: GoogleFonts.inter()),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.dashboard, size: 20),
                  const SizedBox(width: 8),
                  Text('Cajones (${_drawers.length})', style: GoogleFonts.inter()),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDoorsTab(),
                _buildDrawersTab(),
              ],
            ),
          ),
          _buildNotesSection(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildDoorsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Botón para agregar puerta
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addDoor,
              icon: const Icon(Icons.add),
              label: Text(
                'Agregar Puerta',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lista de puertas
          Expanded(
            child: _doors.isEmpty
                ? _buildEmptyState('puertas', Icons.door_front_door)
                : ListView.builder(
                    itemCount: _doors.length,
                    itemBuilder: (context, index) {
                      return _buildDoorCard(_doors[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawersTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Botón para agregar cajón
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addDrawer,
              icon: const Icon(Icons.add),
              label: Text(
                'Agregar Cajón',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lista de cajones
          Expanded(
            child: _drawers.isEmpty
                ? _buildEmptyState('cajones', Icons.dashboard)
                : ListView.builder(
                    itemCount: _drawers.length,
                    itemBuilder: (context, index) {
                      return _buildDrawerCard(_drawers[index], index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String type, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: const Color(0xFFCCCCCC),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay $type registradas',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toca el botón para agregar la primera $type',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF999999),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDoorCard(DoorMeasurement door, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Puerta #${door.itemNumber}',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                IconButton(
                  onPressed: () => _removeDoor(index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMeasurementField(
                    label: 'Cantidad',
                    value: door.quantity.toString(),
                    onChanged: (value) {
                      setState(() {
                        door.quantity = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMeasurementField(
                    label: 'Ancho (")',
                    value: door.width.toString(),
                    onChanged: (value) {
                      setState(() {
                        door.width = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMeasurementField(
                    label: 'Alto (")',
                    value: door.height.toString(),
                    onChanged: (value) {
                      setState(() {
                        door.height = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Notas',
                hintText: 'Notas adicionales...',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              maxLines: 2,
              controller: TextEditingController(text: door.notes),
              onChanged: (value) {
                door.notes = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerCard(DrawerMeasurement drawer, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cajón #${drawer.itemNumber}',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF333333),
                  ),
                ),
                IconButton(
                  onPressed: () => _removeDrawer(index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildMeasurementField(
                    label: 'Cantidad',
                    value: drawer.quantity.toString(),
                    onChanged: (value) {
                      setState(() {
                        drawer.quantity = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMeasurementField(
                    label: 'Ancho (")',
                    value: drawer.width.toString(),
                    onChanged: (value) {
                      setState(() {
                        drawer.width = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMeasurementField(
                    label: 'Alto (")',
                    value: drawer.height.toString(),
                    onChanged: (value) {
                      setState(() {
                        drawer.height = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Notas',
                hintText: 'Notas adicionales...',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              maxLines: 2,
              controller: TextEditingController(text: drawer.notes),
              onChanged: (value) {
                drawer.notes = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementField({
    required String label,
    required String value,
    required void Function(String) onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
      ),
      keyboardType: TextInputType.number,
      controller: TextEditingController(text: value),
      onChanged: onChanged,
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notas Generales',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            decoration: const InputDecoration(
              hintText: 'Notas adicionales sobre el trabajo...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _saveMeasurements,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Guardar Medidas',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _addDoor() {
    setState(() {
      _doors.add(DoorMeasurement(
        itemNumber: _doors.length + 1,
        quantity: 1,
        width: 0.0,
        height: 0.0,
        notes: '',
      ));
    });
  }

  void _addDrawer() {
    setState(() {
      _drawers.add(DrawerMeasurement(
        itemNumber: _drawers.length + 1,
        quantity: 1,
        width: 0.0,
        height: 0.0,
        notes: '',
      ));
    });
  }

  void _removeDoor(int index) {
    setState(() {
      _doors.removeAt(index);
      // Renumerar items
      for (int i = 0; i < _doors.length; i++) {
        _doors[i].itemNumber = i + 1;
      }
    });
  }

  void _removeDrawer(int index) {
    setState(() {
      _drawers.removeAt(index);
      // Renumerar items
      for (int i = 0; i < _drawers.length; i++) {
        _drawers[i].itemNumber = i + 1;
      }
    });
  }

  void _saveMeasurements() {
    if (_doors.isEmpty && _drawers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Agrega al menos una puerta o cajón',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // TODO: Implementar lógica de guardado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Medidas guardadas: ${_doors.length} puertas, ${_drawers.length} cajones',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }
}

