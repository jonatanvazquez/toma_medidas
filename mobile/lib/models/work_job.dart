class WorkJob {
  final String id;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final String customerEmail;
  final String contactPerson;
  final String jobLocation;
  final DateTime createdAt;
  final DateTime? completedAt;
  final WorkStatus status;
  final List<DoorMeasurement> doors;
  final List<DrawerMeasurement> drawers;
  final String notes;
  final TechnicalSpecs technicalSpecs;

  WorkJob({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    this.customerEmail = '',
    this.contactPerson = '',
    required this.jobLocation,
    required this.createdAt,
    this.completedAt,
    this.status = WorkStatus.inProgress,
    this.doors = const [],
    this.drawers = const [],
    this.notes = '',
    required this.technicalSpecs,
  });

  WorkJob copyWith({
    String? id,
    String? customerName,
    String? customerAddress,
    String? customerPhone,
    String? customerEmail,
    String? contactPerson,
    String? jobLocation,
    DateTime? createdAt,
    DateTime? completedAt,
    WorkStatus? status,
    List<DoorMeasurement>? doors,
    List<DrawerMeasurement>? drawers,
    String? notes,
    TechnicalSpecs? technicalSpecs,
  }) {
    return WorkJob(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerAddress: customerAddress ?? this.customerAddress,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
      contactPerson: contactPerson ?? this.contactPerson,
      jobLocation: jobLocation ?? this.jobLocation,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      doors: doors ?? this.doors,
      drawers: drawers ?? this.drawers,
      notes: notes ?? this.notes,
      technicalSpecs: technicalSpecs ?? this.technicalSpecs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'contactPerson': contactPerson,
      'jobLocation': jobLocation,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'status': status.name,
      'doors': doors.map((door) => door.toJson()).toList(),
      'drawers': drawers.map((drawer) => drawer.toJson()).toList(),
      'notes': notes,
      'technicalSpecs': technicalSpecs.toJson(),
    };
  }

  factory WorkJob.fromJson(Map<String, dynamic> json) {
    return WorkJob(
      id: json['id'],
      customerName: json['customerName'],
      customerAddress: json['customerAddress'],
      customerPhone: json['customerPhone'],
      customerEmail: json['customerEmail'] ?? '',
      contactPerson: json['contactPerson'] ?? '',
      jobLocation: json['jobLocation'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      status: WorkStatus.values.firstWhere((e) => e.name == json['status']),
      doors: (json['doors'] as List<dynamic>?)
          ?.map((door) => DoorMeasurement.fromJson(door))
          .toList() ?? [],
      drawers: (json['drawers'] as List<dynamic>?)
          ?.map((drawer) => DrawerMeasurement.fromJson(drawer))
          .toList() ?? [],
      notes: json['notes'] ?? '',
      technicalSpecs: TechnicalSpecs.fromJson(json['technicalSpecs']),
    );
  }
}

enum WorkStatus {
  inProgress,
  completed,
  cancelled,
}

class TechnicalSpecs {
  final String openingOverlay;
  final String finishSizes;
  final String hinges;
  final String woodType;
  final String doorStyle;
  final String edgeProfile;
  final String panelCut;
  final String stickingCut;
  final String appliedMolding;
  final String doorThickness;

  TechnicalSpecs({
    this.openingOverlay = '',
    this.finishSizes = '',
    this.hinges = '',
    this.woodType = '',
    this.doorStyle = '',
    this.edgeProfile = '',
    this.panelCut = '',
    this.stickingCut = '',
    this.appliedMolding = '',
    this.doorThickness = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'openingOverlay': openingOverlay,
      'finishSizes': finishSizes,
      'hinges': hinges,
      'woodType': woodType,
      'doorStyle': doorStyle,
      'edgeProfile': edgeProfile,
      'panelCut': panelCut,
      'stickingCut': stickingCut,
      'appliedMolding': appliedMolding,
      'doorThickness': doorThickness,
    };
  }

  factory TechnicalSpecs.fromJson(Map<String, dynamic> json) {
    return TechnicalSpecs(
      openingOverlay: json['openingOverlay'] ?? '',
      finishSizes: json['finishSizes'] ?? '',
      hinges: json['hinges'] ?? '',
      woodType: json['woodType'] ?? '',
      doorStyle: json['doorStyle'] ?? '',
      edgeProfile: json['edgeProfile'] ?? '',
      panelCut: json['panelCut'] ?? '',
      stickingCut: json['stickingCut'] ?? '',
      appliedMolding: json['appliedMolding'] ?? '',
      doorThickness: json['doorThickness'] ?? '',
    );
  }
}

class DoorMeasurement {
  int itemNumber;
  int quantity;
  double width;
  double height;
  String notes;

  DoorMeasurement({
    required this.itemNumber,
    required this.quantity,
    required this.width,
    required this.height,
    this.notes = '',
  });

  DoorMeasurement copyWith({
    int? itemNumber,
    int? quantity,
    double? width,
    double? height,
    String? notes,
  }) {
    return DoorMeasurement(
      itemNumber: itemNumber ?? this.itemNumber,
      quantity: quantity ?? this.quantity,
      width: width ?? this.width,
      height: height ?? this.height,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemNumber': itemNumber,
      'quantity': quantity,
      'width': width,
      'height': height,
      'notes': notes,
    };
  }

  factory DoorMeasurement.fromJson(Map<String, dynamic> json) {
    return DoorMeasurement(
      itemNumber: json['itemNumber'],
      quantity: json['quantity'],
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      notes: json['notes'] ?? '',
    );
  }
}

class DrawerMeasurement {
  int itemNumber;
  int quantity;
  double width;
  double height;
  String notes;

  DrawerMeasurement({
    required this.itemNumber,
    required this.quantity,
    required this.width,
    required this.height,
    this.notes = '',
  });

  DrawerMeasurement copyWith({
    int? itemNumber,
    int? quantity,
    double? width,
    double? height,
    String? notes,
  }) {
    return DrawerMeasurement(
      itemNumber: itemNumber ?? this.itemNumber,
      quantity: quantity ?? this.quantity,
      width: width ?? this.width,
      height: height ?? this.height,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemNumber': itemNumber,
      'quantity': quantity,
      'width': width,
      'height': height,
      'notes': notes,
    };
  }

  factory DrawerMeasurement.fromJson(Map<String, dynamic> json) {
    return DrawerMeasurement(
      itemNumber: json['itemNumber'],
      quantity: json['quantity'],
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      notes: json['notes'] ?? '',
    );
  }
}
