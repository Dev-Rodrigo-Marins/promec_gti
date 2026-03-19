import { useState } from "react";
import { Card, CardContent } from "../components/ui/card";
import { Badge } from "../components/ui/badge";
import { Button } from "../components/ui/button";
import { Input } from "../components/ui/input";
import { FileText, Search, Car, Calendar, Plus, Check, X, Eye } from "lucide-react";

// Dados mockados para demonstração
const orcamentosMock = [
  {
    id: 1,
    numero: "ORC-001",
    data: "15/03/2026",
    veiculo: "ABC-1234 - VW Gol",
    proprietario: "João Silva",
    servicos: ["Revisão Completa", "Troca de Óleo"],
    valor: 850.0,
    status: "aprovado",
  },
  {
    id: 2,
    numero: "ORC-002",
    data: "14/03/2026",
    veiculo: "DEF-5678 - Fiat Uno",
    proprietario: "Maria Santos",
    servicos: ["Troca de Óleo", "Filtro de Ar"],
    valor: 320.0,
    status: "pendente",
  },
  {
    id: 3,
    numero: "ORC-003",
    data: "13/03/2026",
    veiculo: "GHI-9012 - Chevrolet Onix",
    proprietario: "Pedro Oliveira",
    servicos: ["Alinhamento", "Balanceamento"],
    valor: 280.0,
    status: "aprovado",
  },
  {
    id: 4,
    numero: "ORC-004",
    data: "12/03/2026",
    veiculo: "JKL-3456 - Honda Civic",
    proprietario: "Ana Costa",
    servicos: ["Pastilhas de Freio", "Discos"],
    valor: 1200.0,
    status: "recusado",
  },
  {
    id: 5,
    numero: "ORC-005",
    data: "11/03/2026",
    veiculo: "MNO-7890 - Toyota Corolla",
    proprietario: "Carlos Lima",
    servicos: ["Revisão 10.000 km"],
    valor: 680.0,
    status: "pendente",
  },
];

