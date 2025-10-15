import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/work_job.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<WorkJob> _workJobs = [];
  String _selectedFilter = 'all';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Datos de ejemplo para demostración
    setState(() {
      _workJobs.addAll([
        WorkJob(
          id: '1',
          customerName: 'Juan Pérez',
          customerAddress: '123 Main St, Houston TX',
          customerPhone: '(713) 555-0123',
          customerEmail: 'juan.perez@email.com',
          contactPerson: 'María Pérez',
          jobLocation: '123 Main St, Houston TX',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          completedAt: DateTime.now().subtract(const Duration(days: 2)),
          status: WorkStatus.completed,
          doors: [
            DoorMeasurement(itemNumber: 1, quantity: 2, width: 24.0, height: 30.0, notes: 'Puertas principales'),
            DoorMeasurement(itemNumber: 2, quantity: 1, width: 18.0, height: 30.0, notes: 'Puerta de gabinete'),
          ],
          drawers: [
            DrawerMeasurement(itemNumber: 1, quantity: 3, width: 20.0, height: 8.0, notes: 'Cajones principales'),
          ],
          notes: 'Trabajo completado satisfactoriamente',
          technicalSpecs: TechnicalSpecs(
            woodType: 'Oak',
            doorThickness: '3/4"',
            openingOverlay: '1/2"',
          ),
        ),
        WorkJob(
          id: '2',
          customerName: 'María García',
          customerAddress: '456 Oak Ave, Houston TX',
          customerPhone: '(713) 555-0456',
          customerEmail: 'maria.garcia@email.com',
          contactPerson: 'Carlos García',
          jobLocation: '456 Oak Ave, Houston TX',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          status: WorkStatus.inProgress,
          doors: [
            DoorMeasurement(itemNumber: 1, quantity: 4, width: 20.0, height: 32.0, notes: 'Puertas de cocina'),
          ],
          drawers: [
            DrawerMeasurement(itemNumber: 1, quantity: 2, width: 18.0, height: 6.0, notes: 'Cajones pequeños'),
          ],
          notes: 'Trabajo en progreso',
          technicalSpecs: TechnicalSpecs(
            woodType: 'Maple',
            doorThickness: '1"',
            openingOverlay: '3/4"',
          ),
        ),
        WorkJob(
          id: '3',
          customerName: 'Carlos López',
          customerAddress: '789 Pine St, Houston TX',
          customerPhone: '(713) 555-0789',
          customerEmail: 'carlos.lopez@email.com',
          contactPerson: 'Ana López',
          jobLocation: '789 Pine St, Houston TX',
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          completedAt: DateTime.now().subtract(const Duration(days: 7)),
          status: WorkStatus.completed,
          doors: [
            DoorMeasurement(itemNumber: 1, quantity: 6, width: 22.0, height: 28.0, notes: 'Puertas de armario'),
          ],
          drawers: [],
          notes: 'Proyecto de renovación de armarios',
          technicalSpecs: TechnicalSpecs(
            woodType: 'Cherry',
            doorThickness: '3/4"',
            openingOverlay: '1/2"',
          ),
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs = _getFilteredJobs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Trabajos'),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _showFilterDialog,
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por cliente o ubicación...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          
          // Filtros
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('Todos', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('En Progreso', 'inProgress'),
                const SizedBox(width: 8),
                _buildFilterChip('Completados', 'completed'),
                const SizedBox(width: 8),
                _buildFilterChip('Cancelados', 'cancelled'),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lista de trabajos
          Expanded(
            child: filteredJobs.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredJobs.length,
                    itemBuilder: (context, index) {
                      return _buildJobCard(filteredJobs[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      selectedColor: const Color(0xFF2196F3).withOpacity(0.2),
      checkmarkColor: const Color(0xFF2196F3),
    );
  }

  Widget _buildJobCard(WorkJob job) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showJobDetails(job),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job.customerName,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                    ),
                  ),
                  _buildStatusChip(job.status),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Color(0xFF666666)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.jobLocation,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF666666),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Color(0xFF666666)),
                  const SizedBox(width: 4),
                  Text(
                    job.customerPhone,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              Row(
                children: [
                  _buildInfoChip(
                    '${job.doors.length} Puertas',
                    Icons.door_front_door,
                    const Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    '${job.drawers.length} Cajones',
                    Icons.dashboard,
                    const Color(0xFFFF9800),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(job.createdAt),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(WorkStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case WorkStatus.inProgress:
        color = const Color(0xFFFF9800);
        text = 'En Progreso';
        break;
      case WorkStatus.completed:
        color = const Color(0xFF4CAF50);
        text = 'Completado';
        break;
      case WorkStatus.cancelled:
        color = const Color(0xFFF44336);
        text = 'Cancelado';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 64,
            color: const Color(0xFFCCCCCC),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay trabajos registrados',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Los trabajos aparecerán aquí una vez que los guardes',
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

  List<WorkJob> _getFilteredJobs() {
    List<WorkJob> filtered = _workJobs.where((job) {
      final matchesSearch = _searchQuery.isEmpty ||
          job.customerName.toLowerCase().contains(_searchQuery) ||
          job.jobLocation.toLowerCase().contains(_searchQuery) ||
          job.customerPhone.contains(_searchQuery);
      
      final matchesFilter = _selectedFilter == 'all' ||
          job.status.name == _selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();
    
    // Ordenar por fecha de creación (más reciente primero)
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return filtered;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filtros', style: GoogleFonts.inter()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Todos', style: GoogleFonts.inter()),
              leading: Radio<String>(
                value: 'all',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('En Progreso', style: GoogleFonts.inter()),
              leading: Radio<String>(
                value: 'inProgress',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('Completados', style: GoogleFonts.inter()),
              leading: Radio<String>(
                value: 'completed',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('Cancelados', style: GoogleFonts.inter()),
              leading: Radio<String>(
                value: 'cancelled',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJobDetails(WorkJob job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Job title
                Text(
                  'Detalles del Trabajo',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Customer info
                _buildDetailSection('Información del Cliente', [
                  'Nombre: ${job.customerName}',
                  'Dirección: ${job.customerAddress}',
                  'Teléfono: ${job.customerPhone}',
                  if (job.customerEmail.isNotEmpty) 'Email: ${job.customerEmail}',
                  if (job.contactPerson.isNotEmpty) 'Contacto: ${job.contactPerson}',
                  'Ubicación del Trabajo: ${job.jobLocation}',
                ]),
                
                const SizedBox(height: 20),
                
                // Technical specs
                _buildDetailSection('Especificaciones Técnicas', [
                  if (job.technicalSpecs.woodType.isNotEmpty)
                    'Tipo de Madera: ${job.technicalSpecs.woodType}',
                  if (job.technicalSpecs.doorThickness.isNotEmpty)
                    'Grosor de Puerta: ${job.technicalSpecs.doorThickness}',
                  if (job.technicalSpecs.openingOverlay.isNotEmpty)
                    'Opening Overlay: ${job.technicalSpecs.openingOverlay}',
                ]),
                
                const SizedBox(height: 20),
                
                // Measurements
                if (job.doors.isNotEmpty) ...[
                  _buildDetailSection('Puertas', job.doors.map((door) => 
                    '${door.quantity}x ${door.width}" x ${door.height}" - ${door.notes}'
                  ).toList()),
                  const SizedBox(height: 20),
                ],
                
                if (job.drawers.isNotEmpty) ...[
                  _buildDetailSection('Cajones', job.drawers.map((drawer) => 
                    '${drawer.quantity}x ${drawer.width}" x ${drawer.height}" - ${drawer.notes}'
                  ).toList()),
                  const SizedBox(height: 20),
                ],
                
                // Notes
                if (job.notes.isNotEmpty) ...[
                  _buildDetailSection('Notas', [job.notes]),
                  const SizedBox(height: 20),
                ],
                
                // Status and dates
                _buildDetailSection('Estado y Fechas', [
                  'Estado: ${_getStatusText(job.status)}',
                  'Fecha de Creación: ${_formatFullDate(job.createdAt)}',
                  if (job.completedAt != null)
                    'Fecha de Completado: ${_formatFullDate(job.completedAt!)}',
                ]),
                
                const SizedBox(height: 30),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // TODO: Implementar edición
                        },
                        icon: const Icon(Icons.edit),
                        label: Text('Editar', style: GoogleFonts.inter()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // TODO: Implementar exportación
                        },
                        icon: const Icon(Icons.download),
                        label: Text('Exportar', style: GoogleFonts.inter()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            item,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF666666),
            ),
          ),
        )),
      ],
    );
  }


  String _getStatusText(WorkStatus status) {
    switch (status) {
      case WorkStatus.inProgress:
        return 'En Progreso';
      case WorkStatus.completed:
        return 'Completado';
      case WorkStatus.cancelled:
        return 'Cancelado';
    }
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
