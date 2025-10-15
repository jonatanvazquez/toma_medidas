import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { prisma } from '@/lib/prisma'

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session || session.user.role !== 'ADMIN') {
      return NextResponse.json({ error: 'No autorizado' }, { status: 401 })
    }

    const carpenter = await prisma.carpenter.findUnique({
      where: { id: params.id },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
            createdAt: true,
          }
        },
        clients: {
          include: {
            _count: {
              select: {
                projects: true,
              }
            }
          }
        },
        projects: {
          include: {
            client: {
              select: {
                name: true,
                email: true,
              }
            },
            _count: {
              select: {
                furniture: true,
                doors: true,
              }
            }
          }
        }
      }
    })

    if (!carpenter) {
      return NextResponse.json(
        { error: 'Carpintero no encontrado' },
        { status: 404 }
      )
    }

    return NextResponse.json({ carpenter })
  } catch (error) {
    console.error('Error fetching carpenter:', error)
    return NextResponse.json(
      { error: 'Error interno del servidor' },
      { status: 500 }
    )
  }
}

export async function PUT(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session || session.user.role !== 'ADMIN') {
      return NextResponse.json({ error: 'No autorizado' }, { status: 401 })
    }

    const { name, email, companyName, phone, address } = await request.json()

    const carpenter = await prisma.carpenter.update({
      where: { id: params.id },
      data: {
        companyName,
        phone,
        address,
        user: {
          update: {
            name,
            email,
          }
        }
      },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
            createdAt: true,
          }
        }
      }
    })

    return NextResponse.json({
      message: 'Carpintero actualizado exitosamente',
      carpenter
    })
  } catch (error) {
    console.error('Error updating carpenter:', error)
    return NextResponse.json(
      { error: 'Error interno del servidor' },
      { status: 500 }
    )
  }
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session || session.user.role !== 'ADMIN') {
      return NextResponse.json({ error: 'No autorizado' }, { status: 401 })
    }

    await prisma.carpenter.delete({
      where: { id: params.id }
    })

    return NextResponse.json({
      message: 'Carpintero eliminado exitosamente'
    })
  } catch (error) {
    console.error('Error deleting carpenter:', error)
    return NextResponse.json(
      { error: 'Error interno del servidor' },
      { status: 500 }
    )
  }
}
