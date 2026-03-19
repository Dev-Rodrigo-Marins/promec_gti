import { useState } from "react";
import { Card, CardContent } from "../../components/ui/card";
import { Badge } from "../../components/ui/badge";
import { Button } from "../../components/ui/button";
import { Input } from "../../components/ui/input";
import { MapPin, Search, Phone, Navigation, Clock, Star, Wrench } from "lucide-react";

const oficinas = [
  {
    id: 1,
    nome: "Auto Center Silva",
    endereco: "Av. Paulista, 500 - Bela Vista",
    distancia: "1.2 km",
    avaliacao: 4.8,
    avaliacoes: 234,
    telefone: "(11) 3456-7890",
    horario: "Seg-Sex: 8h-18h, Sáb: 8h-13h",
    especialidades: ["Mecânica Geral", "Elétrica", "Freios"],
    tempoEspera: "Baixo",
    status: "aberto",
  },
  {
    id: 2,
    nome: "Mecânica João Santos",
    endereco: "Rua das Flores, 234 - Consolação",
    distancia: "2.5 km",
    avaliacao: 4.6,
    avaliacoes: 156,
    telefone: "(11) 3789-0123",
    horario: "Seg-Sex: 7h-19h, Sáb: 8h-14h",
    especialidades: ["Suspensão", "Alinhamento", "Balanceamento"],
    tempoEspera: "Médio",
    status: "aberto",
  },
  {
    id: 3,
    nome: "Express Car Service",
    endereco: "Rua Augusta, 789 - Jardins",
    distancia: "3.1 km",
    avaliacao: 4.9,
    avaliacoes: 421,
    telefone: "(11) 3234-5678",
    horario: "Seg-Dom: 24 horas",
    especialidades: ["Troca de Óleo", "Revisão Rápida", "Diagnóstico"],
    tempoEspera: "Muito Baixo",
    status: "aberto",
  },
  {
    id: 4,
    nome: "Oficina do Carmo",
    endereco: "Av. Ipiranga, 1234 - República",
    distancia: "4.3 km",
    avaliacao: 4.5,
    avaliacoes: 89,
    telefone: "(11) 3567-8901",
    horario: "Seg-Sex: 8h-17h",
    especialidades: ["Motor", "Transmissão", "Câmbio"],
    tempoEspera: "Alto",
    status: "fechado",
  },
  {
    id: 5,
    nome: "Multi Service Auto",
    endereco: "Rua da Consolação, 567 - Consolação",
    distancia: "2.8 km",
    avaliacao: 4.7,
    avaliacoes: 312,
    telefone: "(11) 3890-1234",
    horario: "Seg-Sex: 8h-18h, Sáb: 8h-12h",
    especialidades: ["Ar Condicionado", "Vidros", "Lataria"],
    tempoEspera: "Baixo",
    status: "aberto",
  },
];

