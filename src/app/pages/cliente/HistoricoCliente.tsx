import { useState } from "react";
import { Card, CardContent } from "../../components/ui/card";
import { Badge } from "../../components/ui/badge";
import { Button } from "../../components/ui/button";
import { History, Car, Calendar, Wrench, DollarSign, ChevronDown, ChevronUp } from "lucide-react";

const veiculosHistorico = [
  {
    id: 1,
    placa: "ABC-1234",
    modelo: "Volkswagen Gol 2020",
    cor: "Prata",
    km: "48.500 km",
    manutencoes: [
      {
        id: 1,
        data: "05/03/2026",
        km: "48.200 km",
        servicos: ["Troca de Pastilhas de Freio", "Revisão de Freios"],
        oficina: "Auto Center Silva",
        valor: 450.0,
        tipo: "corretiva",
      },
      {
        id: 2,
        data: "15/01/2026",
        km: "45.000 km",
        servicos: ["Revisão dos 45.000 km", "Troca de Óleo", "Filtros"],
        oficina: "Auto Center Silva",
        valor: 680.0,
        tipo: "preventiva",
      },
      {
        id: 3,
        data: "20/09/2025",
        km: "40.000 km",
        servicos: ["Revisão dos 40.000 km", "Alinhamento", "Balanceamento"],
        oficina: "Mecânica João Santos",
        valor: 520.0,
        tipo: "preventiva",
      },
    ],
  },
  {
    id: 2,
    placa: "DEF-5678",
    modelo: "Honda Civic 2021",
    cor: "Preto",
    km: "22.300 km",
    manutencoes: [
      {
        id: 4,
        data: "10/03/2026",
        km: "22.100 km",
        servicos: ["Alinhamento", "Balanceamento", "Calibragem"],
        oficina: "Mecânica João Santos",
        valor: 280.0,
        tipo: "preventiva",
      },
      {
        id: 5,
        data: "10/12/2025",
        km: "20.000 km",
        servicos: ["Revisão dos 20.000 km", "Troca de Óleo"],
        oficina: "Honda Autorizada",
        valor: 890.0,
        tipo: "preventiva",
      },
    ],
  },
];

export function HistoricoCliente() {
  const [expandedVeiculo, setExpandedVeiculo] = useState<number | null>(null);

  const toggleVeiculo = (id: number) => {
    setExpandedVeiculo(expandedVeiculo === id ? null : id);
  };

  const getTipoColor = (tipo: string) => {
    return tipo === "preventiva" 
      ? "bg-blue-100 text-blue-800 border-blue-300" 
      : "bg-orange-100 text-orange-800 border-orange-300";
  };

  const getTipoText = (tipo: string) => {
    return tipo === "preventiva" ? "Preventiva" : "Corretiva";
  };

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Histórico de Manutenção</h2>
        <p className="text-slate-600 text-sm">Acompanhe a manutenção dos seus veículos</p>
      </div>

      {/* Resumo */}
      <div className="grid grid-cols-3 gap-2 mb-4">
        <Card className="bg-blue-50 border-blue-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-blue-600">7</div>
            <div className="text-xs text-slate-600">Manutenções</div>
          </CardContent>
        </Card>
        <Card className="bg-green-50 border-green-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-green-600">R$ 3,3k</div>
            <div className="text-xs text-slate-600">Investido</div>
          </CardContent>
        </Card>
        <Card className="bg-purple-50 border-purple-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-purple-600">2</div>
            <div className="text-xs text-slate-600">Veículos</div>
          </CardContent>
        </Card>
      </div>

      {/* Lista de veículos */}
      <div className="space-y-3">
        {veiculosHistorico.map((veiculo) => (
          <div key={veiculo.id}>
            <Card className="active:scale-98 transition-transform">
              <CardContent className="p-4">
                <div
                  className="flex items-center justify-between cursor-pointer"
                  onClick={() => toggleVeiculo(veiculo.id)}
                >
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-green-500 to-green-600 p-2.5 rounded-lg">
                      <Car className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-slate-800">{veiculo.modelo}</h3>
                      <div className="flex gap-2 mt-1">
                        <Badge variant="secondary" className="text-xs">{veiculo.placa}</Badge>
                        <Badge variant="outline" className="text-xs">{veiculo.km}</Badge>
                      </div>
                    </div>
                  </div>
                  <div className="text-right flex items-center gap-2">
                    <div>
                      <div className="text-sm font-semibold text-slate-800">
                        {veiculo.manutencoes.length} manutenções
                      </div>
                      <div className="text-xs text-slate-600">
                        R$ {veiculo.manutencoes.reduce((acc, m) => acc + m.valor, 0).toFixed(2)}
                      </div>
                    </div>
                    {expandedVeiculo === veiculo.id ? (
                      <ChevronUp className="w-5 h-5 text-slate-400" />
                    ) : (
                      <ChevronDown className="w-5 h-5 text-slate-400" />
                    )}
                  </div>
                </div>

                {/* Histórico expandido */}
                {expandedVeiculo === veiculo.id && (
                  <div className="mt-4 pt-4 border-t space-y-3">
                    {veiculo.manutencoes.map((manutencao) => (
                      <div key={manutencao.id} className="bg-slate-50 rounded-lg p-3">
                        <div className="flex items-start justify-between mb-2">
                          <div>
                            <div className="flex items-center gap-2 mb-1">
                              <Wrench className="w-4 h-4 text-slate-600" />
                              <span className="font-medium text-sm text-slate-800">
                                {manutencao.oficina}
                              </span>
                            </div>
                            <div className="flex items-center gap-2 text-xs text-slate-600">
                              <Calendar className="w-3 h-3" />
                              <span>{manutencao.data}</span>
                              <span>•</span>
                              <span>{manutencao.km}</span>
                            </div>
                          </div>
                          <Badge className={`${getTipoColor(manutencao.tipo)} text-xs`}>
                            {getTipoText(manutencao.tipo)}
                          </Badge>
                        </div>

                        <div className="mb-2">
                          <div className="text-xs font-medium text-slate-700 mb-1">Serviços realizados:</div>
                          <ul className="list-disc list-inside text-xs text-slate-600 space-y-0.5">
                            {manutencao.servicos.map((servico, idx) => (
                              <li key={idx}>{servico}</li>
                            ))}
                          </ul>
                        </div>

                        <div className="flex items-center justify-between pt-2 border-t border-slate-200">
                          <span className="text-xs text-slate-600">Valor total:</span>
                          <span className="font-bold text-green-600">
                            R$ {manutencao.valor.toFixed(2)}
                          </span>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        ))}
      </div>

      {/* Próximas manutenções recomendadas */}
      <Card className="mt-4 bg-amber-50 border-amber-200">
        <CardContent className="p-4">
          <h3 className="font-semibold text-slate-800 text-sm mb-2 flex items-center gap-2">
            <Calendar className="w-4 h-4 text-amber-600" />
            Próximas Manutenções Recomendadas
          </h3>
          <ul className="text-xs text-slate-600 space-y-1">
            <li>• <strong>Gol 2020:</strong> Revisão dos 50.000 km (em ~1.500 km)</li>
            <li>• <strong>Civic 2021:</strong> Troca de óleo (em ~2.700 km)</li>
          </ul>
        </CardContent>
      </Card>
    </div>
  );
}
