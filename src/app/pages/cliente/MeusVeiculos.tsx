import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card";
import { Input } from "../../components/ui/input";
import { Label } from "../../components/ui/label";
import { Button } from "../../components/ui/button";
import { Badge } from "../../components/ui/badge";
import { 
  Car, 
  Edit, 
  Save, 
  X, 
  AlertTriangle, 
  CheckCircle,
  TrendingUp,
  Calendar,
  Wrench
} from "lucide-react";
import { toast } from "sonner";

interface Veiculo {
  id: number;
  placa: string;
  marca: string;
  modelo: string;
  ano: string;
  cor: string;
  kmAtual: number;
  ultimaRevisao: number;
  proximaRevisao: number;
  ultimaManutencao: string;
  historicoKm: Array<{
    data: string;
    km: number;
  }>;
}

const veiculosMock: Veiculo[] = [
  {
    id: 1,
    placa: "ABC-1234",
    marca: "Volkswagen",
    modelo: "Gol",
    ano: "2020",
    cor: "Prata",
    kmAtual: 48500,
    ultimaRevisao: 45000,
    proximaRevisao: 50000,
    ultimaManutencao: "05/03/2026",
    historicoKm: [
      { data: "05/03/2026", km: 48200 },
      { data: "15/01/2026", km: 45000 },
      { data: "20/09/2025", km: 40000 },
    ],
  },
  {
    id: 2,
    placa: "DEF-5678",
    marca: "Honda",
    modelo: "Civic",
    ano: "2021",
    cor: "Preto",
    kmAtual: 22300,
    ultimaRevisao: 20000,
    proximaRevisao: 25000,
    ultimaManutencao: "10/03/2026",
    historicoKm: [
      { data: "10/03/2026", km: 22100 },
      { data: "10/12/2025", km: 20000 },
      { data: "15/08/2025", km: 15000 },
    ],
  },
];

const calcularStatusManutencao = (veiculo: Veiculo) => {
  const kmParaRevisao = veiculo.proximaRevisao - veiculo.kmAtual;
  const percentual = ((veiculo.kmAtual - veiculo.ultimaRevisao) / (veiculo.proximaRevisao - veiculo.ultimaRevisao)) * 100;

  if (kmParaRevisao <= 0) {
    return { status: "urgente", mensagem: "Revisão atrasada!", cor: "bg-red-100 text-red-800 border-red-300" };
  } else if (kmParaRevisao <= 500) {
    return { status: "atencao", mensagem: `Faltam ${kmParaRevisao} km`, cor: "bg-yellow-100 text-yellow-800 border-yellow-300" };
  } else if (kmParaRevisao <= 2000) {
    return { status: "proximo", mensagem: `Faltam ${kmParaRevisao} km`, cor: "bg-blue-100 text-blue-800 border-blue-300" };
  } else {
    return { status: "ok", mensagem: `Faltam ${kmParaRevisao} km`, cor: "bg-green-100 text-green-800 border-green-300" };
  }
};

