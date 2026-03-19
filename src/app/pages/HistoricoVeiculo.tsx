import { useState } from "react";
import { useNavigate } from "react-router";
import { Card, CardContent, CardHeader, CardTitle } from "../components/ui/card";
import { Badge } from "../components/ui/badge";
import { Button } from "../components/ui/button";
import { 
  Car, 
  ArrowLeft, 
  Calendar, 
  Wrench, 
  DollarSign, 
  Clock,
  FileText,
  TrendingUp,
  AlertCircle,
  CheckCircle,
  Phone,
  Mail,
  MapPin
} from "lucide-react";

// Dados mockados do veículo
const veiculoDetalhes = {
  id: 1,
  placa: "ABC-1234",
  marca: "Volkswagen",
  modelo: "Gol",
  ano: "2020",
  cor: "Prata",
  chassi: "9BWAA05U7ET123456",
  renavam: "12345678901",
  kmAtual: "48.500 km",
  proprietario: {
    nome: "João Silva",
    telefone: "(11) 98765-4321",
    email: "joao.silva@email.com",
    endereco: "Av. Paulista, 1000 - São Paulo, SP",
  },
  ultimaVisita: "05/03/2026",
  proximaRevisao: "50.000 km",
};

const historicoManutencoes = [
  {
    id: 1,
    data: "05/03/2026",
    km: "48.200 km",
    tipo: "Corretiva",
    status: "Concluído",
    oficina: "Auto Center Silva",
    servicos: [
      { nome: "Troca de Pastilhas de Freio", valor: 280.0 },
      { nome: "Troca de Discos de Freio", valor: 170.0 },
    ],
    pecas: [
      { nome: "Pastilhas de Freio Dianteiras", qtd: 1, valor: 180.0 },
      { nome: "Discos de Freio", qtd: 2, valor: 320.0 },
    ],
    maoDeObra: 450.0,
    total: 950.0,
    observacoes: "Cliente relatou ruído ao frear. Discos apresentavam desgaste irregular.",
  },
  {
    id: 2,
    data: "15/01/2026",
    km: "45.000 km",
    tipo: "Preventiva",
    status: "Concluído",
    oficina: "Auto Center Silva",
    servicos: [
      { nome: "Revisão dos 45.000 km", valor: 350.0 },
      { nome: "Troca de Óleo", valor: 150.0 },
      { nome: "Troca de Filtros", valor: 180.0 },
    ],
    pecas: [
      { nome: "Óleo Sintético 5W30", qtd: 4, valor: 240.0 },
      { nome: "Filtro de Óleo", qtd: 1, valor: 35.0 },
      { nome: "Filtro de Ar", qtd: 1, valor: 45.0 },
      { nome: "Filtro de Combustível", qtd: 1, valor: 65.0 },
    ],
    maoDeObra: 680.0,
    total: 1065.0,
    observacoes: "Revisão programada conforme manual do fabricante.",
  },
  {
    id: 3,
    data: "20/09/2025",
    km: "40.000 km",
    tipo: "Preventiva",
    status: "Concluído",
    oficina: "Mecânica João Santos",
    servicos: [
      { nome: "Revisão dos 40.000 km", valor: 300.0 },
      { nome: "Alinhamento", valor: 120.0 },
      { nome: "Balanceamento", valor: 100.0 },
    ],
    pecas: [
      { nome: "Óleo Semi-Sintético", qtd: 4, valor: 160.0 },
      { nome: "Filtro de Óleo", qtd: 1, valor: 35.0 },
    ],
    maoDeObra: 520.0,
    total: 715.0,
    observacoes: "Pneus balanceados e alinhados. Pressão corrigida.",
  },
  {
    id: 4,
    data: "15/05/2025",
    km: "35.000 km",
    tipo: "Corretiva",
    status: "Concluído",
    oficina: "Auto Center Silva",
    servicos: [
      { nome: "Troca de Bateria", valor: 150.0 },
      { nome: "Limpeza de Terminais", valor: 50.0 },
    ],
    pecas: [
      { nome: "Bateria 60Ah", qtd: 1, valor: 380.0 },
    ],
    maoDeObra: 200.0,
    total: 580.0,
    observacoes: "Bateria original apresentou falha. Substituída por bateria de maior durabilidade.",
  },
];

const orcamentosPendentes = [
  {
    id: 1,
    numero: "ORC-156",
    data: "14/03/2026",
    servicos: ["Troca de Amortecedores", "Revisão de Suspensão"],
    valor: 1250.0,
    validade: "21/03/2026",
    status: "Aguardando aprovação",
  },
];

