import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Button } from "../components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../components/ui/select";
import { Wrench, Plus, Trash2, Edit, Save, X } from "lucide-react";
import { Badge } from "../components/ui/badge";
import { toast } from "sonner";

interface Servico {
  id: number;
  nome: string;
  categoria: string;
  valor: number;
  tempo: string;
}

const servicosMock: Servico[] = [
  { id: 1, nome: "Troca de Óleo", categoria: "Preventiva", valor: 150.0, tempo: "30 min" },
  { id: 2, nome: "Alinhamento", categoria: "Preventiva", valor: 120.0, tempo: "45 min" },
  { id: 3, nome: "Balanceamento", categoria: "Preventiva", valor: 80.0, tempo: "30 min" },
  { id: 4, nome: "Revisão Completa", categoria: "Preventiva", valor: 450.0, tempo: "2h" },
  { id: 5, nome: "Troca de Pastilhas de Freio", categoria: "Corretiva", valor: 280.0, tempo: "1h" },
  { id: 6, nome: "Troca de Discos de Freio", categoria: "Corretiva", valor: 520.0, tempo: "1h30" },
  { id: 7, nome: "Diagnóstico Eletrônico", categoria: "Diagnóstico", valor: 100.0, tempo: "1h" },
];

export function CadastrarServicos() {
  const [servicos, setServicos] = useState<Servico[]>(servicosMock);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [showForm, setShowForm] = useState(false);
  const [formData, setFormData] = useState({
    nome: "",
    categoria: "",
    valor: "",
    tempo: "",
  });

  const handleChange = (field: string, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    if (editingId) {
      // Editar serviço existente
      setServicos(servicos.map(s => 
        s.id === editingId 
          ? { 
              ...s, 
              nome: formData.nome,
              categoria: formData.categoria,
              valor: parseFloat(formData.valor),
              tempo: formData.tempo
            }
          : s
      ));
      toast.success("Serviço atualizado com sucesso!");
    } else {
      // Adicionar novo serviço
      const novoServico: Servico = {
        id: Math.max(...servicos.map(s => s.id), 0) + 1,
        nome: formData.nome,
        categoria: formData.categoria,
        valor: parseFloat(formData.valor),
        tempo: formData.tempo,
      };
      setServicos([...servicos, novoServico]);
      toast.success("Serviço cadastrado com sucesso!");
    }

    // Resetar formulário
    setFormData({ nome: "", categoria: "", valor: "", tempo: "" });
    setEditingId(null);
    setShowForm(false);
  };

  const handleEdit = (servico: Servico) => {
    setFormData({
      nome: servico.nome,
      categoria: servico.categoria,
      valor: servico.valor.toString(),
      tempo: servico.tempo,
    });
    setEditingId(servico.id);
    setShowForm(true);
  };

  const handleDelete = (id: number) => {
    setServicos(servicos.filter(s => s.id !== id));
    toast.success("Serviço removido com sucesso!");
  };

  const handleCancel = () => {
    setFormData({ nome: "", categoria: "", valor: "", tempo: "" });
    setEditingId(null);
    setShowForm(false);
  };

  const getCategoriaColor = (categoria: string) => {
    switch (categoria) {
      case "Preventiva":
        return "bg-blue-100 text-blue-800 border-blue-300";
      case "Corretiva":
        return "bg-orange-100 text-orange-800 border-orange-300";
      case "Diagnóstico":
        return "bg-purple-100 text-purple-800 border-purple-300";
      default:
        return "bg-slate-100 text-slate-800 border-slate-300";
    }
  };

  const servicosPorCategoria = servicos.reduce((acc, servico) => {
    if (!acc[servico.categoria]) {
      acc[servico.categoria] = [];
    }
    acc[servico.categoria].push(servico);
    return acc;
  }, {} as Record<string, Servico[]>);

  return (
    <div className="p-4">
      <div className="flex items-center justify-between mb-4">
        <div>
          <h2 className="text-2xl font-bold text-slate-800">Serviços</h2>
          <p className="text-slate-600 text-sm">Gerencie os serviços da oficina</p>
        </div>
        <Button 
          size="sm" 
          className="bg-blue-600 hover:bg-blue-700"
          onClick={() => setShowForm(!showForm)}
        >
          {showForm ? <X className="w-4 h-4" /> : <Plus className="w-4 h-4" />}
        </Button>
      </div>

      {/* Resumo */}
      <div className="grid grid-cols-3 gap-2 mb-4">
        <Card className="bg-blue-50 border-blue-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-blue-600">{servicos.length}</div>
            <div className="text-xs text-slate-600">Total</div>
          </CardContent>
        </Card>
        <Card className="bg-green-50 border-green-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-green-600">
              {servicos.filter(s => s.categoria === "Preventiva").length}
            </div>
            <div className="text-xs text-slate-600">Preventiva</div>
          </CardContent>
        </Card>
        <Card className="bg-orange-50 border-orange-200">
          <CardContent className="p-3 text-center">
            <div className="text-xl font-bold text-orange-600">
              {servicos.filter(s => s.categoria === "Corretiva").length}
            </div>
            <div className="text-xs text-slate-600">Corretiva</div>
          </CardContent>
        </Card>
      </div>

      {/* Formulário de cadastro/edição */}
      {showForm && (
        <Card className="mb-4 border-blue-300 border-2">
          <CardHeader className="pb-3">
            <CardTitle className="text-base">
              {editingId ? "Editar Serviço" : "Novo Serviço"}
            </CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="nome" className="text-sm">Nome do Serviço *</Label>
                <Input
                  id="nome"
                  placeholder="Ex: Troca de Óleo"
                  value={formData.nome}
                  onChange={(e) => handleChange("nome", e.target.value)}
                  required
                  className="text-base"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="categoria" className="text-sm">Categoria *</Label>
                <Select 
                  value={formData.categoria} 
                  onValueChange={(value) => handleChange("categoria", value)} 
                  required
                >
                  <SelectTrigger id="categoria" className="text-base">
                    <SelectValue placeholder="Selecione a categoria" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Preventiva">Preventiva</SelectItem>
                    <SelectItem value="Corretiva">Corretiva</SelectItem>
                    <SelectItem value="Diagnóstico">Diagnóstico</SelectItem>
                    <SelectItem value="Estética">Estética</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-2">
                  <Label htmlFor="valor" className="text-sm">Valor (R$) *</Label>
                  <Input
                    id="valor"
                    type="number"
                    step="0.01"
                    placeholder="150.00"
                    value={formData.valor}
                    onChange={(e) => handleChange("valor", e.target.value)}
                    required
                    className="text-base"
                  />
                </div>

                <div className="space-y-2">
                  <Label htmlFor="tempo" className="text-sm">Tempo *</Label>
                  <Input
                    id="tempo"
                    placeholder="Ex: 30 min"
                    value={formData.tempo}
                    onChange={(e) => handleChange("tempo", e.target.value)}
                    required
                    className="text-base"
                  />
                </div>
              </div>

              <div className="flex gap-2 pt-2">
                <Button 
                  type="button" 
                  variant="outline" 
                  className="flex-1"
                  onClick={handleCancel}
                >
                  <X className="w-4 h-4 mr-2" />
                  Cancelar
                </Button>
                <Button 
                  type="submit" 
                  className="flex-1 bg-blue-600 hover:bg-blue-700"
                >
                  <Save className="w-4 h-4 mr-2" />
                  {editingId ? "Atualizar" : "Salvar"}
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>
      )}

      {/* Lista de serviços por categoria */}
      <div className="space-y-4">
        {Object.entries(servicosPorCategoria).map(([categoria, servicosCategoria]) => (
          <div key={categoria}>
            <h3 className="font-semibold text-slate-700 mb-2 flex items-center gap-2">
              <Wrench className="w-4 h-4" />
              {categoria}
              <Badge variant="secondary" className="text-xs">
                {servicosCategoria.length}
              </Badge>
            </h3>
            <div className="space-y-2">
              {servicosCategoria.map((servico) => (
                <Card key={servico.id} className="active:scale-98 transition-transform">
                  <CardContent className="p-4">
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-1">
                          <h4 className="font-semibold text-slate-800">{servico.nome}</h4>
                          <Badge className={`${getCategoriaColor(servico.categoria)} text-xs`}>
                            {servico.categoria}
                          </Badge>
                        </div>
                        <div className="flex items-center gap-4 text-sm text-slate-600">
                          <span className="font-bold text-green-600">
                            R$ {servico.valor.toFixed(2)}
                          </span>
                          <span>⏱️ {servico.tempo}</span>
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <Button 
                          variant="ghost" 
                          size="sm"
                          onClick={() => handleEdit(servico)}
                        >
                          <Edit className="w-4 h-4 text-blue-600" />
                        </Button>
                        <Button 
                          variant="ghost" 
                          size="sm"
                          onClick={() => handleDelete(servico.id)}
                        >
                          <Trash2 className="w-4 h-4 text-red-600" />
                        </Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
