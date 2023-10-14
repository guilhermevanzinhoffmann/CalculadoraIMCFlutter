import 'package:calculadora_imc_app/models/historico.dart';
import 'package:calculadora_imc_app/repositories/sqlite/sqlite_database.dart';

class HistoricoRepository {
  Future<List<Historico>> obterDados() async {
    List<Historico> tarefas = [];
    var db = await SQLiteDataBase().obterDatabase();
    var result = await db.rawQuery(
        'SELECT id, resultadoImc, estadoImc, nome, altura, peso, data FROM historicos ORDER BY data DESC');

    for (var element in result) {
      var historico = Historico(
          element["nome"].toString(),
          element["altura"].toString(),
          element["peso"].toString(),
          element["estadoImc"].toString(),
          element["resltadoImc"].toString(),
          element["data"].toString());
      historico.id = int.tryParse(element["id"].toString()) ?? 0;
      tarefas.add(historico);
    }

    return tarefas;
  }

  Future<Historico> obterHistoricoPorData(String data) async {
    var historico = Historico.empty();
    var db = await SQLiteDataBase().obterDatabase();

    var result = await db.rawQuery(
        'SELECT id, resultadoImc, estadoImc, nome, altura, peso, data FROM historicos where data = ? LIMIT 1',
        [data]);

    for (var element in result) {
      historico = Historico(
          element["nome"].toString(),
          element["altura"].toString(),
          element["peso"].toString(),
          element["estadoImc"].toString(),
          element["resltadoImc"].toString(),
          element["data"].toString());
      historico.id = int.tryParse(element["id"].toString()) ?? 0;
    }

    return historico;
  }

  Future<void> salvar(Historico historico) async {
    var db = await SQLiteDataBase().obterDatabase();
    await db.rawInsert(
        "INSERT INTO historicos (resultadoImc, estadoImc, nome, altura, peso, data) values(?, ?, ?, ?, ?, ?)",
        [
          historico.resultadoImc,
          historico.estadoImc,
          historico.nome,
          historico.altura,
          historico.peso,
          historico.data
        ]);
  }

  Future<void> atualizar(Historico historico) async {
    var db = await SQLiteDataBase().obterDatabase();
    await db.rawInsert(
        "UPDATE historicos SET resultadoImc = ?, estadoImc = ?, nome = ?, altura = ?, peso = ?, data = ? WHERE id = ?",
        [
          historico.resultadoImc,
          historico.estadoImc,
          historico.nome,
          historico.altura,
          historico.peso,
          historico.data,
          historico.id
        ]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBase().obterDatabase();
    await db.rawInsert("DELETE from historicos WHERE id = ?", [id]);
  }
}
