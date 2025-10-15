'use client'

import DashboardLayout from '@/components/layout/DashboardLayout'
import { 
  Users, 
  Hammer, 
  Package, 
  TrendingUp,
  Calendar,
  DollarSign,
  Activity
} from 'lucide-react'

const stats = [
  {
    name: 'Total Carpinteros',
    value: '24',
    change: '+12%',
    changeType: 'positive',
    icon: Hammer,
  },
  {
    name: 'Total Clientes',
    value: '156',
    change: '+8%',
    changeType: 'positive',
    icon: Users,
  },
  {
    name: 'Proyectos Activos',
    value: '89',
    change: '+23%',
    changeType: 'positive',
    icon: Package,
  },
  {
    name: 'Ingresos del Mes',
    value: '$45,231',
    change: '+15%',
    changeType: 'positive',
    icon: DollarSign,
  },
]

const recentActivities = [
  {
    id: 1,
    user: 'Juan Pérez',
    action: 'Creó un nuevo proyecto',
    target: 'Cocina Moderna',
    time: 'Hace 2 horas',
    avatar: 'JP',
  },
  {
    id: 2,
    user: 'María García',
    action: 'Agregó muebles al proyecto',
    target: 'Dormitorio Principal',
    time: 'Hace 4 horas',
    avatar: 'MG',
  },
  {
    id: 3,
    user: 'Carlos López',
    action: 'Completó proyecto',
    target: 'Sala de Estar',
    time: 'Hace 6 horas',
    avatar: 'CL',
  },
  {
    id: 4,
    user: 'Ana Martínez',
    action: 'Registró nuevo cliente',
    target: 'Roberto Silva',
    time: 'Hace 8 horas',
    avatar: 'AM',
  },
]

export default function DashboardPage() {
  return (
    <DashboardLayout>
      <div className="space-y-6">
        {/* Header */}
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Dashboard</h1>
          <p className="text-gray-600">Bienvenido al panel de administración de Toma Medidas</p>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {stats.map((stat) => (
            <div key={stat.name} className="bg-white rounded-lg shadow-sm p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{stat.name}</p>
                  <p className="text-2xl font-bold text-gray-900">{stat.value}</p>
                </div>
                <div className="flex items-center space-x-2">
                  <stat.icon className="w-8 h-8 text-primary-600" />
                </div>
              </div>
              <div className="mt-4 flex items-center">
                <span className={`text-sm font-medium ${
                  stat.changeType === 'positive' ? 'text-green-600' : 'text-red-600'
                }`}>
                  {stat.change}
                </span>
                <span className="text-sm text-gray-500 ml-2">vs mes anterior</span>
              </div>
            </div>
          ))}
        </div>

        {/* Charts and Activities */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Chart Placeholder */}
          <div className="bg-white rounded-lg shadow-sm p-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold text-gray-900">Proyectos por Mes</h3>
              <TrendingUp className="w-5 h-5 text-gray-400" />
            </div>
            <div className="h-64 bg-gray-50 rounded-lg flex items-center justify-center">
              <div className="text-center">
                <TrendingUp className="w-12 h-12 text-gray-400 mx-auto mb-2" />
                <p className="text-gray-500">Gráfico de proyectos</p>
                <p className="text-sm text-gray-400">(Integrar con Chart.js o similar)</p>
              </div>
            </div>
          </div>

          {/* Recent Activities */}
          <div className="bg-white rounded-lg shadow-sm p-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="text-lg font-semibold text-gray-900">Actividad Reciente</h3>
              <Activity className="w-5 h-5 text-gray-400" />
            </div>
            <div className="space-y-4">
              {recentActivities.map((activity) => (
                <div key={activity.id} className="flex items-start space-x-3">
                  <div className="w-8 h-8 bg-primary-100 rounded-full flex items-center justify-center">
                    <span className="text-xs font-medium text-primary-700">
                      {activity.avatar}
                    </span>
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm text-gray-900">
                      <span className="font-medium">{activity.user}</span>{' '}
                      {activity.action}{' '}
                      <span className="font-medium">{activity.target}</span>
                    </p>
                    <p className="text-xs text-gray-500">{activity.time}</p>
                  </div>
                </div>
              ))}
            </div>
            <div className="mt-4">
              <button className="text-sm text-primary-600 hover:text-primary-500 font-medium">
                Ver toda la actividad
              </button>
            </div>
          </div>
        </div>

        {/* Quick Actions */}
        <div className="bg-white rounded-lg shadow-sm p-6">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">Acciones Rápidas</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <button className="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
              <Users className="w-6 h-6 text-primary-600 mr-3" />
              <div className="text-left">
                <p className="font-medium text-gray-900">Registrar Carpintero</p>
                <p className="text-sm text-gray-500">Agregar nuevo carpintero</p>
              </div>
            </button>
            <button className="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
              <Package className="w-6 h-6 text-primary-600 mr-3" />
              <div className="text-left">
                <p className="font-medium text-gray-900">Crear Proyecto</p>
                <p className="text-sm text-gray-500">Iniciar nuevo proyecto</p>
              </div>
            </button>
            <button className="flex items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
              <Calendar className="w-6 h-6 text-primary-600 mr-3" />
              <div className="text-left">
                <p className="font-medium text-gray-900">Ver Reportes</p>
                <p className="text-sm text-gray-500">Generar reportes</p>
              </div>
            </button>
          </div>
        </div>
      </div>
    </DashboardLayout>
  )
}
