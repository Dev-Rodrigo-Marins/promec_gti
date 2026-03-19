import { Outlet, Link, useLocation } from "react-router";
import { Wrench, Home, FileText, History, Truck, Car } from "lucide-react";

export function LayoutCliente() {
  const location = useLocation();

  const navItems = [
    { path: "/cliente", icon: Home, label: "Início" },
    { path: "/cliente/veiculos", icon: Car, label: "Veículos" },
    { path: "/cliente/orcamentos", icon: FileText, label: "Orçamentos" },
    { path: "/cliente/historico", icon: History, label: "Histórico" },
    { path: "/cliente/guincho", icon: Truck, label: "Guincho" },
  ];

  return (
    <div className="min-h-screen bg-slate-50 flex flex-col max-w-md mx-auto shadow-2xl">
      {/* Header fixo estilo mobile */}
      <header className="bg-gradient-to-r from-blue-600 to-blue-700 text-white shadow-lg sticky top-0 z-50">
        <div className="px-4 py-4">
          <div className="flex items-center gap-3">
            <div className="bg-white p-2 rounded-xl">
              <Wrench className="w-6 h-6 text-blue-600" />
            </div>
            <div>
              <h1 className="text-xl font-bold tracking-tight">ProMec-GTI</h1>
              <p className="text-blue-100 text-xs">Área do Cliente</p>
            </div>
          </div>
        </div>
      </header>

      {/* Conteúdo principal com padding bottom para navegação */}
      <main className="flex-1 overflow-y-auto pb-20">
        <Outlet />
      </main>

      {/* Bottom Navigation estilo mobile */}
      <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-slate-200 shadow-lg max-w-md mx-auto">
        <div className="grid grid-cols-5 gap-1">
          {navItems.map((item) => {
            const Icon = item.icon;
            const isActive = location.pathname === item.path;
            return (
              <Link
                key={item.path}
                to={item.path}
                className={`flex flex-col items-center justify-center py-2 px-1 transition-colors ${
                  isActive
                    ? "text-blue-600"
                    : "text-slate-500 hover:text-blue-600"
                }`}
              >
                <Icon className={`w-6 h-6 mb-1 ${isActive ? "fill-blue-600" : ""}`} />
                <span className="text-xs font-medium">{item.label}</span>
              </Link>
            );
          })}
        </div>
      </nav>
    </div>
  );
}