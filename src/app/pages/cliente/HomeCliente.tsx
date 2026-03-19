import { Link } from "react-router";
import { FileText, History, Truck, MapPin, User, Bell, Car } from "lucide-react";
import { Card, CardContent } from "../../components/ui/card";
import { Badge } from "../../components/ui/badge";

export function HomeCliente() {
  const menuItems = [
    {
      title: "Meus Veículos",
      description: "Atualize quilometragem e veja alertas",
      icon: Car,
      path: "/cliente/veiculos",
      color: "from-indigo-500 to-indigo-600",
      badge: "Novo",
    },
    {
      title: "Meus Orçamentos",
      description: "Visualize seus orçamentos",
      icon: FileText,
      path: "/cliente/orcamentos",
      color: "from-blue-500 to-blue-600",
      badge: "2 novos",
    },
    {
      title: "Histórico de Manutenção",
      description: "Veja o histórico dos seus veículos",
      icon: History,
      path: "/cliente/historico",
      color: "from-green-500 to-green-600",
    },
    {
      title: "Solicitar Guincho",
      description: "Precisa de reboque?",
      icon: Truck,
      path: "/cliente/guincho",
      color: "from-red-500 to-red-600",
      badge: "24h",
    },
    {
      title: "Oficinas Credenciadas",
      description: "Encontre a mais próxima",
      icon: MapPin,
      path: "/cliente/oficinas",
      color: "from-purple-500 to-purple-600",
    },
  ];

  return (
    <div className="p-4">
      {/* Header com perfil do usuário */}
      <Card className="mb-6 bg-gradient-to-r from-blue-600 to-blue-700 text-white border-0">
        <CardContent className="p-4">
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-3">
              <div className="bg-white/20 p-3 rounded-full">
                <User className="w-6 h-6 text-white" />
              </div>
              <div>
                <h2 className="font-bold text-lg">Olá, João Silva!</h2>
                <p className="text-blue-100 text-sm">Bem-vindo de volta</p>
              </div>
            </div>
            <div className="relative">
              <Bell className="w-6 h-6 text-white" />
              <div className="absolute -top-1 -right-1 bg-red-500 w-4 h-4 rounded-full flex items-center justify-center">
                <span className="text-xs font-bold">2</span>
              </div>
            </div>
          </div>
          
          {/* Veículos do usuário */}
          <div className="bg-white/10 rounded-lg p-3 mt-3">
            <p className="text-blue-100 text-xs mb-2">Seus Veículos</p>
            <div className="flex gap-2 overflow-x-auto">
              <Badge className="bg-white/20 text-white border-0 whitespace-nowrap">
                ABC-1234 - Gol 2020
              </Badge>
              <Badge className="bg-white/20 text-white border-0 whitespace-nowrap">
                DEF-5678 - Civic 2021
              </Badge>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Avisos importantes */}
      <Card className="mb-6 bg-amber-50 border-amber-200">
        <CardContent className="p-4">
          <div className="flex items-start gap-3">
            <div className="bg-amber-500 p-2 rounded-lg">
              <Bell className="w-4 h-4 text-white" />
            </div>
            <div className="flex-1">
              <h3 className="font-semibold text-slate-800 text-sm">
                Revisão Programada
              </h3>
              <p className="text-xs text-slate-600 mt-1">
                Seu Gol 2020 está próximo dos 50.000 km. Agende sua revisão!
              </p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Menu Principal */}
      <div className="mb-4">
        <h3 className="text-lg font-bold text-slate-800 mb-3">
          O que você precisa?
        </h3>

        <div className="grid grid-cols-1 gap-3">
          {menuItems.map((item) => {
            const Icon = item.icon;
            return (
              <Link key={item.path} to={item.path}>
                <Card className="hover:shadow-lg transition-all active:scale-95">
                  <CardContent className="p-4">
                    <div className="flex items-center gap-4">
                      <div className={`bg-gradient-to-br ${item.color} p-3 rounded-xl shadow-md`}>
                        <Icon className="w-6 h-6 text-white" />
                      </div>
                      <div className="flex-1">
                        <div className="flex items-center gap-2">
                          <h3 className="font-semibold text-slate-800">
                            {item.title}
                          </h3>
                          {item.badge && (
                            <Badge variant="secondary" className="text-xs">
                              {item.badge}
                            </Badge>
                          )}
                        </div>
                        <p className="text-sm text-slate-600">
                          {item.description}
                        </p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </Link>
            );
          })}
        </div>
      </div>

      {/* Dicas rápidas */}
      <Card className="bg-blue-50 border-blue-200">
        <CardContent className="p-4">
          <h3 className="font-semibold text-slate-800 text-sm mb-2">
            💡 Dica do ProMec
          </h3>
          <p className="text-xs text-slate-600">
            Mantenha a quilometragem dos seus veículos atualizada para receber alertas de manutenção no momento certo.
          </p>
        </CardContent>
      </Card>
    </div>
  );
}