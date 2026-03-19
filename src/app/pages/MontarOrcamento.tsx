import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Button } from "../components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../components/ui/select";
import { FileText, Plus, Trash2, Car, User, Save, Search } from "lucide-react";
import { Badge } from "../components/ui/badge";
import { Textarea } from "../components/ui/textarea";
import { toast } from "sonner";

interface Servico {
  id: number;
  nome: string;
  categoria: string;
  valor: number;
  tempo: string;
}

interface ServicoSelecionado extends Servico {
  quantidade: number;
  desconto: number;
}

const servicosDisponiveis: Servico[] = [
  { id: 1, nome: "Troca de Óleo", categoria: "Preventiva", valor: 150.0, tempo: "30 min" },
  { id: 2, nome: "Alinhamento", categoria: "Preventiva", valor: 120.0, tempo: "45 min" },
  { id: 3, nome: "Balanceamento", categoria: "Preventiva", valor: 80.0, tempo: "30 min" },
  { id: 4, nome: "Revisão Completa", categoria: "Preventiva", valor: 450.0, tempo: "2h" },
  { id: 5, nome: "Troca de Pastilhas de Freio", categoria: "Corretiva", valor: 280.0, tempo: "1h" },
  { id: 6, nome: "Troca de Discos de Freio", categoria: "Corretiva", valor: 520.0, tempo: "1h30" },
  { id: 7, nome: "Filtro de Ar", categoria: "Preventiva", valor: 45.0, tempo: "15 min" },
  { id: 8, nome: "Filtro de Óleo", categoria: "Preventiva", valor: 35.0, tempo: "15 min" },
  { id: 9, nome: "Diagnóstico Eletrônico", categoria: "Diagnóstico", valor: 100.0, tempo: "1h" },
];

const veiculosMock = [
  { id: 1, placa: "ABC-1234", modelo: "Volkswagen Gol 2020", proprietario: "João Silva" },
  { id: 2, placa: "DEF-5678", modelo: "Fiat Uno 2019", proprietario: "Maria Santos" },
  { id: 3, placa: "GHI-9012", modelo: "Chevrolet Onix 2022", proprietario: "Pedro Oliveira" },
];

