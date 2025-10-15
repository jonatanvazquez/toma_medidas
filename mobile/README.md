# Toma de Medidas - Aplicación Móvil

Aplicación móvil desarrollada en Flutter para reemplazar el formulario físico de toma de medidas para carpinteros de M&L Cabinet Doors LLC.

## Características

- **Pantalla Principal**: Dashboard con información de la empresa y acceso rápido a funciones principales
- **Registro de Clientes**: Formulario completo para capturar información del cliente y especificaciones técnicas
- **Toma de Medidas**: Sistema de pestañas para registrar medidas de puertas y cajones
- **Diseño Moderno**: Interfaz adaptada para dispositivos móviles con Material Design

## Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
└── screens/
    ├── home_screen.dart      # Pantalla principal
    ├── customer_form_screen.dart  # Formulario de registro de clientes
    └── measurements_screen.dart   # Pantalla de toma de medidas
```

## Pantallas Implementadas

### 1. Pantalla Principal (HomeScreen)
- Información de la empresa M&L Cabinet Doors LLC
- Acceso rápido a funciones principales:
  - Nuevo Cliente
  - Tomar Medidas
  - Historial (próximamente)
  - Configuración (próximamente)

### 2. Formulario de Cliente (CustomerFormScreen)
- Información del cliente:
  - Nombre, dirección, teléfono, email
  - Persona de contacto
  - Ubicación del trabajo
- Especificaciones técnicas:
  - Opening Overlay, Finish Sizes, Hinges
  - Wood Type, Door Style, Edge Profile
  - Panel Cut, Sticking Cut, Applied Molding
  - Door Thickness

### 3. Toma de Medidas (MeasurementsScreen)
- Sistema de pestañas para puertas y cajones
- Formularios dinámicos para agregar/editar medidas
- Campos para cantidad, ancho, alto y notas
- Sección de notas generales
- Validación de datos

## Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **Google Fonts**: Tipografía Inter para mejor legibilidad
- **Material Design**: Componentes y diseño consistente

## Instalación y Ejecución

1. Asegúrate de tener Flutter instalado en tu sistema
2. Navega a la carpeta del proyecto:
   ```bash
   cd mobile
   ```
3. Instala las dependencias:
   ```bash
   flutter pub get
   ```
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## Próximas Funcionalidades

- [ ] Integración con backend para persistencia de datos
- [ ] Pantalla de historial de trabajos
- [ ] Configuración de la aplicación
- [ ] Exportación de reportes
- [ ] Funcionalidad offline
- [ ] Sincronización de datos

## Diseño

La aplicación utiliza un esquema de colores basado en azul (#2196F3) como color principal, con acentos en verde para acciones positivas y naranja para acciones secundarias. La tipografía Inter proporciona una excelente legibilidad en dispositivos móviles.

## Contribución

Este proyecto está en desarrollo activo. Las funcionalidades de backend y persistencia de datos se implementarán en fases posteriores.
