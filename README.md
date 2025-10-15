# Toma Medidas

Una aplicación completa para la gestión de medidas y trabajos de carpintería, que incluye un backend web desarrollado con Next.js y una aplicación móvil desarrollada con Flutter.

## 📋 Descripción

Toma Medidas es una solución integral diseñada para profesionales de la carpintería y construcción que necesitan gestionar medidas, trabajos y clientes de manera eficiente. La aplicación permite:

- Registro y gestión de clientes
- Toma de medidas en sitio
- Historial de trabajos realizados
- Gestión de usuarios y autenticación
- Dashboard administrativo

## 🏗️ Arquitectura del Proyecto

El proyecto está dividido en dos partes principales:

### Backend (Next.js)
- **Tecnologías**: Next.js 14, TypeScript, Prisma, NextAuth.js
- **Base de datos**: PostgreSQL
- **Autenticación**: NextAuth.js
- **API**: RESTful API con Next.js API Routes

### Mobile (Flutter)
- **Tecnologías**: Flutter, Dart
- **Plataformas**: Android, iOS
- **Estado**: Provider/Riverpod
- **Navegación**: Flutter Navigation

## 🚀 Instalación y Configuración

### Prerrequisitos

- Node.js (v18 o superior)
- Flutter SDK (v3.0 o superior)
- PostgreSQL
- Git

### Backend

1. Navega al directorio del backend:
```bash
cd backend
```

2. Instala las dependencias:
```bash
npm install
# o
pnpm install
```

3. Configura las variables de entorno:
```bash
cp .env.example .env.local
```

4. Configura la base de datos:
```bash
npx prisma generate
npx prisma db push
```

5. Ejecuta el servidor de desarrollo:
```bash
npm run dev
# o
pnpm dev
```

### Mobile

1. Navega al directorio mobile:
```bash
cd mobile
```

2. Instala las dependencias:
```bash
flutter pub get
```

3. Ejecuta la aplicación:
```bash
flutter run
```

## 📁 Estructura del Proyecto

```
toma_medidas/
├── backend/                 # Aplicación web Next.js
│   ├── src/
│   │   ├── app/            # Páginas y API routes
│   │   ├── components/     # Componentes React
│   │   ├── lib/            # Utilidades y configuración
│   │   └── types/          # Definiciones de tipos
│   ├── prisma/             # Esquema de base de datos
│   └── public/             # Archivos estáticos
├── mobile/                 # Aplicación Flutter
│   ├── lib/
│   │   ├── models/         # Modelos de datos
│   │   ├── screens/        # Pantallas de la app
│   │   └── services/      # Servicios y APIs
│   ├── android/           # Configuración Android
│   └── ios/               # Configuración iOS
└── README.md
```

## 🔧 Tecnologías Utilizadas

### Backend
- **Next.js 14**: Framework React para desarrollo web
- **TypeScript**: Tipado estático para JavaScript
- **Prisma**: ORM para base de datos
- **NextAuth.js**: Autenticación
- **Tailwind CSS**: Framework CSS
- **PostgreSQL**: Base de datos relacional

### Mobile
- **Flutter**: Framework de desarrollo móvil
- **Dart**: Lenguaje de programación
- **Provider**: Gestión de estado
- **HTTP**: Cliente HTTP para APIs

## 📱 Características

### Backend
- ✅ Sistema de autenticación completo
- ✅ Dashboard administrativo
- ✅ API REST para comunicación con mobile
- ✅ Gestión de usuarios y permisos
- ✅ Base de datos con Prisma

### Mobile
- ✅ Autenticación de usuarios
- ✅ Formulario de clientes
- ✅ Pantalla de medidas
- ✅ Historial de trabajos
- ✅ Configuraciones de la app

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Autor

**Jonatan Vazquez**
- GitHub: [@jonatanvazquez](https://github.com/jonatanvazquez)

## 📞 Contacto

Si tienes alguna pregunta o sugerencia, no dudes en contactarme a través de GitHub Issues.

---

⭐ Si te gusta este proyecto, ¡dale una estrella!
