import 'dart:async';
import '../models/user.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;
  final StreamController<User?> _userController = StreamController<User?>.broadcast();

  Stream<User?> get userStream => _userController.stream;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<AuthResult> login(LoginCredentials credentials) async {
    try {
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 1));

      // Simular validación de credenciales
      if (credentials.email == 'admin@mlcabinetdoors.com' && 
          credentials.password == 'admin123') {
        _currentUser = User(
          id: '1',
          email: credentials.email,
          name: 'Administrador',
          phone: '(713) 242-8284',
          company: 'M&L Cabinet Doors LLC',
          role: 'admin',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          lastLoginAt: DateTime.now(),
        );
      } else if (credentials.email == 'user@mlcabinetdoors.com' && 
                 credentials.password == 'user123') {
        _currentUser = User(
          id: '2',
          email: credentials.email,
          name: 'Usuario Demo',
          phone: '(713) 555-0123',
          company: 'M&L Cabinet Doors LLC',
          role: 'user',
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          lastLoginAt: DateTime.now(),
        );
      } else {
        return AuthResult.error('Credenciales inválidas');
      }

      _userController.add(_currentUser);
      return AuthResult.success(user: _currentUser!);
    } catch (e) {
      return AuthResult.error('Error al iniciar sesión: ${e.toString()}');
    }
  }

  Future<AuthResult> register(RegisterCredentials credentials) async {
    try {
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 1));

      // Simular validación de email único
      if (credentials.email == 'admin@mlcabinetdoors.com' || 
          credentials.email == 'user@mlcabinetdoors.com') {
        return AuthResult.error('Este correo electrónico ya está registrado');
      }

      // Crear nuevo usuario
      _currentUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: credentials.email,
        name: credentials.name,
        phone: credentials.phone,
        company: credentials.company,
        role: 'user',
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
      );

      _userController.add(_currentUser);
      return AuthResult.success(user: _currentUser!);
    } catch (e) {
      return AuthResult.error('Error al crear la cuenta: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _userController.add(null);
  }

  Future<void> forgotPassword(String email) async {
    // Simular envío de email
    await Future.delayed(const Duration(seconds: 1));
    
    // En una implementación real, aquí se enviaría un email
    // con instrucciones para restablecer la contraseña
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    if (_currentUser == null) return false;

    try {
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 1));

      // En una implementación real, aquí se validaría la contraseña actual
      // y se actualizaría la nueva contraseña
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User?> updateProfile({
    String? name,
    String? phone,
    String? company,
  }) async {
    if (_currentUser == null) return null;

    try {
      // Simular delay de red
      await Future.delayed(const Duration(seconds: 1));

      _currentUser = _currentUser!.copyWith(
        name: name ?? _currentUser!.name,
        phone: phone ?? _currentUser!.phone,
        company: company ?? _currentUser!.company,
      );

      _userController.add(_currentUser);
      return _currentUser;
    } catch (e) {
      return null;
    }
  }

  void dispose() {
    _userController.close();
  }
}