export function MontarOrcamento() {
  const [veiculoSelecionado, setVeiculoSelecionado] = useState("");
  const [servicosSelecionados, setServicosSelecionados] = useState<ServicoSelecionado[]>([]);
  const [observacoes, setObservacoes] = useState("");
  const [validade, setValidade] = useState("7");
  const [searchServico, setSearchServico] = useState("");

  const veiculo = veiculosMock.find(v => v.id.toString() === veiculoSelecionado);

  const adicionarServico = (servico: Servico) => {
    const jaAdicionado = servicosSelecionados.find(s => s.id === servico.id);
    
    if (jaAdicionado) {
      toast.error("Serviço já adicionado ao orçamento");
      return;
    }

    setServicosSelecionados([
      ...servicosSelecionados,
      { ...servico, quantidade: 1, desconto: 0 }
    ]);
    toast.success(`${servico.nome} adicionado`);
  };

  const removerServico = (id: number) => {
    setServicosSelecionados(servicosSelecionados.filter(s => s.id !== id));
    toast.success("Serviço removido");
  };

  const atualizarQuantidade = (id: number, quantidade: number) => {
    if (quantidade < 1) return;
    setServicosSelecionados(
      servicosSelecionados.map(s => s.id === id ? { ...s, quantidade } : s)
    );
  };

  const atualizarDesconto = (id: number, desconto: number) => {
    if (desconto < 0 || desconto > 100) return;
    setServicosSelecionados(
      servicosSelecionados.map(s => s.id === id ? { ...s, desconto } : s)
    );
  };

  const calcularSubtotal = (servico: ServicoSelecionado) => {
    return servico.valor * servico.quantidade;
  };

  const calcularDesconto = (servico: ServicoSelecionado) => {
    return calcularSubtotal(servico) * (servico.desconto / 100);
  };

  const calcularTotal = (servico: ServicoSelecionado) => {
    return calcularSubtotal(servico) - calcularDesconto(servico);
  };

  const totalGeral = servicosSelecionados.reduce((acc, s) => acc + calcularTotal(s), 0);
  const totalDesconto = servicosSelecionados.reduce((acc, s) => acc + calcularDesconto(s), 0);

  const handleSalvarOrcamento = () => {
    if (!veiculoSelecionado) {
      toast.error("Selecione um veículo");
      return;
    }
    if (servicosSelecionados.length === 0) {
      toast.error("Adicione pelo menos um serviço");
      return;
    }
    toast.success("Orçamento criado com sucesso!");
    // Aqui você salvaria no backend
  };

  const servicosFiltrados = servicosDisponiveis.filter(s =>
    s.nome.toLowerCase().includes(searchServico.toLowerCase()) ||
    s.categoria.toLowerCase().includes(searchServico.toLowerCase())
  );

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Montar Orçamento</h2>
        <p className="text-slate-600 text-sm">Crie um novo orçamento para o cliente</p>
      </div>

      {/* Seleção de Veículo */}
      <Card className="mb-4">
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Selecione o Veículo</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <Select value={veiculoSelecionado} onValueChange={setVeiculoSelecionado}>
            <SelectTrigger className="text-base">
              <SelectValue placeholder="Escolha o veículo" />
            </SelectTrigger>
            <SelectContent>
              {veiculosMock.map((v) => (
                <SelectItem key={v.id} value={v.id.toString()}>
                  {v.placa} - {v.modelo}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>

          {veiculo && (
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-3 space-y-2">
              <div className="flex items-center gap-2 text-sm">
                <Car className="w-4 h-4 text-blue-600" />
                <span className="font-semibold">{veiculo.modelo}</span>
              </div>
              <div className="flex items-center gap-2 text-sm">
                <User className="w-4 h-4 text-blue-600" />
                <span>{veiculo.proprietario}</span>
              </div>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Busca de Serviços */}
      <Card className="mb-4">
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Adicionar Serviços</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="relative">
            <Search className="absolute left-3 top-3 w-4 h-4 text-slate-400" />
            <Input
              placeholder="Buscar serviço..."
              value={searchServico}
              onChange={(e) => setSearchServico(e.target.value)}
              className="pl-10 text-base"
            />
          </div>

          <div className="space-y-2 max-h-60 overflow-y-auto">
            {servicosFiltrados.map((servico) => (
              <div
                key={servico.id}
                className="flex items-center justify-between p-3 bg-slate-50 rounded-lg hover:bg-slate-100 transition-colors"
              >
                <div className="flex-1">
                  <div className="font-semibold text-sm text-slate-800">{servico.nome}</div>
                  <div className="flex items-center gap-2 text-xs text-slate-600">
                    <Badge variant="outline" className="text-xs">{servico.categoria}</Badge>
                    <span>R$ {servico.valor.toFixed(2)}</span>
                    <span>⏱️ {servico.tempo}</span>
                  </div>
                </div>
                <Button
                  size="sm"
                  variant="outline"
                  onClick={() => adicionarServico(servico)}
                >
                  <Plus className="w-4 h-4" />
                </Button>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Serviços Selecionados */}
      {servicosSelecionados.length > 0 && (
        <Card className="mb-4">
          <CardHeader className="pb-3">
            <CardTitle className="text-base">
              Serviços no Orçamento ({servicosSelecionados.length})
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            {servicosSelecionados.map((servico) => (
              <div key={servico.id} className="bg-slate-50 rounded-lg p-3 space-y-3">
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <h4 className="font-semibold text-sm text-slate-800">{servico.nome}</h4>
                    <p className="text-xs text-slate-600">R$ {servico.valor.toFixed(2)} / unidade</p>
                  </div>
                  <Button
                    size="sm"
                    variant="ghost"
                    onClick={() => removerServico(servico.id)}
                  >
                    <Trash2 className="w-4 h-4 text-red-600" />
                  </Button>
                </div>

                <div className="grid grid-cols-2 gap-2">
                  <div className="space-y-1">
                    <Label className="text-xs">Quantidade</Label>
                    <Input
                      type="number"
                      min="1"
                      value={servico.quantidade}
                      onChange={(e) => atualizarQuantidade(servico.id, parseInt(e.target.value))}
                      className="h-8 text-sm"
                    />
                  </div>
                  <div className="space-y-1">
                    <Label className="text-xs">Desconto (%)</Label>
                    <Input
                      type="number"
                      min="0"
                      max="100"
                      value={servico.desconto}
                      onChange={(e) => atualizarDesconto(servico.id, parseFloat(e.target.value))}
                      className="h-8 text-sm"
                    />
                  </div>
                </div>

                <div className="border-t pt-2 space-y-1 text-xs">
                  <div className="flex justify-between text-slate-600">
                    <span>Subtotal:</span>
                    <span>R$ {calcularSubtotal(servico).toFixed(2)}</span>
                  </div>
                  {servico.desconto > 0 && (
                    <div className="flex justify-between text-red-600">
                      <span>Desconto ({servico.desconto}%):</span>
                      <span>- R$ {calcularDesconto(servico).toFixed(2)}</span>
                    </div>
                  )}
                  <div className="flex justify-between font-bold text-green-600">
                    <span>Total:</span>
                    <span>R$ {calcularTotal(servico).toFixed(2)}</span>
                  </div>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>
      )}

      {/* Informações Adicionais */}
      <Card className="mb-4">
        <CardHeader className="pb-3">
          <CardTitle className="text-base">Informações Adicionais</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="space-y-2">
            <Label htmlFor="validade" className="text-sm">Validade do Orçamento (dias)</Label>
            <Select value={validade} onValueChange={setValidade}>
              <SelectTrigger id="validade" className="text-base">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="3">3 dias</SelectItem>
                <SelectItem value="7">7 dias</SelectItem>
                <SelectItem value="15">15 dias</SelectItem>
                <SelectItem value="30">30 dias</SelectItem>
              </SelectContent>
            </Select>
          </div>

          <div className="space-y-2">
            <Label htmlFor="observacoes" className="text-sm">Observações</Label>
            <Textarea
              id="observacoes"
              placeholder="Informações adicionais sobre o orçamento..."
              value={observacoes}
              onChange={(e) => setObservacoes(e.target.value)}
              rows={3}
              className="text-base resize-none"
            />
          </div>
        </CardContent>
      </Card>

      {/* Resumo do Orçamento */}
      {servicosSelecionados.length > 0 && (
        <Card className="mb-4 bg-gradient-to-r from-green-50 to-emerald-50 border-green-200">
          <CardContent className="p-4 space-y-2">
            <h3 className="font-semibold text-slate-800 mb-3">Resumo do Orçamento</h3>
            <div className="flex justify-between text-sm">
              <span className="text-slate-600">Quantidade de serviços:</span>
              <span className="font-semibold">{servicosSelecionados.length}</span>
            </div>
            {totalDesconto > 0 && (
              <div className="flex justify-between text-sm text-red-600">
                <span>Total de descontos:</span>
                <span className="font-semibold">- R$ {totalDesconto.toFixed(2)}</span>
              </div>
            )}
            <div className="border-t pt-2 flex justify-between text-lg">
              <span className="font-bold text-slate-800">Valor Total:</span>
              <span className="font-bold text-green-600">R$ {totalGeral.toFixed(2)}</span>
            </div>
            <p className="text-xs text-slate-600 mt-2">
              Válido por {validade} dias a partir da emissão
            </p>
          </CardContent>
        </Card>
      )}

      {/* Botões de Ação */}
      <div className="flex gap-3 sticky bottom-20 bg-slate-50 py-3 -mx-4 px-4">
        <Button variant="outline" className="flex-1">
          Cancelar
        </Button>
        <Button 
          className="flex-1 bg-green-600 hover:bg-green-700"
          onClick={handleSalvarOrcamento}
        >
          <Save className="w-4 h-4 mr-2" />
          Salvar Orçamento
        </Button>
      </div>
    </div>
  );
}
