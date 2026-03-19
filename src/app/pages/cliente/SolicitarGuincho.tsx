import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "../../components/ui/card";
import { Button } from "../../components/ui/button";
import { Input } from "../../components/ui/input";
import { Label } from "../../components/ui/label";
import { Textarea } from "../../components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "../../components/ui/select";
import { Truck, MapPin, Phone, AlertCircle, Clock, CheckCircle } from "lucide-react";
import { Badge } from "../../components/ui/badge";
import { toast } from "sonner";

export function SolicitarGuincho() {
  const [step, setStep] = useState(1);
  const [formData, setFormData] = useState({
    veiculo: "",
    localizacao: "",
    destino: "",
    problema: "",
    telefone: "",
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setStep(3);
    toast.success("Guincho solicitado com sucesso!");
  };

  const handleChange = (field: string, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  if (step === 3) {
    return (
      <div className="p-4">
        <div className="mb-4">
          <h2 className="text-2xl font-bold text-slate-800">Guincho Solicitado</h2>
          <p className="text-slate-600 text-sm">Acompanhe o status</p>
        </div>

        <Card className="bg-green-50 border-green-200 mb-4">
          <CardContent className="p-4 text-center">
            <div className="bg-green-500 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-3">
              <CheckCircle className="w-8 h-8 text-white" />
            </div>
            <h3 className="font-bold text-slate-800 mb-1">Guincho a caminho!</h3>
            <p className="text-sm text-slate-600">
              Tempo estimado de chegada: <strong>15-20 minutos</strong>
            </p>
          </CardContent>
        </Card>

        <Card className="mb-4">
          <CardHeader className="pb-3">
            <CardTitle className="text-base">Informações da Solicitação</CardTitle>
          </CardHeader>
          <CardContent className="space-y-3 text-sm">
            <div>
              <span className="text-slate-600">Protocolo:</span>
              <span className="font-semibold ml-2">#GC-2026-0345</span>
            </div>
            <div>
              <span className="text-slate-600">Veículo:</span>
              <span className="font-semibold ml-2">ABC-1234 - Gol 2020</span>
            </div>
            <div>
              <span className="text-slate-600">Origem:</span>
              <span className="font-semibold ml-2 text-xs">
                {formData.localizacao || "Av. Paulista, 1000"}
              </span>
            </div>
            <div>
              <span className="text-slate-600">Destino:</span>
              <span className="font-semibold ml-2 text-xs">
                {formData.destino || "Auto Center Silva"}
              </span>
            </div>
          </CardContent>
        </Card>

        <Card className="mb-4">
          <CardHeader className="pb-3">
            <CardTitle className="text-base">Motorista do Guincho</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="flex items-center gap-3 mb-3">
              <div className="bg-gradient-to-br from-blue-500 to-blue-600 w-12 h-12 rounded-full flex items-center justify-center text-white font-bold">
                MS
              </div>
              <div>
                <div className="font-semibold text-slate-800">Marcos Silva</div>
                <div className="text-xs text-slate-600">Guincho Placa: XYZ-9876</div>
                <Badge className="bg-green-100 text-green-800 text-xs mt-1">
                  4.9 ⭐ (234 avaliações)
                </Badge>
              </div>
            </div>
            <Button className="w-full bg-green-600 hover:bg-green-700">
              <Phone className="w-4 h-4 mr-2" />
              Ligar para o Motorista
            </Button>
          </CardContent>
        </Card>

        <Card className="bg-blue-50 border-blue-200">
          <CardContent className="p-4">
            <div className="flex items-start gap-2">
              <AlertCircle className="w-4 h-4 text-blue-600 mt-0.5" />
              <p className="text-xs text-slate-600">
                Você receberá notificações em tempo real sobre a localização do guincho.
                Mantenha-se próximo ao veículo.
              </p>
            </div>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="p-4">
      <div className="mb-4">
        <h2 className="text-2xl font-bold text-slate-800">Solicitar Guincho</h2>
        <p className="text-slate-600 text-sm">Preencha os dados para solicitar</p>
      </div>

      {/* Alerta de emergência */}
      <Card className="mb-4 bg-red-50 border-red-200">
        <CardContent className="p-4">
          <div className="flex items-start gap-3">
            <div className="bg-red-500 p-2 rounded-lg">
              <AlertCircle className="w-4 h-4 text-white" />
            </div>
            <div>
              <h3 className="font-semibold text-slate-800 text-sm mb-1">
                Serviço 24 horas
              </h3>
              <p className="text-xs text-slate-600">
                Atendimento de emergência disponível 24h por dia, 7 dias por semana
              </p>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Tempo estimado */}
      <div className="grid grid-cols-2 gap-3 mb-4">
        <Card className="bg-blue-50 border-blue-200">
          <CardContent className="p-3 text-center">
            <Clock className="w-5 h-5 text-blue-600 mx-auto mb-1" />
            <div className="text-xs text-slate-600">Tempo médio</div>
            <div className="text-sm font-bold text-blue-600">15-20 min</div>
          </CardContent>
        </Card>
        <Card className="bg-green-50 border-green-200">
          <CardContent className="p-3 text-center">
            <Truck className="w-5 h-5 text-green-600 mx-auto mb-1" />
            <div className="text-xs text-slate-600">Guinchos disponíveis</div>
            <div className="text-sm font-bold text-green-600">8 próximos</div>
          </CardContent>
        </Card>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        <Card>
          <CardContent className="pt-6 space-y-4">
            <div className="space-y-2">
              <Label htmlFor="veiculo" className="text-sm">Selecione o Veículo *</Label>
              <Select 
                value={formData.veiculo} 
                onValueChange={(value) => handleChange("veiculo", value)} 
                required
              >
                <SelectTrigger id="veiculo" className="text-base">
                  <SelectValue placeholder="Escolha o veículo" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="gol">ABC-1234 - Volkswagen Gol 2020</SelectItem>
                  <SelectItem value="civic">DEF-5678 - Honda Civic 2021</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="localizacao" className="text-sm">Sua Localização Atual *</Label>
              <div className="relative">
                <MapPin className="absolute left-3 top-3 w-4 h-4 text-slate-400" />
                <Input
                  id="localizacao"
                  placeholder="Digite o endereço ou use GPS"
                  value={formData.localizacao}
                  onChange={(e) => handleChange("localizacao", e.target.value)}
                  required
                  className="pl-10 text-base"
                />
              </div>
              <Button 
                type="button" 
                variant="outline" 
                size="sm" 
                className="w-full text-xs"
              >
                <MapPin className="w-3 h-3 mr-1" />
                Usar Minha Localização Atual
              </Button>
            </div>

            <div className="space-y-2">
              <Label htmlFor="destino" className="text-sm">Para onde levar o veículo? *</Label>
              <Select 
                value={formData.destino} 
                onValueChange={(value) => handleChange("destino", value)} 
                required
              >
                <SelectTrigger id="destino" className="text-base">
                  <SelectValue placeholder="Escolha o destino" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="auto-center">Auto Center Silva - Av. Paulista, 500</SelectItem>
                  <SelectItem value="mecanica-joao">Mecânica João Santos - Rua das Flores, 234</SelectItem>
                  <SelectItem value="outro">Outro endereço (especificar)</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label htmlFor="problema" className="text-sm">Descreva o Problema</Label>
              <Textarea
                id="problema"
                placeholder="Ex: Pneu furado, bateria descarregada, problema no motor..."
                value={formData.problema}
                onChange={(e) => handleChange("problema", e.target.value)}
                rows={3}
                className="text-base resize-none"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="telefone" className="text-sm">Telefone para Contato *</Label>
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
          </CardContent>
        </Card>

        {/* Valor estimado */}
        <Card className="bg-amber-50 border-amber-200">
          <CardContent className="p-4">
            <div className="flex items-center justify-between">
              <span className="text-sm text-slate-700">Valor estimado do serviço:</span>
              <span className="text-xl font-bold text-green-600">R$ 150,00</span>
            </div>
            <p className="text-xs text-slate-600 mt-2">
              * Valor pode variar conforme a distância e complexidade
            </p>
          </CardContent>
        </Card>

        <Button 
          type="submit" 
          className="w-full bg-red-600 hover:bg-red-700 py-6 text-base"
        >
          <Truck className="w-5 h-5 mr-2" />
          Solicitar Guincho Agora
        </Button>
      </form>
    </div>
  );
}
