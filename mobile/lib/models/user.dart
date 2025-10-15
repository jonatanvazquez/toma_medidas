class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String company;
  final String role;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final bool isActive;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone = '',
    this.company = '',
    this.role = 'user',
    required this.createdAt,
    this.lastLoginAt,
    this.isActive = true,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? company,
    String? role,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      company: company ?? this.company,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'company': company,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'isActive': isActive,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'] ?? '',
      company: json['company'] ?? '',
      role: json['role'] ?? 'user',
      createdAt: DateTime.parse(json['createdAt']),
      lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt']) : null,
      isActive: json['isActive'] ?? true,
    );
  }
}

class AuthResult {
  final bool success;
  final String? error;
  final User? user;
  final String? token;

  AuthResult({
    required this.success,
    this.error,
    this.user,
    this.token,
  });

  factory AuthResult.success({required User user, String? token}) {
    return AuthResult(
      success: true,
      user: user,
      token: token,
    );
  }

  factory AuthResult.error(String error) {
    return AuthResult(
      success: false,
      error: error,
    );
  }
}

class LoginCredentials {
  final String email;
  final String password;

  LoginCredentials({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class RegisterCredentials {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;
  final String phone;
  final String company;

  RegisterCredentials({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    this.phone = '',
    this.company = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'company': company,
    };
  }

  bool get isValid {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        name.isNotEmpty &&
        password == confirmPassword &&
        password.length >= 6;
  }

  String? get passwordError {
    if (password.isEmpty) return 'La contraseña es requerida';
    if (password.length < 6) return 'La contraseña debe tener al menos 6 caracteres';
    if (password != confirmPassword) return 'Las contraseñas no coinciden';
    return null;
  }
}
