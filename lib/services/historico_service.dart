import 'package:calculadora_imc_app/models/card_detail.dart';
import 'package:calculadora_imc_app/models/historico.dart';
import 'package:calculadora_imc_app/repositories/historico_repository.dart';

class HistoricoService {
  HistoricoRepository repository = HistoricoRepository();

  Future<List<CardDetail>> obterDados() async {
    List<CardDetail> result = [];

    var historicos = await repository.obterDados();

    for (var item in historicos) {
      result.add(CardDetail(item.id, item.resultadoImc, item.estadoImc,
          item.nome, item.altura, item.peso, item.data));
    }

    return result;
  }

  Future<void> salvar(Historico historico) async {
    var historicoExistente =
        await repository.obterHistoricoPorData(historico.data);

    if (historicoExistente.id != -1) {
      repository.remover(historicoExistente.id);
    }

    await repository.salvar(historico);
  }

  Future<void> remover(int id) async {
    await repository.remover(id);
  }
}
