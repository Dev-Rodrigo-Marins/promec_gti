import { useState } from "react";
import { useNavigate } from "react-router";
import { Card, CardContent } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Button } from "../components/ui/button";
import { Search, Car, Phone, Calendar, ChevronRight } from "lucide-react";
import { Badge } from "../components/ui/badge";

// Dados mockados para demonstração
const veiculosMock = [
  {
    id: 1,
    placa: "ABC-1234",
    marca: "Volkswagen",
    modelo: "Gol",
    ano: "2020",
    cor: "Prata",
    proprietario: "João Silva",
    telefone: "(11) 98765-4321",
    ultimaVisita: "15/03/2026",
  },
  {
    id: 2,
    placa: "DEF-5678",
    marca: "Fiat",
    modelo: "Uno",
    ano: "2019",
    cor: "Branco",
    proprietario: "Maria Santos",
    telefone: "(11) 91234-5678",
    ultimaVisita: "10/03/2026",
  },
  {
    id: 3,
    placa: "GHI-9012",
    marca: "Chevrolet",
    modelo: "Onix",
    ano: "2022",
    cor: "Preto",
    proprietario: "Pedro Oliveira",
    telefone: "(11) 99876-5432",
    ultimaVisita: "05/03/2026",
  },
  {
    id: 4,
    placa: "JKL-3456",
    marca: "Honda",
    modelo: "Civic",
    ano: "2021",
    cor: "Vermelho",
    proprietario: "Ana Costa",
    telefone: "(11) 97654-3210",
    ultimaVisita: "01/03/2026",
  },
];

export function ProcurarVeiculo() {
  const navigate = useNavigate();
  const [searchTerm, setSearchTerm] = useState("");
  const [filteredVeiculos, setFilteredVeiculos] = useState(veiculosMock);

  const handleSearch = () => {
    const filtered = veiculosMock.filter(
      (veiculo) =>
        veiculo.placa.toLowerCase().includes(searchTerm.toLowerCase()) ||
        veiculo.proprietario.toLowerCase().includes(searchTerm.toLowerCase()) ||
        veiculo.modelo.toLowerCase().includes(searchTerm.toLowerCase())
    );
    setFilteredVeiculos(filtered);
  };

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Procurar Veículo</h2>
        <p className="text-slate-600 text-sm">Busque por placa ou proprietário</p>
      </div>

      {/* Barra de busca */}
      <div className="mb-4 flex gap-2">
        <Input
          placeholder="Placa, proprietário ou modelo..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleSearch()}
          className="flex-1 text-base"
        />
        <Button onClick={handleSearch} className="bg-green-600 hover:bg-green-700 px-4">
          <Search className="w-5 h-5" />
        </Button>
      </div>

      {/* Resultados */}
      <div className="space-y-3">
        {filteredVeiculos.length === 0 ? (
          <Card>
            <CardContent className="py-12 text-center">
              <Car className="w-16 h-16 text-slate-300 mx-auto mb-3" />
              <p className="text-slate-600">Nenhum veículo encontrado</p>
            </CardContent>
          </Card>
        ) : (
          filteredVeiculos.map((veiculo) => (
            <Card 
              key={veiculo.id} 
              className="active:scale-98 transition-transform cursor-pointer"
              onClick={() => navigate(`/historico-veiculo/${veiculo.id}`)}
            >
              <CardContent className="p-4">
                <div className="flex items-start justify-between mb-3">
                  <div className="flex gap-3">
                    <div className="bg-gradient-to-br from-green-500 to-green-600 p-2.5 rounded-lg h-fit">
                      <Car className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-slate-800">
                        {veiculo.marca} {veiculo.modelo}
                      </h3>
                      <div className="flex gap-1.5 mt-1 flex-wrap">
                        <Badge variant="secondary" className="text-xs">{veiculo.placa}</Badge>
                        <Badge variant="outline" className="text-xs">{veiculo.ano}</Badge>
                        <Badge variant="outline" className="text-xs">{veiculo.cor}</Badge>
                      </div>
                    </div>
                  </div>
                  <ChevronRight className="w-5 h-5 text-slate-400" />
                </div>

                <div className="space-y-2 text-sm">
                  <div className="flex items-center justify-between text-slate-700">
                    <span className="font-medium">Proprietário:</span>
                    <span>{veiculo.proprietario}</span>
                  </div>
                  <div className="flex items-center justify-between text-slate-700">
                    <div className="flex items-center gap-1.5">
                      <Phone className="w-3.5 h-3.5" />
                      <span>Telefone:</span>
                    </div>
                    <span>{veiculo.telefone}</span>
                  </div>
                  <div className="flex items-center justify-between text-slate-700">
                    <div className="flex items-center gap-1.5">
                      <Calendar className="w-3.5 h-3.5" />
                      <span>Última visita:</span>
                    </div>
                    <span>{veiculo.ultimaVisita}</span>
                  </div>
                </div>

                <div className="mt-4 pt-3 border-t grid grid-cols-2 gap-2">
                  <Button 
                    variant="outline" 
                    size="sm" 
                    className="text-xs"
                    onClick={(e) => {
                      e.stopPropagation();
                      navigate(`/historico-veiculo/${veiculo.id}`);
                    }}
                  >
                    Ver Histórico
                  </Button>
                  <Button 
                    variant="outline" 
                    size="sm" 
                    className="text-xs"
                    onClick={(e) => {
                      e.stopPropagation();
                      navigate('/montar-orcamento');
                    }}
                  >
                    Novo Orçamento
                  </Button>
                </div>
              </CardContent>
            </Card>
          ))
        )}
      </div>
    </div>
  );
}