import { useState } from "react";
import { useNavigate } from "react-router";
import { Card, CardContent } from "../components/ui/card";
import { Input } from "../components/ui/input";
import { Label } from "../components/ui/label";
import { Button } from "../components/ui/button";
import { Wrench, Mail, Lock, Eye, EyeOff } from "lucide-react";
import { toast } from "sonner";

export function Login() {
  const navigate = useNavigate();
  const [showPassword, setShowPassword] = useState(false);
  const [formData, setFormData] = useState({
    email: "",
    senha: "",
  });
  const [tipoUsuario, setTipoUsuario] = useState<"cliente" | "oficina" | null>(null);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    // Validação simples
    if (!formData.email || !formData.senha) {
      toast.error("Preencha todos os campos");
      return;
    }

    // Simulação de login
    toast.success("Login realizado com sucesso!");
    
    // Redireciona baseado no tipo de usuário
    if (tipoUsuario === "cliente") {
      navigate("/cliente");
    } else {
      navigate("/");
    }
  };

  const handleChange = (field: string, value: string) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  if (!tipoUsuario) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-slate-100 flex items-center justify-center p-4 max-w-md mx-auto">
        <div className="w-full space-y-6">
          {/* Logo e título */}
          <div className="text-center mb-8">
            <div className="bg-gradient-to-r from-blue-600 to-blue-700 w-20 h-20 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
              <Wrench className="w-10 h-10 text-white" />
            </div>
            <h1 className="text-3xl font-bold text-slate-800 mb-2">ProMec-GTI</h1>
            <p className="text-slate-600">Sistema de Gestão de Oficina</p>
          </div>

          {/* Seleção de tipo de usuário */}
          <div className="space-y-3">
            <h2 className="text-xl font-semibold text-slate-800 text-center mb-4">
              Como você deseja acessar?
            </h2>

            <Card 
              className="cursor-pointer hover:shadow-lg transition-all active:scale-95 border-2 hover:border-blue-300"
              onClick={() => setTipoUsuario("cliente")}
            >
              <CardContent className="p-6">
                <div className="flex items-center gap-4">
                  <div className="bg-gradient-to-br from-blue-500 to-blue-600 p-4 rounded-xl">
                    <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                  </div>
                  <div className="flex-1">
                    <h3 className="font-semibold text-slate-800 text-lg">
                      Sou Cliente
                    </h3>
                    <p className="text-sm text-slate-600">
                      Acesse seus orçamentos e histórico
                    </p>
                  </div>
                </div>
              </CardContent>
            </Card>

            <Card 
              className="cursor-pointer hover:shadow-lg transition-all active:scale-95 border-2 hover:border-green-300"
              onClick={() => setTipoUsuario("oficina")}
            >
              <CardContent className="p-6">
                <div className="flex items-center gap-4">
                  <div className="bg-gradient-to-br from-green-500 to-green-600 p-4 rounded-xl">
                    <Wrench className="w-8 h-8 text-white" />
                  </div>
                  <div className="flex-1">
                    <h3 className="font-semibold text-slate-800 text-lg">
                      Sou Oficina
                    </h3>
                    <p className="text-sm text-slate-600">
                      Gerencie veículos e agendamentos
                    </p>
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-slate-100 flex items-center justify-center p-4 max-w-md mx-auto">
      <div className="w-full space-y-6">
        {/* Logo e título */}
        <div className="text-center mb-8">
          <div className="bg-gradient-to-r from-blue-600 to-blue-700 w-20 h-20 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
            <Wrench className="w-10 h-10 text-white" />
          </div>
          <h1 className="text-3xl font-bold text-slate-800 mb-2">ProMec-GTI</h1>
          <p className="text-slate-600">
            {tipoUsuario === "cliente" ? "Área do Cliente" : "Área da Oficina"}
          </p>
        </div>

        {/* Formulário de login */}
        <Card className="shadow-xl">
          <CardContent className="pt-6 pb-6">
            <form onSubmit={handleSubmit} className="space-y-5">
              <div className="space-y-2">
                <Label htmlFor="email" className="text-sm font-medium text-slate-700">
                  E-mail
                </Label>
                <div className="relative">
                  <Mail className="absolute left-3 top-3 w-5 h-5 text-slate-400" />
                  <Input
                    id="email"
                    type="email"
                    placeholder="seu@email.com"
                    value={formData.email}
                    onChange={(e) => handleChange("email", e.target.value)}
                    required
                    className="pl-11 h-12 text-base"
                  />
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="senha" className="text-sm font-medium text-slate-700">
                  Senha
                </Label>
                <div className="relative">
                  <Lock className="absolute left-3 top-3 w-5 h-5 text-slate-400" />
                  <Input
                    id="senha"
                    type={showPassword ? "text" : "password"}
                    placeholder="••••••••"
                    value={formData.senha}
                    onChange={(e) => handleChange("senha", e.target.value)}
                    required
                    className="pl-11 pr-11 h-12 text-base"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-3 text-slate-400 hover:text-slate-600"
                  >
                    {showPassword ? (
                      <EyeOff className="w-5 h-5" />
                    ) : (
                      <Eye className="w-5 h-5" />
                    )}
                  </button>
                </div>
              </div>

              <div className="flex items-center justify-between text-sm">
                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    className="w-4 h-4 rounded border-slate-300 text-blue-600 focus:ring-blue-500"
                  />
                  <span className="text-slate-600">Lembrar-me</span>
                </label>
                <a href="#" className="text-blue-600 hover:text-blue-700 font-medium">
                  Esqueceu a senha?
                </a>
              </div>

              <Button
                type="submit"
                className="w-full h-12 text-base bg-gradient-to-r from-blue-600 to-blue-700 hover:from-blue-700 hover:to-blue-800"
              >
                Entrar
              </Button>
            </form>
          </CardContent>
        </Card>

        {/* Links adicionais */}
        <div className="text-center space-y-3">
          <Button
            variant="ghost"
            onClick={() => setTipoUsuario(null)}
            className="text-slate-600 hover:text-slate-800"
          >
            ← Voltar para seleção
          </Button>
          
          <p className="text-sm text-slate-600">
            Não tem uma conta?{" "}
            <a href="#" className="text-blue-600 hover:text-blue-700 font-medium">
              Cadastre-se
            </a>
          </p>
        </div>

        {/* Footer */}
        <div className="text-center text-xs text-slate-500 pt-4">
          <p>© 2026 ProMec-GTI. Todos os direitos reservados.</p>
        </div>
      </div>
    </div>
  );
}
