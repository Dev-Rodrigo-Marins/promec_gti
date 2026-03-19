import { useState } from "react";
import { Card, CardContent } from "../../components/ui/card";
import { Badge } from "../../components/ui/badge";
import { Button } from "../../components/ui/button";
import { FileText, Calendar, Car, DollarSign, Download, MessageCircle } from "lucide-react";

const orcamentosCliente = [
  {
    id: 1,
    numero: "ORC-156",
    data: "14/03/2026",
    veiculo: "ABC-1234 - Volkswagen Gol 2020",
    oficina: "Auto Center Silva",
    servicos: ["Revisão Completa", "Troca de Óleo", "Filtros"],
    valor: 850.0,
    status: "pendente",
    validade: "21/03/2026",
  },
  {
    id: 2,
    numero: "ORC-148",
    data: "10/03/2026",
    veiculo: "DEF-5678 - Honda Civic 2021",
    oficina: "Mecânica João Santos",
    servicos: ["Alinhamento", "Balanceamento", "Calibragem"],
    valor: 280.0,
    status: "aprovado",
    validade: "17/03/2026",
  },
  {
    id: 3,
    numero: "ORC-142",
    data: "05/03/2026",
    veiculo: "ABC-1234 - Volkswagen Gol 2020",
    oficina: "Auto Center Silva",
    servicos: ["Troca de Pastilhas de Freio"],
    valor: 450.0,
    status: "concluido",
    validade: "12/03/2026",
  },
];

export function OrcamentosCliente() {
  const [filter, setFilter] = useState("todos");

  const getStatusColor = (status: string) => {
    switch (status) {
      case "pendente":
        return "bg-yellow-100 text-yellow-800 border-yellow-300";
      case "aprovado":
        return "bg-green-100 text-green-800 border-green-300";
      case "concluido":
        return "bg-blue-100 text-blue-800 border-blue-300";
      case "recusado":
        return "bg-red-100 text-red-800 border-red-300";
      default:
        return "bg-slate-100 text-slate-800 border-slate-300";
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case "pendente":
        return "Aguardando";
      case "aprovado":
        return "Aprovado";
      case "concluido":
        return "Concluído";
      case "recusado":
        return "Recusado";
      default:
        return status;
    }
  };

  const filteredOrcamentos = orcamentosCliente.filter(orc => {
    if (filter === "todos") return true;
    return orc.status === filter;
  });

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Meus Orçamentos</h2>
        <p className="text-slate-600 text-sm">Acompanhe seus orçamentos</p>
      </div>

      {/* Filtros */}
      <div className="flex gap-2 mb-4 overflow-x-auto pb-2">
        <Button
          size="sm"
          variant={filter === "todos" ? "default" : "outline"}
          onClick={() => setFilter("todos")}
          className={filter === "todos" ? "bg-blue-600 hover:bg-blue-700" : ""}
        >
          Todos
        </Button>
        <Button
          size="sm"
          variant={filter === "pendente" ? "default" : "outline"}
          onClick={() => setFilter("pendente")}
          className={filter === "pendente" ? "bg-yellow-600 hover:bg-yellow-700" : ""}
        >
          Pendentes
        </Button>
        <Button
          size="sm"
          variant={filter === "aprovado" ? "default" : "outline"}
          onClick={() => setFilter("aprovado")}
          className={filter === "aprovado" ? "bg-green-600 hover:bg-green-700" : ""}
        >
          Aprovados
        </Button>
        <Button
          size="sm"
          variant={filter === "concluido" ? "default" : "outline"}
          onClick={() => setFilter("concluido")}
          className={filter === "concluido" ? "bg-blue-600 hover:bg-blue-700" : ""}
        >
          Concluídos
        </Button>
      </div>

      {/* Lista de orçamentos */}
      <div className="space-y-3">
        {filteredOrcamentos.map((orcamento) => (
          <Card key={orcamento.id} className="active:scale-98 transition-transform">
            <CardContent className="p-4">
              <div className="flex items-start justify-between mb-3">
                <div className="flex gap-3">
                  <div className="bg-gradient-to-br from-blue-500 to-blue-600 p-2.5 rounded-lg h-fit">
                    <FileText className="w-5 h-5 text-white" />
                  </div>
                  <div>
                    <div className="flex items-center gap-2 mb-1">
                      <h3 className="font-semibold text-slate-800">{orcamento.numero}</h3>
                      <Badge className={`${getStatusColor(orcamento.status)} text-xs`}>
                        {getStatusText(orcamento.status)}
                      </Badge>
                    </div>
                    <div className="text-xs text-slate-600 space-y-1">
                      <div className="flex items-center gap-1.5">
                        <Calendar className="w-3 h-3" />
                        <span>Emitido em {orcamento.data}</span>
                      </div>
                      <div className="text-slate-700 font-medium">
                        {orcamento.oficina}
                      </div>
                    </div>
                  </div>
                </div>
                <div className="text-right">
                  <div className="text-xl font-bold text-green-600">
                    R$ {orcamento.valor.toFixed(2)}
                  </div>
                </div>
              </div>

              <div className="space-y-2 text-sm mb-3">
                <div className="flex items-center gap-1.5 text-slate-700">
                  <Car className="w-3.5 h-3.5" />
                  <span className="text-xs">{orcamento.veiculo}</span>
                </div>
                
                <div>
                  <div className="font-medium text-slate-700 mb-1 text-xs">Serviços:</div>
                  <div className="flex flex-wrap gap-1">
                    {orcamento.servicos.map((servico, index) => (
                      <Badge key={index} variant="outline" className="text-xs">
                        {servico}
                      </Badge>
                    ))}
                  </div>
                </div>

                {orcamento.status === "pendente" && (
                  <div className="text-xs text-amber-700 bg-amber-50 p-2 rounded">
                    ⏰ Válido até {orcamento.validade}
                  </div>
                )}
              </div>

              <div className="pt-3 border-t flex gap-2">
                {orcamento.status === "pendente" && (
                  <>
                    <Button 
                      variant="default" 
                      size="sm" 
                      className="flex-1 bg-green-600 hover:bg-green-700 text-xs"
                    >
                      Aprovar
                    </Button>
                    <Button variant="outline" size="sm" className="flex-1 text-xs">
                      Recusar
                    </Button>
                  </>
                )}
                {orcamento.status === "aprovado" && (
                  <Button 
                    variant="default" 
                    size="sm" 
                    className="flex-1 bg-blue-600 hover:bg-blue-700 text-xs"
                  >
                    <MessageCircle className="w-3 h-3 mr-1" />
                    Contatar Oficina
                  </Button>
                )}
                <Button variant="outline" size="sm" className="text-xs">
                  <Download className="w-3 h-3 mr-1" />
                  PDF
                </Button>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
}
