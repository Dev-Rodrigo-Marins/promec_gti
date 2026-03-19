import { createBrowserRouter } from "react-router";
import { Home } from "./pages/Home";
import { CadastrarVeiculo } from "./pages/CadastrarVeiculo";
import { ProcurarVeiculo } from "./pages/ProcurarVeiculo";
import { Agenda } from "./pages/Agenda";
import { Orcamentos } from "./pages/Orcamentos";
import { CadastrarServicos } from "./pages/CadastrarServicos";
import { MontarOrcamento } from "./pages/MontarOrcamento";
import { HistoricoVeiculo } from "./pages/HistoricoVeiculo";
import { Layout } from "./components/Layout";
import { LayoutCliente } from "./components/LayoutCliente";
import { HomeCliente } from "./pages/cliente/HomeCliente";
import { OrcamentosCliente } from "./pages/cliente/OrcamentosCliente";
import { HistoricoCliente } from "./pages/cliente/HistoricoCliente";
import { SolicitarGuincho } from "./pages/cliente/SolicitarGuincho";
import { OficinasCredenciadas } from "./pages/cliente/OficinasCredenciadas";
import { MeusVeiculos } from "./pages/cliente/MeusVeiculos";
import { Login } from "./pages/Login";

export const router = createBrowserRouter([
  {
    path: "/login",
    Component: Login,
  },
  {
    path: "/",
    Component: Layout,
    children: [
      { index: true, Component: Home },
      { path: "cadastrar-veiculo", Component: CadastrarVeiculo },
      { path: "procurar-veiculo", Component: ProcurarVeiculo },
      { path: "agenda", Component: Agenda },
      { path: "orcamentos", Component: Orcamentos },
      { path: "cadastrar-servicos", Component: CadastrarServicos },
      { path: "montar-orcamento", Component: MontarOrcamento },
      { path: "historico-veiculo/:id", Component: HistoricoVeiculo },
    ],
  },
  {
    path: "/cliente",
    Component: LayoutCliente,
    children: [
      { index: true, Component: HomeCliente },
      { path: "orcamentos", Component: OrcamentosCliente },
      { path: "historico", Component: HistoricoCliente },
      { path: "guincho", Component: SolicitarGuincho },
      { path: "oficinas", Component: OficinasCredenciadas },
      { path: "veiculos", Component: MeusVeiculos },
    ],
  },
]);