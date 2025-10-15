import { NextRequest, NextResponse } from 'next/server'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'
import { prisma } from '@/lib/prisma'

export async function GET(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session || session.user.role !== 'ADMIN') {
      return NextResponse.json({ error: 'No autorizado' }, { status: 401 })
    }

    const { searchParams } = new URL(request.url)
    const page = parseInt(searchParams.get('page') || '1')
    const limit = parseInt(searchParams.get('limit') || '10')
    const search = searchParams.get('search') || ''
    const projectId = searchParams.get('projectId')

    const skip = (page - 1) * limit

    const where: any = {}
    
    if (search) {
      where.OR = [
        { name: { contains: search, mode: 'insensitive' } },
        { description: { contains: search, mode: 'insensitive' } },
        { type: { contains: search, mode: 'insensitive' } },
        { material: { contains: search, mode: 'insensitive' } },
      ]
    }

    if (projectId) {
      where.projectId = projectId
    }

    const [furniture, total] = await Promise.all([
      prisma.furniture.findMany({
        where,
        include: {
          project: {
            select: {
              id: true,
              name: true,
              client: {
                select: {
                  name: true,
                }
              },
              carpenter: {
                select: {
                  companyName: true,
                  user: {
                    select: {
                      name: true,
                    }
                  }
                }
              }
            }
          }
        },
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' }
      }),
      prisma.furniture.count({ where })
    ])

    return NextResponse.json({
      furniture,
      pagination: {
        page,
        limit,
        total,
        pages: Math.ceil(total / limit)
      }
    })
  } catch (error) {
    console.error('Error fetching furniture:', error)
    return NextResponse.json(
      { error: 'Error interno del servidor' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const session = await getServerSession(authOptions)
    
    if (!session || session.user.role !== 'ADMIN') {
      return NextResponse.json({ error: 'No autorizado' }, { status: 401 })
    }

    const { 
      name, 
      description, 
      type, 
      dimensions, 
      material, 
      color, 
      quantity, 
      price, 
      notes, 
      projectId 
    } = await request.json()

    const furniture = await prisma.furniture.create({
      data: {
        name,
        description,
        type,
        dimensions,
        material,
        color,
        quantity: quantity || 1,
        price: price ? parseFloat(price) : null,
        notes,
        projectId,
      },
      include: {
        project: {
          select: {
            id: true,
            name: true,
            client: {
              select: {
                name: true,
              }
            }
          }
        }
      }
    })

    return NextResponse.json({
      message: 'Mueble creado exitosamente',
      furniture
    })
  } catch (error) {
    console.error('Error creating furniture:', error)
    return NextResponse.json(
      { error: 'Error interno del servidor' },
      { status: 500 }
    )
  }
}
