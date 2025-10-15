const { PrismaClient } = require('@prisma/client')
const bcrypt = require('bcryptjs')

const prisma = new PrismaClient()

async function createAdmin() {
  try {
    // Verificar si ya existe un admin
    const existingAdmin = await prisma.user.findFirst({
      where: { role: 'ADMIN' }
    })

    if (existingAdmin) {
      console.log('Ya existe un usuario administrador:', existingAdmin.email)
      return
    }

    // Crear usuario administrador
    const hashedPassword = await bcrypt.hash('admin123', 12)
    
    const admin = await prisma.user.create({
      data: {
        name: 'Administrador',
        email: 'admin@toma-medidas.com',
        password: hashedPassword,
        role: 'ADMIN',
      }
    })

    console.log('Usuario administrador creado exitosamente:')
    console.log('Email:', admin.email)
    console.log('Contraseña: admin123')
    console.log('Rol:', admin.role)
    
  } catch (error) {
    console.error('Error creando administrador:', error)
  } finally {
    await prisma.$disconnect()
  }
}

createAdmin()