export function MeusVeiculos() {
  const [veiculos, setVeiculos] = useState<Veiculo[]>(veiculosMock);
  const [editandoId, setEditandoId] = useState<number | null>(null);
  const [novaKm, setNovaKm] = useState<string>("");

  const iniciarEdicao = (veiculo: Veiculo) => {
    setEditandoId(veiculo.id);
    setNovaKm(veiculo.kmAtual.toString());
  };

  const cancelarEdicao = () => {
    setEditandoId(null);
    setNovaKm("");
  };

  const salvarKm = (veiculoId: number) => {
    const kmNumerica = parseInt(novaKm);
    const veiculo = veiculos.find(v => v.id === veiculoId);

    if (!veiculo) return;

    if (isNaN(kmNumerica) || kmNumerica <= 0) {
      toast.error("Quilometragem inválida");
      return;
    }

    if (kmNumerica < veiculo.kmAtual) {
      toast.error("A nova quilometragem não pode ser menor que a atual");
      return;
    }

    // Atualizar veículo
    setVeiculos(veiculos.map(v => {
      if (v.id === veiculoId) {
        const novoHistorico = [
          { data: new Date().toLocaleDateString('pt-BR'), km: kmNumerica },
          ...v.historicoKm.slice(0, 4) // Mantém apenas os últimos 5 registros
        ];
        return {
          ...v,
          kmAtual: kmNumerica,
          historicoKm: novoHistorico
        };
      }
      return v;
    }));

    const status = calcularStatusManutencao({ ...veiculo, kmAtual: kmNumerica });
    
    if (status.status === "urgente") {
      toast.error("⚠️ Seu veículo está com revisão atrasada!");
    } else if (status.status === "atencao") {
      toast.warning("⚠️ Seu veículo está próximo da revisão!");
    } else {
      toast.success("Quilometragem atualizada com sucesso!");
    }

    cancelarEdicao();
  };

  const getIconeStatus = (status: string) => {
    switch (status) {
      case "urgente":
        return <AlertTriangle className="w-5 h-5 text-red-600" />;
      case "atencao":
        return <AlertTriangle className="w-5 h-5 text-yellow-600" />;
      case "proximo":
        return <Calendar className="w-5 h-5 text-blue-600" />;
      default:
        return <CheckCircle className="w-5 h-5 text-green-600" />;
    }
  };

  const calcularMediaKmMes = (veiculo: Veiculo) => {
    if (veiculo.historicoKm.length < 2) return null;
    
    const maisRecente = veiculo.historicoKm[0];
    const maisAntigo = veiculo.historicoKm[veiculo.historicoKm.length - 1];
    
    const diffKm = maisRecente.km - maisAntigo.km;
    const diffDias = Math.ceil(
      (new Date(maisRecente.data.split('/').reverse().join('-')).getTime() - 
       new Date(maisAntigo.data.split('/').reverse().join('-')).getTime()) / 
      (1000 * 60 * 60 * 24)
    );
    
    const mediaMes = (diffKm / diffDias) * 30;
    return Math.round(mediaMes);
  };

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Meus Veículos</h2>
        <p className="text-slate-600 text-sm">Atualize a quilometragem e veja alertas</p>
      </div>

      {/* Resumo Geral */}
      <div className="grid grid-cols-2 gap-3 mb-4">
        <Card className="bg-blue-50 border-blue-200">
          <CardContent className="p-3 text-center">
            <Car className="w-5 h-5 text-blue-600 mx-auto mb-1" />
            <div className="text-xl font-bold text-blue-600">{veiculos.length}</div>
            <div className="text-xs text-slate-600">Veículos</div>
          </CardContent>
        </Card>
        <Card className="bg-amber-50 border-amber-200">
          <CardContent className="p-3 text-center">
            <AlertTriangle className="w-5 h-5 text-amber-600 mx-auto mb-1" />
            <div className="text-xl font-bold text-amber-600">
              {veiculos.filter(v => {
                const status = calcularStatusManutencao(v);
                return status.status === "urgente" || status.status === "atencao";
              }).length}
            </div>
            <div className="text-xs text-slate-600">Alertas</div>
          </CardContent>
        </Card>
      </div>

      {/* Lista de Veículos */}
      <div className="space-y-4">
        {veiculos.map((veiculo) => {
          const status = calcularStatusManutencao(veiculo);
          const mediaKmMes = calcularMediaKmMes(veiculo);
          const estaEditando = editandoId === veiculo.id;

          return (
            <Card key={veiculo.id} className="overflow-hidden">
              <CardHeader className="pb-3 bg-gradient-to-r from-slate-50 to-slate-100">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-blue-500 to-blue-600 p-2.5 rounded-lg">
                      <Car className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <CardTitle className="text-base">
                        {veiculo.marca} {veiculo.modelo}
                      </CardTitle>
                      <div className="flex gap-1.5 mt-1">
                        <Badge variant="secondary" className="text-xs">{veiculo.placa}</Badge>
                        <Badge variant="outline" className="text-xs">{veiculo.ano}</Badge>
                      </div>
                    </div>
                  </div>
                  {getIconeStatus(status.status)}
                </div>
              </CardHeader>

              <CardContent className="pt-4">
                {/* Status da Manutenção */}
                <div className={`rounded-lg p-3 mb-4 border ${status.cor}`}>
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-semibold text-sm">Status da Manutenção</span>
                    <Badge className={status.cor}>{status.mensagem}</Badge>
                  </div>
                  <div className="text-xs text-slate-600">
                    Próxima revisão: <strong>{veiculo.proximaRevisao.toLocaleString('pt-BR')} km</strong>
                  </div>
                </div>

                {/* Quilometragem Atual */}
                <div className="space-y-3 mb-4">
                  {estaEditando ? (
                    <div className="space-y-2">
                      <Label htmlFor={`km-${veiculo.id}`} className="text-sm">
                        Nova Quilometragem
                      </Label>
                      <div className="flex gap-2">
                        <Input
                          id={`km-${veiculo.id}`}
                          type="number"
                          value={novaKm}
                          onChange={(e) => setNovaKm(e.target.value)}
                          placeholder="Digite a KM atual"
                          className="flex-1 text-base"
                          autoFocus
                        />
                        <Button 
                          size="sm" 
                          className="bg-green-600 hover:bg-green-700"
                          onClick={() => salvarKm(veiculo.id)}
                        >
                          <Save className="w-4 h-4" />
                        </Button>
                        <Button 
                          size="sm" 
                          variant="outline"
                          onClick={cancelarEdicao}
                        >
                          <X className="w-4 h-4" />
                        </Button>
                      </div>
                    </div>
                  ) : (
                    <div className="flex items-center justify-between bg-slate-50 rounded-lg p-3">
                      <div>
                        <div className="text-xs text-slate-600 mb-1">Quilometragem Atual</div>
                        <div className="text-2xl font-bold text-slate-800">
                          {veiculo.kmAtual.toLocaleString('pt-BR')} km
                        </div>
                        <div className="text-xs text-slate-600 mt-1">
                          Atualizado em {veiculo.historicoKm[0]?.data}
                        </div>
                      </div>
                      <Button 
                        size="sm" 
                        variant="outline"
                        onClick={() => iniciarEdicao(veiculo)}
                      >
                        <Edit className="w-4 h-4 mr-2" />
                        Atualizar
                      </Button>
                    </div>
                  )}
                </div>

                {/* Estatísticas */}
                <div className="grid grid-cols-2 gap-3 mb-4">
                  <div className="bg-blue-50 rounded-lg p-3 text-center">
                    <TrendingUp className="w-4 h-4 text-blue-600 mx-auto mb-1" />
                    <div className="text-xs text-slate-600 mb-1">Desde última revisão</div>
                    <div className="font-bold text-blue-600">
                      {(veiculo.kmAtual - veiculo.ultimaRevisao).toLocaleString('pt-BR')} km
                    </div>
                  </div>
                  {mediaKmMes && (
                    <div className="bg-purple-50 rounded-lg p-3 text-center">
                      <Calendar className="w-4 h-4 text-purple-600 mx-auto mb-1" />
                      <div className="text-xs text-slate-600 mb-1">Média mensal</div>
                      <div className="font-bold text-purple-600">
                        ~{mediaKmMes.toLocaleString('pt-BR')} km
                      </div>
                    </div>
                  )}
                </div>

                {/* Recomendações */}
                {(status.status === "urgente" || status.status === "atencao") && (
                  <div className="bg-amber-50 border border-amber-200 rounded-lg p-3 mb-3">
                    <div className="flex items-start gap-2">
                      <Wrench className="w-4 h-4 text-amber-600 mt-0.5" />
                      <div>
                        <div className="font-semibold text-sm text-slate-800 mb-1">
                          Ação Recomendada
                        </div>
                        <p className="text-xs text-slate-600 mb-2">
                          {status.status === "urgente" 
                            ? "Sua revisão está atrasada. Agende o quanto antes para evitar problemas."
                            : "Está chegando a hora da revisão. Agende com antecedência."}
                        </p>
                        <Button size="sm" className="bg-amber-600 hover:bg-amber-700 text-xs w-full">
                          Solicitar Orçamento
                        </Button>
                      </div>
                    </div>
                  </div>
                )}

                {/* Histórico de KM */}
                <div>
                  <h4 className="font-semibold text-sm text-slate-800 mb-2">
                    Histórico Recente
                  </h4>
                  <div className="space-y-1">
                    {veiculo.historicoKm.slice(0, 3).map((registro, idx) => (
                      <div 
                        key={idx}
                        className="flex justify-between text-xs text-slate-600 bg-slate-50 rounded p-2"
                      >
                        <span>{registro.data}</span>
                        <span className="font-semibold">
                          {registro.km.toLocaleString('pt-BR')} km
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              </CardContent>
            </Card>
          );
        })}
      </div>

      {/* Dica */}
      <Card className="mt-4 bg-blue-50 border-blue-200">
        <CardContent className="p-4">
          <h3 className="font-semibold text-slate-800 text-sm mb-2 flex items-center gap-2">
            💡 Dica ProMec
          </h3>
          <p className="text-xs text-slate-600">
            Mantenha sua quilometragem sempre atualizada para receber alertas precisos 
            sobre manutenções preventivas. Isso ajuda a evitar problemas e economizar!
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