export function OficinasCredenciadas() {
  const [searchTerm, setSearchTerm] = useState("");
  const [filteredOficinas, setFilteredOficinas] = useState(oficinas);

  const handleSearch = () => {
    const filtered = oficinas.filter(
      (oficina) =>
        oficina.nome.toLowerCase().includes(searchTerm.toLowerCase()) ||
        oficina.endereco.toLowerCase().includes(searchTerm.toLowerCase()) ||
        oficina.especialidades.some(esp => esp.toLowerCase().includes(searchTerm.toLowerCase()))
    );
    setFilteredOficinas(filtered);
  };

  const getTempoEsperaColor = (tempo: string) => {
    switch (tempo) {
      case "Muito Baixo":
        return "bg-green-100 text-green-800 border-green-300";
      case "Baixo":
        return "bg-blue-100 text-blue-800 border-blue-300";
      case "Médio":
        return "bg-yellow-100 text-yellow-800 border-yellow-300";
      case "Alto":
        return "bg-red-100 text-red-800 border-red-300";
      default:
        return "bg-slate-100 text-slate-800 border-slate-300";
    }
  };

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Oficinas Credenciadas</h2>
        <p className="text-slate-600 text-sm">Encontre a mais próxima de você</p>
      </div>

      {/* Localização atual */}
      <Card className="mb-4 bg-blue-50 border-blue-200">
        <CardContent className="p-4">
          <div className="flex items-center gap-2 text-sm">
            <Navigation className="w-4 h-4 text-blue-600" />
            <span className="text-slate-700">Sua localização:</span>
            <span className="font-semibold text-slate-800">Av. Paulista, 1000</span>
          </div>
        </CardContent>
      </Card>

      {/* Busca */}
      <div className="mb-4 flex gap-2">
        <Input
          placeholder="Buscar oficina ou especialidade..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          onKeyDown={(e) => e.key === "Enter" && handleSearch()}
          className="flex-1 text-base"
        />
        <Button onClick={handleSearch} className="bg-purple-600 hover:bg-purple-700 px-4">
          <Search className="w-5 h-5" />
        </Button>
      </div>

      {/* Filtros rápidos */}
      <div className="flex gap-2 mb-4 overflow-x-auto pb-2">
        <Badge variant="outline" className="whitespace-nowrap cursor-pointer hover:bg-slate-100">
          <Star className="w-3 h-3 mr-1" />
          Melhor avaliadas
        </Badge>
        <Badge variant="outline" className="whitespace-nowrap cursor-pointer hover:bg-slate-100">
          <MapPin className="w-3 h-3 mr-1" />
          Mais próximas
        </Badge>
        <Badge variant="outline" className="whitespace-nowrap cursor-pointer hover:bg-slate-100">
          <Clock className="w-3 h-3 mr-1" />
          Abertas agora
        </Badge>
      </div>

      {/* Lista de oficinas */}
      <div className="space-y-3">
        {filteredOficinas.map((oficina) => (
          <Card key={oficina.id} className="active:scale-98 transition-transform">
            <CardContent className="p-4">
              <div className="flex items-start gap-3 mb-3">
                <div className="bg-gradient-to-br from-purple-500 to-purple-600 p-2.5 rounded-lg h-fit">
                  <Wrench className="w-5 h-5 text-white" />
                </div>
                <div className="flex-1">
                  <div className="flex items-start justify-between mb-1">
                    <h3 className="font-semibold text-slate-800">{oficina.nome}</h3>
                    <Badge 
                      className={`text-xs ${
                        oficina.status === "aberto" 
                          ? "bg-green-100 text-green-800 border-green-300" 
                          : "bg-red-100 text-red-800 border-red-300"
                      }`}
                    >
                      {oficina.status === "aberto" ? "Aberto" : "Fechado"}
                    </Badge>
                  </div>
                  
                  <div className="flex items-center gap-1 mb-2">
                    <Star className="w-4 h-4 text-yellow-500 fill-yellow-500" />
                    <span className="font-semibold text-sm">{oficina.avaliacao}</span>
                    <span className="text-xs text-slate-600">({oficina.avaliacoes} avaliações)</span>
                  </div>

                  <div className="space-y-1 text-xs text-slate-600 mb-2">
                    <div className="flex items-center gap-1.5">
                      <MapPin className="w-3.5 h-3.5" />
                      <span>{oficina.endereco}</span>
                    </div>
                    <div className="flex items-center gap-1.5">
                      <Navigation className="w-3.5 h-3.5" />
                      <span className="font-semibold text-purple-600">{oficina.distancia} de você</span>
                    </div>
                    <div className="flex items-center gap-1.5">
                      <Clock className="w-3.5 h-3.5" />
                      <span>{oficina.horario}</span>
                    </div>
                  </div>

                  <div className="mb-2">
                    <div className="text-xs font-medium text-slate-700 mb-1">Especialidades:</div>
                    <div className="flex flex-wrap gap-1">
                      {oficina.especialidades.map((esp, idx) => (
                        <Badge key={idx} variant="outline" className="text-xs">
                          {esp}
                        </Badge>
                      ))}
                    </div>
                  </div>

                  <div className="flex items-center gap-2 mb-3">
                    <span className="text-xs text-slate-600">Tempo de espera:</span>
                    <Badge className={`${getTempoEsperaColor(oficina.tempoEspera)} text-xs`}>
                      {oficina.tempoEspera}
                    </Badge>
                  </div>

                  <div className="grid grid-cols-2 gap-2">
                    <Button 
                      variant="default" 
                      size="sm" 
                      className="bg-purple-600 hover:bg-purple-700 text-xs"
                    >
                      <Navigation className="w-3 h-3 mr-1" />
                      Ir até lá
                    </Button>
                    <Button variant="outline" size="sm" className="text-xs">
                      <Phone className="w-3 h-3 mr-1" />
                      Ligar
                    </Button>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {filteredOficinas.length === 0 && (
        <Card>
          <CardContent className="py-12 text-center">
            <MapPin className="w-16 h-16 text-slate-300 mx-auto mb-3" />
            <p className="text-slate-600">Nenhuma oficina encontrada</p>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
