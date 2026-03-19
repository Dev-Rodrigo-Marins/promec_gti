import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Button } from "../components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../components/ui/select";
import { Save, X } from "lucide-react";
import { toast } from "sonner";

export function CadastrarVeiculo() {
  const [formData, setFormData] = useState({
    placa: "",
    marca: "",
    modelo: "",
    ano: "",
    cor: "",
    proprietario: "",
    telefone: "",
    email: "",
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Aqui seria a integração com o backend
    toast.success("Veículo cadastrado com sucesso!");
    setFormData({
      placa: "",
      marca: "",
      modelo: "",
      ano: "",
      cor: "",
      proprietario: "",
      telefone: "",
      email: "",
    });
  };

  const handleChange = (field: string, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Cadastrar Veículo</h2>
        <p className="text-slate-600 text-sm">Preencha os dados do veículo</p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Dados do Veículo */}
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-base">Dados do Veículo</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="placa" className="text-sm">Placa *</Label>
              <Input
                id="placa"
                placeholder="ABC-1234"
                value={formData.placa}
                onChange={(e) => handleChange("placa", e.target.value)}
                required
                className="text-base"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="marca" className="text-sm">Marca *</Label>
              <Select value={formData.marca} onValueChange={(value) => handleChange("marca", value)} required>
                <SelectTrigger id="marca" className="text-base">
                  <SelectValue placeholder="Selecione a marca" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="volkswagen">Volkswagen</SelectItem>
                  <SelectItem value="fiat">Fiat</SelectItem>
                  <SelectItem value="chevrolet">Chevrolet</SelectItem>
                  <SelectItem value="ford">Ford</SelectItem>
                  <SelectItem value="toyota">Toyota</SelectItem>
                  <SelectItem value="honda">Honda</SelectItem>
                  <SelectItem value="hyundai">Hyundai</SelectItem>
                  <SelectItem value="outros">Outros</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="space-y-2">
                <Label htmlFor="modelo" className="text-sm">Modelo *</Label>
                <Input
                  id="modelo"
                  placeholder="Gol"
                  value={formData.modelo}
                  onChange={(e) => handleChange("modelo", e.target.value)}
                  required
                  className="text-base"
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="ano" className="text-sm">Ano *</Label>
                <Input
                  id="ano"
                  type="number"
                  placeholder="2024"
                  value={formData.ano}
                  onChange={(e) => handleChange("ano", e.target.value)}
                  required
                  className="text-base"
                />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="cor" className="text-sm">Cor</Label>
              <Input
                id="cor"
                placeholder="Prata"
                value={formData.cor}
                onChange={(e) => handleChange("cor", e.target.value)}
                className="text-base"
              />
            </div>
          </CardContent>
        </Card>

        {/* Dados do Proprietário */}
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-base">Dados do Proprietário</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="proprietario" className="text-sm">Nome Completo *</Label>
              <Input
                id="proprietario"
                placeholder="Nome do proprietário"
                value={formData.proprietario}
                onChange={(e) => handleChange("proprietario", e.target.value)}
                required
                className="text-base"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="telefone" className="text-sm">Telefone *</Label>
              <Input
                id="telefone"
                type="tel"
                placeholder="(11) 98765-4321"
                value={formData.telefone}
                onChange={(e) => handleChange("telefone", e.target.value)}
                required
                className="text-base"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="email" className="text-sm">E-mail</Label>
              <Input
                id="email"
                type="email"
                placeholder="email@exemplo.com"
                value={formData.email}
                onChange={(e) => handleChange("email", e.target.value)}
                className="text-base"
              />
            </div>
          </CardContent>
        </Card>

        {/* Botões de ação */}
        <div className="flex gap-3 sticky bottom-20 bg-slate-50 py-3 -mx-4 px-4">
          <Button 
            type="button" 
            variant="outline" 
            className="flex-1"
            onClick={() => setFormData({
              placa: "",
              marca: "",
              modelo: "",
              ano: "",
              cor: "",
              proprietario: "",
              telefone: "",
              email: "",
            })}
          >
            <X className="w-4 h-4 mr-2" />
            Limpar
          </Button>
          <Button type="submit" className="flex-1 bg-blue-600 hover:bg-blue-700">
            <Save className="w-4 h-4 mr-2" />
            Salvar
          </Button>
        </div>
      </form>
    </div>
  );
}