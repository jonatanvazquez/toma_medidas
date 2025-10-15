class AppSettings {
  final String companyName;
  final String companyAddress;
  final String companyPhone;
  final String companyEmail;
  final bool enableNotifications;
  final bool enableDarkMode;
  final String defaultWoodType;
  final String defaultDoorThickness;
  final String defaultOpeningOverlay;
  final bool autoSave;
  final int maxHistoryItems;
  final String exportFormat;

  AppSettings({
    this.companyName = 'M&L Cabinet Doors LLC',
    this.companyAddress = '5706 West 34th St, Suite A\nHouston TX 77092',
    this.companyPhone = '(713) 242-8284',
    this.companyEmail = 'info@mlcabinetdoors.com',
    this.enableNotifications = true,
    this.enableDarkMode = false,
    this.defaultWoodType = 'Oak',
    this.defaultDoorThickness = '3/4"',
    this.defaultOpeningOverlay = '1/2"',
    this.autoSave = true,
    this.maxHistoryItems = 100,
    this.exportFormat = 'PDF',
  });

  AppSettings copyWith({
    String? companyName,
    String? companyAddress,
    String? companyPhone,
    String? companyEmail,
    bool? enableNotifications,
    bool? enableDarkMode,
    String? defaultWoodType,
    String? defaultDoorThickness,
    String? defaultOpeningOverlay,
    bool? autoSave,
    int? maxHistoryItems,
    String? exportFormat,
  }) {
    return AppSettings(
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyPhone: companyPhone ?? this.companyPhone,
      companyEmail: companyEmail ?? this.companyEmail,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableDarkMode: enableDarkMode ?? this.enableDarkMode,
      defaultWoodType: defaultWoodType ?? this.defaultWoodType,
      defaultDoorThickness: defaultDoorThickness ?? this.defaultDoorThickness,
      defaultOpeningOverlay: defaultOpeningOverlay ?? this.defaultOpeningOverlay,
      autoSave: autoSave ?? this.autoSave,
      maxHistoryItems: maxHistoryItems ?? this.maxHistoryItems,
      exportFormat: exportFormat ?? this.exportFormat,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyAddress': companyAddress,
      'companyPhone': companyPhone,
      'companyEmail': companyEmail,
      'enableNotifications': enableNotifications,
      'enableDarkMode': enableDarkMode,
      'defaultWoodType': defaultWoodType,
      'defaultDoorThickness': defaultDoorThickness,
      'defaultOpeningOverlay': defaultOpeningOverlay,
      'autoSave': autoSave,
      'maxHistoryItems': maxHistoryItems,
      'exportFormat': exportFormat,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      companyName: json['companyName'] ?? 'M&L Cabinet Doors LLC',
      companyAddress: json['companyAddress'] ?? '5706 West 34th St, Suite A\nHouston TX 77092',
      companyPhone: json['companyPhone'] ?? '(713) 242-8284',
      companyEmail: json['companyEmail'] ?? 'info@mlcabinetdoors.com',
      enableNotifications: json['enableNotifications'] ?? true,
      enableDarkMode: json['enableDarkMode'] ?? false,
      defaultWoodType: json['defaultWoodType'] ?? 'Oak',
      defaultDoorThickness: json['defaultDoorThickness'] ?? '3/4"',
      defaultOpeningOverlay: json['defaultOpeningOverlay'] ?? '1/2"',
      autoSave: json['autoSave'] ?? true,
      maxHistoryItems: json['maxHistoryItems'] ?? 100,
      exportFormat: json['exportFormat'] ?? 'PDF',
    );
  }
}
