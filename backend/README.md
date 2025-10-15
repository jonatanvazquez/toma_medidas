# Toma Medidas - Backend Dashboard

Dashboard de administrador para la aplicación Toma Medidas, construido con Next.js, PostgreSQL, Prisma y NextAuth.

## Características

- 🔐 Autenticación segura con NextAuth
- 📊 Dashboard moderno y responsive
- 👥 Gestión de carpinteros y clientes
- 📦 Gestión de proyectos, muebles y puertas
- 🎨 Diseño moderno con Tailwind CSS
- 🗄️ Base de datos PostgreSQL con Prisma ORM
- 📱 Responsive design

## Tecnologías

- **Frontend**: Next.js 14, React, TypeScript
- **Styling**: Tailwind CSS
- **Autenticación**: NextAuth.js
- **Base de datos**: PostgreSQL
- **ORM**: Prisma
- **Iconos**: Lucide React

## Instalación

1. Clona el repositorio
```bash
git clone <repository-url>
cd toma_medidas/backend
```

2. Instala las dependencias
```bash
npm install
```

3. Configura las variables de entorno
```bash
cp .env.example .env.local
```

Edita `.env.local` con tus configuraciones:
```env
DATABASE_URL="postgresql://postgres:@localhost:5432/medidas"
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-secret-key-here"
```

4. Configura la base de datos
```bash
npx prisma generate
npx prisma db push
```

5. Ejecuta el servidor de desarrollo
```bash
npm run dev
```

## Estructura del Proyecto

```
src/
├── app/                    # App Router de Next.js
│   ├── api/               # Rutas API
│   │   ├── auth/          # Autenticación
│   │   ├── carpenters/    # Gestión de carpinteros
│   │   ├── clients/       # Gestión de clientes
│   │   ├── projects/      # Gestión de proyectos
│   │   ├── furniture/     # Gestión de muebles
│   │   └── doors/         # Gestión de puertas
│   ├── auth/              # Páginas de autenticación
│   ├── dashboard/         # Dashboard principal
│   └── globals.css        # Estilos globales
├── components/            # Componentes reutilizables
│   └── layout/           # Componentes de layout
├── lib/                   # Utilidades y configuración
│   ├── auth.ts           # Configuración de NextAuth
│   └── prisma.ts         # Cliente de Prisma
└── types/                 # Tipos de TypeScript
```

## Modelos de Base de Datos

### User
- Información básica del usuario
- Roles: ADMIN, CARPENTER

### Carpenter
- Información del carpintero
- Relación con User
- Datos de empresa

### Client
- Información del cliente
- Relación con Carpenter

### Project
- Proyectos de carpintería
- Relación con Carpenter y Client
- Estados: ACTIVE, COMPLETED, CANCELLED, ON_HOLD

### Furniture
- Muebles del proyecto
- Relación con Project
- Detalles técnicos

### Door
- Puertas del proyecto
- Relación con Project
- Detalles técnicos

## API Endpoints

### Autenticación
- `POST /api/auth/register` - Registro de usuarios
- `POST /api/auth/[...nextauth]` - NextAuth endpoints

### Carpinteros
- `GET /api/carpenters` - Listar carpinteros
- `POST /api/carpenters` - Crear carpintero
- `GET /api/carpenters/[id]` - Obtener carpintero
- `PUT /api/carpenters/[id]` - Actualizar carpintero
- `DELETE /api/carpenters/[id]` - Eliminar carpintero

### Clientes
- `GET /api/clients` - Listar clientes
- `POST /api/clients` - Crear cliente

### Proyectos
- `GET /api/projects` - Listar proyectos
- `POST /api/projects` - Crear proyecto

### Muebles
- `GET /api/furniture` - Listar muebles
- `POST /api/furniture` - Crear mueble

### Puertas
- `GET /api/doors` - Listar puertas
- `POST /api/doors` - Crear puerta

## Despliegue en Vercel

1. Conecta tu repositorio a Vercel
2. Configura las variables de entorno en Vercel
3. Despliega automáticamente

### Variables de entorno para Vercel:
```env
DATABASE_URL="postgresql://user:password@host:port/database"
NEXTAUTH_URL="https://your-domain.vercel.app"
NEXTAUTH_SECRET="your-secret-key"
```

## Scripts Disponibles

- `npm run dev` - Servidor de desarrollo
- `npm run build` - Construir para producción
- `npm run start` - Servidor de producción
- `npm run lint` - Linter
- `npm run db:push` - Sincronizar esquema con la base de datos
- `npm run db:generate` - Generar cliente de Prisma
- `npm run db:studio` - Abrir Prisma Studio

## Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.
