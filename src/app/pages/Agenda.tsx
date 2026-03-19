import { useState } from "react";
import { Card, CardContent } from "../components/ui/card";
import { Badge } from "../components/ui/badge";
import { Button } from "../components/ui/button";
import { Clock, Car, User, Plus, Check, X } from "lucide-react";

// Dados mockados para demonstração
const agendamentosMock = [
  {
    id: 1,
    data: "16/03/2026",
    hora: "09:00",
    veiculo: "ABC-1234 - VW Gol",
    proprietario: "João Silva",
    servico: "Revisão Completa",
    status: "confirmado",
  },
  {
    id: 2,
    data: "16/03/2026",
    hora: "11:00",
    veiculo: "DEF-5678 - Fiat Uno",
    proprietario: "Maria Santos",
    servico: "Troca de Óleo",
    status: "confirmado",
  },
  {
    id: 3,
    data: "16/03/2026",
    hora: "14:00",
    veiculo: "GHI-9012 - Chevrolet Onix",
    proprietario: "Pedro Oliveira",
    servico: "Alinhamento",
    status: "pendente",
  },
  {
    id: 4,
    data: "17/03/2026",
    hora: "10:00",
    veiculo: "JKL-3456 - Honda Civic",
    proprietario: "Ana Costa",
    servico: "Freios",
    status: "confirmado",
  },
  {
    id: 5,
    data: "17/03/2026",
    hora: "15:00",
    veiculo: "MNO-7890 - Toyota Corolla",
    proprietario: "Carlos Lima",
    servico: "Revisão 10.000 km",
    status: "pendente",
  },
];

export function Agenda() {
  const [selectedDate, setSelectedDate] = useState("16/03/2026");

  const agendamentosDia = agendamentosMock.filter(
    (agendamento) => agendamento.data === selectedDate
  );

  const getStatusColor = (status: string) => {
    switch (status) {
      case "confirmado":
        return "bg-green-100 text-green-800 border-green-300";
      case "pendente":
        return "bg-yellow-100 text-yellow-800 border-yellow-300";
      case "concluido":
        return "bg-blue-100 text-blue-800 border-blue-300";
      default:
        return "bg-slate-100 text-slate-800 border-slate-300";
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case "confirmado":
        return "Confirmado";
      case "pendente":
        return "Pendente";
      case "concluido":
        return "Concluído";
      default:
        return status;
    }
  };

  return (
    <div className="p-4">
      <div className="flex items-center justify-between mb-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-800">Agenda</h2>
          <p className="text-slate-600 text-sm">Agendamentos da oficina</p>
        </div>
        <Button size="sm" className="bg-purple-600 hover:bg-purple-700">
          <Plus className="w-4 h-4" />
        </Button>
      </div>

      {/* Stats rápidos */}
      <div className="grid grid-cols-3 gap-2 mb-4">
        <Card className="bg-purple-50 border-purple-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-purple-600">8</div>
            <div className="text-xs text-slate-600">Hoje</div>
          </CardContent>
        </Card>
        <Card className="bg-green-50 border-green-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-green-600">12</div>
            <div className="text-xs text-slate-600">Semana</div>
          </CardContent>
        </Card>
        <Card className="bg-yellow-50 border-yellow-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-yellow-600">3</div>
            <div className="text-xs text-slate-600">Pendentes</div>
          </CardContent>
        </Card>
      </div>

      {/* Seletor de data */}
      <div className="mb-4 flex gap-2 overflow-x-auto pb-2 -mx-4 px-4">
        {["16/03/2026", "17/03/2026", "18/03/2026", "19/03/2026", "20/03/2026"].map((date) => (
          <Button
            key={date}
            size="sm"
            variant={selectedDate === date ? "default" : "outline"}
            onClick={() => setSelectedDate(date)}
            className={`whitespace-nowrap text-xs ${
              selectedDate === date ? "bg-purple-600 hover:bg-purple-700" : ""
            }`}
          >
            {date.substring(0, 5)}
          </Button>
        ))}
      </div>

      {/* Lista de agendamentos */}
      <div className="space-y-3">
        {agendamentosDia.length === 0 ? (
          <Card>
            <CardContent className="py-12 text-center">
              <Clock className="w-16 h-16 text-slate-300 mx-auto mb-3" />
              <p className="text-slate-600">Nenhum agendamento</p>
            </CardContent>
          </Card>
        ) : (
          agendamentosDia.map((agendamento) => (
            <Card key={agendamento.id} className="active:scale-98 transition-transform">
              <CardContent className="p-4">
                <div className="flex gap-3 mb-3">
                  <div className="bg-gradient-to-br from-purple-500 to-purple-600 p-3 rounded-lg h-fit flex flex-col items-center justify-center min-w-[60px]">
                    <Clock className="w-5 h-5 text-white mb-1" />
                    <div className="text-white font-semibold text-xs">{agendamento.hora}</div>
                  </div>
                  <div className="flex-1">
                    <div className="flex items-start justify-between mb-2">
                      <h4 className="font-semibold text-slate-800 text-sm">
                        {agendamento.servico}
                      </h4>
                      <Badge className={`${getStatusColor(agendamento.status)} text-xs`}>
                        {getStatusText(agendamento.status)}
                      </Badge>
                    </div>
                    <div className="space-y-1 text-xs text-slate-600">
                      <div className="flex items-center gap-1.5">
                        <Car className="w-3.5 h-3.5" />
                        <span>{agendamento.veiculo}</span>
                      </div>
                      <div className="flex items-center gap-1.5">
                        <User className="w-3.5 h-3.5" />
                        <span>{agendamento.proprietario}</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="flex gap-2">
                  {agendamento.status === "pendente" && (
                    <>
                      <Button variant="outline" size="sm" className="flex-1 text-xs">
                        <X className="w-3 h-3 mr-1" />
                        Cancelar
                      </Button>
                      <Button 
                        variant="default" 
                        size="sm" 
                        className="flex-1 bg-green-600 hover:bg-green-700 text-xs"
                      >
                        <Check className="w-3 h-3 mr-1" />
                        Confirmar
                      </Button>
                    </>
                  )}
                  {agendamento.status === "confirmado" && (
                    <Button 
                      variant="default" 
                      size="sm" 
                      className="w-full bg-purple-600 hover:bg-purple-700 text-xs"
                    >
                      <Check className="w-3 h-3 mr-1" />
                      Concluir
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