export function HistoricoVeiculo() {
  const navigate = useNavigate();
  const [abaSelecionada, setAbaSelecionada] = useState<"historico" | "orcamentos" | "info">("historico");
  const [manutencaoExpandida, setManutencaoExpandida] = useState<number | null>(null);

  const totalGasto = historicoManutencoes.reduce((acc, m) => acc + m.total, 0);
  const totalManutencoes = historicoManutencoes.length;

  const getTipoColor = (tipo: string) => {
    return tipo === "Preventiva" 
      ? "bg-blue-100 text-blue-800 border-blue-300" 
      : "bg-orange-100 text-orange-800 border-orange-300";
  };

  const toggleManutencao = (id: number) => {
    setManutencaoExpandida(manutencaoExpandida === id ? null : id);
  };

  return (
    <div className="p-4">
      {/* Header com info do veículo */}
      <div className="mb-4">
        <Button 
          variant="ghost" 
          size="sm" 
          onClick={() => navigate(-1)}
          className="mb-3 -ml-2"
        >
          <ArrowLeft className="w-4 h-4 mr-2" />
          Voltar
        </Button>

        <Card className="bg-gradient-to-r from-blue-600 to-blue-700 text-white border-0">
          <CardContent className="p-4">
            <div className="flex items-start gap-3 mb-3">
              <div className="bg-white/20 p-3 rounded-xl">
                <Car className="w-6 h-6 text-white" />
              </div>
              <div className="flex-1">
                <h2 className="text-xl font-bold mb-1">
                  {veiculoDetalhes.marca} {veiculoDetalhes.modelo}
                </h2>
                <div className="flex flex-wrap gap-2">
                  <Badge className="bg-white/20 text-white border-0">{veiculoDetalhes.placa}</Badge>
                  <Badge className="bg-white/20 text-white border-0">{veiculoDetalhes.ano}</Badge>
                  <Badge className="bg-white/20 text-white border-0">{veiculoDetalhes.cor}</Badge>
                  <Badge className="bg-white/20 text-white border-0">{veiculoDetalhes.kmAtual}</Badge>
                </div>
              </div>
            </div>

            <div className="bg-white/10 rounded-lg p-3 text-sm space-y-1">
              <div className="font-semibold">{veiculoDetalhes.proprietario.nome}</div>
              <div className="text-blue-100 text-xs">Última visita: {veiculoDetalhes.ultimaVisita}</div>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Estatísticas */}
      <div className="grid grid-cols-3 gap-2 mb-4">
        <Card>
          <CardContent className="p-3 text-center">
            <Wrench className="w-5 h-5 text-blue-600 mx-auto mb-1" />
            <div className="text-xl font-bold text-slate-800">{totalManutencoes}</div>
            <div className="text-xs text-slate-600">Manutenções</div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-3 text-center">
            <DollarSign className="w-5 h-5 text-green-600 mx-auto mb-1" />
            <div className="text-lg font-bold text-slate-800">R$ {(totalGasto / 1000).toFixed(1)}k</div>
            <div className="text-xs text-slate-600">Total Gasto</div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-3 text-center">
            <TrendingUp className="w-5 h-5 text-purple-600 mx-auto mb-1" />
            <div className="text-lg font-bold text-slate-800">
              R$ {(totalGasto / totalManutencoes).toFixed(0)}
            </div>
            <div className="text-xs text-slate-600">Média/Visita</div>
          </CardContent>
        </Card>
      </div>

      {/* Alertas */}
      {orcamentosPendentes.length > 0 && (
        <Card className="mb-4 bg-amber-50 border-amber-200">
          <CardContent className="p-3">
            <div className="flex items-start gap-2">
              <AlertCircle className="w-4 h-4 text-amber-600 mt-0.5" />
              <div className="flex-1">
                <p className="text-xs font-semibold text-slate-800 mb-1">
                  Orçamento Pendente
                </p>
                <p className="text-xs text-slate-600">
                  Existe {orcamentosPendentes.length} orçamento aguardando aprovação
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      )}

      <Card className="mb-4 bg-blue-50 border-blue-200">
        <CardContent className="p-3">
          <div className="flex items-start gap-2">
            <CheckCircle className="w-4 h-4 text-blue-600 mt-0.5" />
            <div className="flex-1">
              <p className="text-xs font-semibold text-slate-800 mb-1">
                Próxima Revisão
              </p>
              <p className="text-xs text-slate-600">
                Programada para {veiculoDetalhes.proximaRevisao}
              </p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Abas */}
      <div className="flex gap-2 mb-4 border-b border-slate-200">
        <button
          onClick={() => setAbaSelecionada("historico")}
          className={`pb-2 px-3 text-sm font-medium transition-colors border-b-2 ${
            abaSelecionada === "historico"
              ? "text-blue-600 border-blue-600"
              : "text-slate-600 border-transparent"
          }`}
        >
          Histórico
        </button>
        <button
          onClick={() => setAbaSelecionada("orcamentos")}
          className={`pb-2 px-3 text-sm font-medium transition-colors border-b-2 ${
            abaSelecionada === "orcamentos"
              ? "text-blue-600 border-blue-600"
              : "text-slate-600 border-transparent"
          }`}
        >
          Orçamentos ({orcamentosPendentes.length})
        </button>
        <button
          onClick={() => setAbaSelecionada("info")}
          className={`pb-2 px-3 text-sm font-medium transition-colors border-b-2 ${
            abaSelecionada === "info"
              ? "text-blue-600 border-blue-600"
              : "text-slate-600 border-transparent"
          }`}
        >
          Informações
        </button>
      </div>

      {/* Conteúdo das abas */}
      {abaSelecionada === "historico" && (
        <div className="space-y-3">
          {historicoManutencoes.map((manutencao) => (
            <Card key={manutencao.id} className="overflow-hidden">
              <CardContent className="p-0">
                <div
                  className="p-4 cursor-pointer active:bg-slate-50"
                  onClick={() => toggleManutencao(manutencao.id)}
                >
                  <div className="flex items-start justify-between mb-2">
                    <div className="flex items-center gap-2">
                      <div className="bg-gradient-to-br from-blue-500 to-blue-600 p-2 rounded-lg">
                        <Wrench className="w-4 h-4 text-white" />
                      </div>
                      <div>
                        <div className="flex items-center gap-2">
                          <Calendar className="w-3 h-3 text-slate-600" />
                          <span className="font-semibold text-sm">{manutencao.data}</span>
                          <Badge className={`${getTipoColor(manutencao.tipo)} text-xs`}>
                            {manutencao.tipo}
                          </Badge>
                        </div>
                        <div className="text-xs text-slate-600 mt-0.5">
                          {manutencao.km} • {manutencao.oficina}
                        </div>
                      </div>
                    </div>
                    <div className="text-right">
                      <div className="font-bold text-green-600">
                        R$ {manutencao.total.toFixed(2)}
                      </div>
                    </div>
                  </div>

                  <div className="text-xs text-slate-700">
                    <strong>Serviços:</strong> {manutencao.servicos.map(s => s.nome).join(", ")}
                  </div>
                </div>

                {manutencaoExpandida === manutencao.id && (
                  <div className="border-t bg-slate-50 p-4 space-y-4">
                    {/* Serviços detalhados */}
                    <div>
                      <h4 className="font-semibold text-sm text-slate-800 mb-2">Serviços Realizados</h4>
                      <div className="space-y-2">
                        {manutencao.servicos.map((servico, idx) => (
                          <div key={idx} className="flex justify-between text-sm">
                            <span className="text-slate-700">{servico.nome}</span>
                            <span className="font-semibold">R$ {servico.valor.toFixed(2)}</span>
                          </div>
                        ))}
                      </div>
                    </div>

                    {/* Peças utilizadas */}
                    <div>
                      <h4 className="font-semibold text-sm text-slate-800 mb-2">Peças Utilizadas</h4>
                      <div className="space-y-2">
                        {manutencao.pecas.map((peca, idx) => (
                          <div key={idx} className="flex justify-between text-sm">
                            <span className="text-slate-700">
                              {peca.nome} <span className="text-slate-500">(x{peca.qtd})</span>
                            </span>
                            <span className="font-semibold">R$ {peca.valor.toFixed(2)}</span>
                          </div>
                        ))}
                      </div>
                    </div>

                    {/* Totais */}
                    <div className="border-t pt-3 space-y-2">
                      <div className="flex justify-between text-sm">
                        <span className="text-slate-600">Mão de Obra:</span>
                        <span className="font-semibold">R$ {manutencao.maoDeObra.toFixed(2)}</span>
                      </div>
                      <div className="flex justify-between text-base font-bold">
                        <span className="text-slate-800">Total:</span>
                        <span className="text-green-600">R$ {manutencao.total.toFixed(2)}</span>
                      </div>
                    </div>

                    {/* Observações */}
                    {manutencao.observacoes && (
                      <div className="bg-white rounded-lg p-3">
                        <h4 className="font-semibold text-xs text-slate-800 mb-1">Observações:</h4>
                        <p className="text-xs text-slate-600">{manutencao.observacoes}</p>
                      </div>
                    )}

                    <Button variant="outline" size="sm" className="w-full text-xs">
                      <FileText className="w-3 h-3 mr-2" />
                      Ver Ordem de Serviço
                    </Button>
                  </div>
                )}
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      {abaSelecionada === "orcamentos" && (
        <div className="space-y-3">
          {orcamentosPendentes.map((orc) => (
            <Card key={orc.id}>
              <CardContent className="p-4">
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <div className="flex items-center gap-2 mb-1">
                      <FileText className="w-4 h-4 text-slate-600" />
                      <span className="font-semibold">{orc.numero}</span>
                      <Badge className="bg-yellow-100 text-yellow-800 text-xs">
                        Pendente
                      </Badge>
                    </div>
                    <div className="text-xs text-slate-600">
                      Emitido em {orc.data}
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="font-bold text-green-600 text-lg">
                      R$ {orc.valor.toFixed(2)}
                    </div>
                  </div>
                </div>

                <div className="mb-3">
                  <div className="text-xs font-semibold text-slate-700 mb-1">Serviços:</div>
                  <div className="flex flex-wrap gap-1">
                    {orc.servicos.map((s, idx) => (
                      <Badge key={idx} variant="outline" className="text-xs">
                        {s}
                      </Badge>
                    ))}
                  </div>
                </div>

                <div className="text-xs text-amber-700 bg-amber-50 p-2 rounded mb-3">
                  ⏰ Válido até {orc.validade}
                </div>

                <div className="grid grid-cols-2 gap-2">
                  <Button variant="outline" size="sm" className="text-xs">
                    Ver Detalhes
                  </Button>
                  <Button className="bg-blue-600 hover:bg-blue-700 text-xs" size="sm">
                    Aprovar
                  </Button>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}

      {abaSelecionada === "info" && (
        <div className="space-y-3">
          {/* Informações do Veículo */}
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base">Dados do Veículo</CardTitle>
            </CardHeader>
            <CardContent className="space-y-2 text-sm">
              <div className="flex justify-between">
                <span className="text-slate-600">Placa:</span>
                <span className="font-semibold">{veiculoDetalhes.placa}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-600">Marca/Modelo:</span>
                <span className="font-semibold">{veiculoDetalhes.marca} {veiculoDetalhes.modelo}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-600">Ano:</span>
                <span className="font-semibold">{veiculoDetalhes.ano}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-600">Cor:</span>
                <span className="font-semibold">{veiculoDetalhes.cor}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-600">Chassi:</span>
                <span className="font-semibold text-xs">{veiculoDetalhes.chassi}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-600">Renavam:</span>
                <span className="font-semibold">{veiculoDetalhes.renavam}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-slate-600">KM Atual:</span>
                <span className="font-semibold text-blue-600">{veiculoDetalhes.kmAtual}</span>
              </div>
            </CardContent>
          </Card>

          {/* Informações do Proprietário */}
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-base">Dados do Proprietário</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              <div>
                <div className="text-xs text-slate-600 mb-1">Nome</div>
                <div className="font-semibold text-slate-800">{veiculoDetalhes.proprietario.nome}</div>
              </div>
              <div className="flex items-center gap-2">
                <Phone className="w-4 h-4 text-slate-600" />
                <div>
                  <div className="text-xs text-slate-600">Telefone</div>
                  <div className="font-semibold text-sm">{veiculoDetalhes.proprietario.telefone}</div>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <Mail className="w-4 h-4 text-slate-600" />
                <div>
                  <div className="text-xs text-slate-600">E-mail</div>
                  <div className="font-semibold text-sm">{veiculoDetalhes.proprietario.email}</div>
                </div>
              </div>
              <div className="flex items-start gap-2">
                <MapPin className="w-4 h-4 text-slate-600 mt-1" />
                <div>
                  <div className="text-xs text-slate-600">Endereço</div>
                  <div className="font-semibold text-sm">{veiculoDetalhes.proprietario.endereco}</div>
                </div>
              </div>

              <div className="pt-3 border-t grid grid-cols-2 gap-2">
                <Button variant="outline" size="sm" className="text-xs">
                  <Phone className="w-3 h-3 mr-1" />
                  Ligar
                </Button>
                <Button variant="outline" size="sm" className="text-xs">
                  <Mail className="w-3 h-3 mr-1" />
                  E-mail
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* Botões de ação */}
          <div className="grid grid-cols-2 gap-2">
            <Button variant="outline" className="text-sm">
              Editar Veículo
            </Button>
            <Button className="bg-blue-600 hover:bg-blue-700 text-sm">
              Novo Orçamento
            </Button>
          </div>
        </div>
      )}
    </div>
  );
}
