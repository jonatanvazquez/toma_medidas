'use client'

import DashboardLayout from '@/components/layout/DashboardLayout'
import CarpenterModal from '@/components/modals/CarpenterModal'
import { useState, useEffect } from 'react'
import { 
  Plus, 
  Search, 
  Edit, 
  Trash2, 
  Eye,
  Users,
  Package,
  Calendar,
  Mail,
  Phone,
  MapPin
} from 'lucide-react'

interface Carpenter {
  id: string
  companyName: string | null
  phone: string | null
  address: string | null
  createdAt: string
  user: {
    id: string
    name: string | null
    email: string
  }
  _count: {
    clients: number
    projects: number
  }
}

export default function CarpentersPage() {
  const [carpenters, setCarpenters] = useState<Carpenter[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [showModal, setShowModal] = useState(false)
  const [editingCarpenter, setEditingCarpenter] = useState<Carpenter | null>(null)

  useEffect(() => {
    fetchCarpenters()
  }, [])

  const fetchCarpenters = async () => {
    try {
      const response = await fetch('/api/carpenters')
      const data = await response.json()
      setCarpenters(data.carpenters || [])
    } catch (error) {
      console.error('Error fetching carpenters:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleDelete = async (id: string) => {
    if (!confirm('¿Estás seguro de que quieres eliminar este carpintero?')) {
      return
    }

    try {
      const response = await fetch(`/api/carpenters/${id}`, {
        method: 'DELETE'
      })

      if (response.ok) {
        setCarpenters(carpenters.filter(c => c.id !== id))
      }
    } catch (error) {
      console.error('Error deleting carpenter:', error)
    }
  }

  const handleSaveCarpenter = (newCarpenter: any) => {
    if (editingCarpenter) {
      setCarpenters(carpenters.map(c => c.id === newCarpenter.id ? newCarpenter : c))
    } else {
      setCarpenters([newCarpenter, ...carpenters])
    }
    setEditingCarpenter(null)
  }

  const filteredCarpenters = carpenters.filter(carpenter =>
    carpenter.user.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    carpenter.user.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
    carpenter.companyName?.toLowerCase().includes(searchTerm.toLowerCase())
  )

  if (loading) {
    return (
      <DashboardLayout>
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-primary-600"></div>
        </div>
      </DashboardLayout>
    )
  }

  return (
    <DashboardLayout>
      <div className="space-y-6">
        {/* Header */}
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Carpinteros</h1>
            <p className="text-gray-600">Gestiona los carpinteros registrados en el sistema</p>
          </div>
          <button
            onClick={() => setShowModal(true)}
            className="bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700 flex items-center space-x-2"
          >
            <Plus className="w-5 h-5" />
            <span>Agregar Carpintero</span>
          </button>
        </div>

        {/* Search */}
        <div className="bg-white p-4 rounded-lg shadow-sm">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5" />
            <input
              type="text"
              placeholder="Buscar carpinteros..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500 text-gray-900 bg-white"
            />
          </div>
        </div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-white p-6 rounded-lg shadow-sm">
            <div className="flex items-center">
              <div className="p-2 bg-primary-100 rounded-lg">
                <Users className="w-6 h-6 text-primary-600" />
              </div>
              <div className="ml-4">
                <p className="text-sm font-medium text-gray-600">Total Carpinteros</p>
                <p className="text-2xl font-bold text-gray-900">{carpenters.length}</p>
              </div>
            </div>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-sm">
            <div className="flex items-center">
              <div className="p-2 bg-green-100 rounded-lg">
                <Package className="w-6 h-6 text-green-600" />
              </div>
              <div className="ml-4">
                <p className="text-sm font-medium text-gray-600">Total Proyectos</p>
                <p className="text-2xl font-bold text-gray-900">
                  {carpenters.reduce((acc, c) => acc + c._count.projects, 0)}
                </p>
              </div>
            </div>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-sm">
            <div className="flex items-center">
              <div className="p-2 bg-blue-100 rounded-lg">
                <Users className="w-6 h-6 text-blue-600" />
              </div>
              <div className="ml-4">
                <p className="text-sm font-medium text-gray-600">Total Clientes</p>
                <p className="text-2xl font-bold text-gray-900">
                  {carpenters.reduce((acc, c) => acc + c._count.clients, 0)}
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Table */}
        <div className="bg-white rounded-lg shadow-sm overflow-hidden">
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Carpintero
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Empresa
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Contacto
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Estadísticas
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Fecha de Registro
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                    Acciones
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {filteredCarpenters.map((carpenter) => (
                  <tr key={carpenter.id} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <div className="flex-shrink-0 h-10 w-10">
                          <div className="h-10 w-10 rounded-full bg-primary-100 flex items-center justify-center">
                            <span className="text-sm font-medium text-primary-700">
                              {carpenter.user.name?.charAt(0) || 'C'}
                            </span>
                          </div>
                        </div>
                        <div className="ml-4">
                          <div className="text-sm font-medium text-gray-900">
                            {carpenter.user.name || 'Sin nombre'}
                          </div>
                          <div className="text-sm text-gray-500">{carpenter.user.email}</div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="text-sm text-gray-900">
                        {carpenter.companyName || 'Sin empresa'}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="space-y-1">
                        {carpenter.phone && (
                          <div className="flex items-center text-sm text-gray-500">
                            <Phone className="w-4 h-4 mr-1" />
                            {carpenter.phone}
                          </div>
                        )}
                        {carpenter.address && (
                          <div className="flex items-center text-sm text-gray-500">
                            <MapPin className="w-4 h-4 mr-1" />
                            {carpenter.address}
                          </div>
                        )}
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex space-x-4 text-sm text-gray-500">
                        <div className="flex items-center">
                          <Users className="w-4 h-4 mr-1" />
                          {carpenter._count.clients} clientes
                        </div>
                        <div className="flex items-center">
                          <Package className="w-4 h-4 mr-1" />
                          {carpenter._count.projects} proyectos
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {new Date(carpenter.createdAt).toLocaleDateString('es-ES')}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                      <div className="flex space-x-2">
                        <button
                          onClick={() => setEditingCarpenter(carpenter)}
                          className="text-primary-600 hover:text-primary-900"
                        >
                          <Edit className="w-4 h-4" />
                        </button>
                        <button
                          onClick={() => handleDelete(carpenter.id)}
                          className="text-red-600 hover:text-red-900"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {filteredCarpenters.length === 0 && (
          <div className="text-center py-12">
            <Users className="mx-auto h-12 w-12 text-gray-400" />
            <h3 className="mt-2 text-sm font-medium text-gray-900">No hay carpinteros</h3>
            <p className="mt-1 text-sm text-gray-500">
              {searchTerm ? 'No se encontraron carpinteros con ese criterio de búsqueda.' : 'Comienza agregando un carpintero.'}
            </p>
          </div>
        )}

        {/* Modal */}
        <CarpenterModal
          isOpen={showModal || !!editingCarpenter}
          onClose={() => {
            setShowModal(false)
            setEditingCarpenter(null)
          }}
          carpenter={editingCarpenter}
          onSave={handleSaveCarpenter}
        />
      </div>
    </DashboardLayout>
  )
}
