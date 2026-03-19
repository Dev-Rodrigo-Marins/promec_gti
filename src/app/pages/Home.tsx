import { Link } from "react-router";
import { Car, Search, Calendar, FileText, TrendingUp, Wrench, Plus } from "lucide-react";
import { Card, CardContent } from "../components/ui/card";

export function Home() {
  const menuItems = [
    {
      title: "Cadastrar Veículo",
      description: "Adicione novos veículos",
      icon: Car,
      path: "/cadastrar-veiculo",
      color: "from-blue-500 to-blue-600",
    },
    {
      title: "Procurar Veículo",
      description: "Busque veículos cadastrados",
      icon: Search,
      path: "/procurar-veiculo",
      color: "from-green-500 to-green-600",
    },
    {
      title: "Visualizar Agenda",
      description: "Gerencie agendamentos",
      icon: Calendar,
      path: "/agenda",
      color: "from-purple-500 to-purple-600",
    },
    {
      title: "Visualizar Orçamentos",
      description: "Consulte orçamentos",
      icon: FileText,
      path: "/orcamentos",
      color: "from-orange-500 to-orange-600",
    },
    {
      title: "Cadastrar Serviços",
      description: "Gerencie serviços disponíveis",
      icon: Wrench,
      path: "/cadastrar-servicos",
      color: "from-indigo-500 to-indigo-600",
    },
    {
      title: "Montar Orçamento",
      description: "Crie novos orçamentos",
      icon: Plus,
      path: "/montar-orcamento",
      color: "from-teal-500 to-teal-600",
    },
  ];

  return (
    <div className="p-4">
      {/* Stats Cards */}
      <div className="grid grid-cols-2 gap-3 mb-6">
        <Card className="bg-gradient-to-br from-blue-500 to-blue-600 text-white border-0">
          <CardContent className="p-4">
            <div className="text-2xl font-bold">24</div>
            <div className="text-xs text-blue-100">Veículos</div>
          </CardContent>
        </Card>
        <Card className="bg-gradient-to-br from-green-500 to-green-600 text-white border-0">
          <CardContent className="p-4">
            <div className="text-2xl font-bold">8</div>
            <div className="text-xs text-green-100">Hoje</div>
          </CardContent>
        </Card>
      </div>

      {/* Seção Principal */}
      <div className="mb-6">
        <h2 className="text-xl font-bold text-slate-800 mb-1">
          Menu Principal
        </h2>
        <p className="text-slate-600 text-sm mb-4">
          Acesse as funcionalidades
        </p>

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
                        <h3 className="font-semibold text-slate-800">
                          {item.title}
                        </h3>
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

      {/* Atividade Recente */}
      <Card className="bg-blue-50 border-blue-200">
        <CardContent className="p-4">
          <div className="flex items-start gap-3">
            <TrendingUp className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <h3 className="font-semibold text-slate-800 text-sm mb-1">
                Atividade Recente
              </h3>
              <p className="text-xs text-slate-600">
                5 novos agendamentos esta semana
              </p>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}