export function Orcamentos() {
  const [searchTerm, setSearchTerm] = useState("");
  const [filteredOrcamentos, setFilteredOrcamentos] = useState(orcamentosMock);

  const handleSearch = () => {
    const filtered = orcamentosMock.filter(
      (orcamento) =>
        orcamento.numero.toLowerCase().includes(searchTerm.toLowerCase()) ||
        orcamento.proprietario.toLowerCase().includes(searchTerm.toLowerCase()) ||
        orcamento.veiculo.toLowerCase().includes(searchTerm.toLowerCase())
    );
    setFilteredOrcamentos(filtered);
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case "aprovado":
        return "bg-green-100 text-green-800 border-green-300";
      case "pendente":
        return "bg-yellow-100 text-yellow-800 border-yellow-300";
      case "recusado":
        return "bg-red-100 text-red-800 border-red-300";
      default:
        return "bg-slate-100 text-slate-800 border-slate-300";
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case "aprovado":
        return "Aprovado";
      case "pendente":
        return "Pendente";
      case "recusado":
        return "Recusado";
      default:
        return status;
    }
  };

  const totalAprovados = filteredOrcamentos.filter((o) => o.status === "aprovado").length;
  const totalPendentes = filteredOrcamentos.filter((o) => o.status === "pendente").length;
  const valorTotal = filteredOrcamentos
    .filter((o) => o.status === "aprovado")
    .reduce((acc, o) => acc + o.valor, 0);

  return (
    <div className="p-4">
      <div className="flex items-center justify-between mb-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-800">Orçamentos</h2>
          <p className="text-slate-600 text-sm">Gerencie os orçamentos</p>
        </div>
        <Button size="sm" className="bg-orange-600 hover:bg-orange-700">
          <Plus className="w-4 h-4" />
        </Button>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-3 gap-2 mb-4">
        <Card className="bg-green-50 border-green-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-green-600">{totalAprovados}</div>
            <div className="text-xs text-slate-600">Aprovados</div>
          </CardContent>
        </Card>
        <Card className="bg-yellow-50 border-yellow-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-yellow-600">{totalPendentes}</div>
            <div className="text-xs text-slate-600">Pendentes</div>
          </CardContent>
        </Card>
        <Card className="bg-blue-50 border-blue-200">
          <CardContent className="p-3 text-center">
            <div className="text-sm font-bold text-blue-600">
              R$ {(valorTotal / 1000).toFixed(1)}k
            </div>
            <div className="text-xs text-slate-600">Total</div>
          </CardContent>
        </Card>
      </div>

      {/* Barra de busca */}
      <div className="mb-4 flex gap-2">
        <Input
          placeholder="Buscar orçamento..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleSearch()}
          className="flex-1 text-base"
        />
        <Button onClick={handleSearch} className="bg-orange-600 hover:bg-orange-700 px-4">
          <Search className="w-5 h-5" />
        </Button>
      </div>

      {/* Lista de orçamentos */}
      <div className="space-y-3">
        {filteredOrcamentos.length === 0 ? (
          <Card>
            <CardContent className="py-12 text-center">
              <FileText className="w-16 h-16 text-slate-300 mx-auto mb-3" />
              <p className="text-slate-600">Nenhum orçamento encontrado</p>
            </CardContent>
          </Card>
        ) : (
          filteredOrcamentos.map((orcamento) => (
            <Card key={orcamento.id} className="active:scale-98 transition-transform">
              <CardContent className="p-4">
                <div className="flex items-start justify-between mb-3">
                  <div className="flex gap-3">
                    <div className="bg-gradient-to-br from-orange-500 to-orange-600 p-2.5 rounded-lg h-fit">
                      <FileText className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <div className="flex items-center gap-2 mb-1">
                        <h3 className="font-semibold text-slate-800">{orcamento.numero}</h3>
                        <Badge className={`${getStatusColor(orcamento.status)} text-xs`}>
                          {getStatusText(orcamento.status)}
                        </Badge>
                      </div>
                      <div className="flex items-center gap-1.5 text-xs text-slate-600">
                        <Calendar className="w-3 h-3" />
                        <span>{orcamento.data}</span>
                      </div>
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-lg font-bold text-green-600">
                      R$ {orcamento.valor.toFixed(2)}
                    </div>
                  </div>
                </div>

                <div className="space-y-2 text-sm mb-3">
                  <div className="flex items-center gap-1.5 text-slate-700">
                    <Car className="w-3.5 h-3.5" />
                    <span className="font-medium">Veículo:</span>
                    <span className="text-xs">{orcamento.veiculo}</span>
                  </div>
                  <div className="text-slate-700">
                    <span className="font-medium">Cliente:</span> {orcamento.proprietario}
                  </div>
                  <div>
                    <div className="font-medium text-slate-700 mb-1">Serviços:</div>
                    <div className="flex flex-wrap gap-1">
                      {orcamento.servicos.map((servico, index) => (
                        <Badge key={index} variant="outline" className="text-xs">
                          {servico}
                        </Badge>
                      ))}
                    </div>
                  </div>
                </div>

                <div className="pt-3 border-t flex gap-2">
                  <Button variant="outline" size="sm" className="flex-1 text-xs">
                    <Eye className="w-3 h-3 mr-1" />
                    Ver
                  </Button>
                  {orcamento.status === "pendente" && (
                    <>
                      <Button 
                        variant="default" 
                        size="sm" 
                        className="flex-1 bg-green-600 hover:bg-green-700 text-xs"
                      >
                        <Check className="w-3 h-3 mr-1" />
                        Aprovar
                      </Button>
                      <Button variant="destructive" size="sm" className="text-xs">
                        <X className="w-3 h-3" />
                      </Button>
                    </>
                  )}
                  {orcamento.status === "aprovado" && (
                    <Button 
                      variant="default" 
                      size="sm" 
                      className="flex-1 bg-orange-600 hover:bg-orange-700 text-xs"
                    >
                      Iniciar Serviço
                    </Button>
                  )}
                </div>
              </CardContent>
            </Card>
          ))
        )}
      </div>
    </div>
  );
}