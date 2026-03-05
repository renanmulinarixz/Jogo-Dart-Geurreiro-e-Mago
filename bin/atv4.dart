import 'dart:io';
import 'dart:math';

abstract class Lutador {
  String nome;
  int vida = 200;
  Lutador(this.nome, this.vida);
  void executarHabilidade(String escolha, Lutador alvo) {
    print("Eu sou um lutador padrão, nao usa habilidades");
  }

  String pedirEscolha() {
    return "";
  }
}

class Guerreiro extends Lutador {
  Guerreiro(String nome, int vida) : super(nome, vida);

  @override
  String pedirEscolha() {
    String escolha = "";
    while (true) {
      stdout.write(
          "VOCÊ TEM DUAS OPÇÕES DE ATAQUE \n    1 - DA UM SOCO, TIRA 10 DE DANO \n 2 - DÊ UM GOLPE DE ESPADA TIRANDO 25 DE DANO");
      String? escolha = stdin.readLineSync() ?? "";
      try {
        if (escolha == "1" || escolha == "2") {
          break;
        } else {
          continue;
        }
      } catch (e) {
        print(e);
      }
    }
    return escolha;
  }

  @override
  void executarHabilidade(String escolha, Lutador alvo) {
    pedirEscolha();
    switch (escolha) {
      case "1":
        alvo.vida - 10;
        break;
      case "2":
        alvo.vida - 25;
        break;
    }
  }
}

class Mago extends Lutador {
  Mago(String nome, int vida) : super(nome, vida);
  int mana = 200;

  @override
  String pedirEscolha() {
    String escolha = "";
    while (true) {
      stdout.write(
          "VOCÊ TEM DUAS OPÇÕES DE ATAQUE \n    1 - DAR UMA CAJADADA, CAUSA 5 DE DANO E NAO GASTA MANA (VOCE TEM 200) \n 2 - DAR UM GOLPE MÁGICO, DA 40 DE DANO E PERDE 20 DE MANA");
      String? escolha = stdin.readLineSync() ?? "";
      try {
        if (escolha == "1" || escolha == "2") {
          break;
        } else {
          continue;
        }
      } catch (e) {
        print(e);
      }
    }
    return escolha;
  }

  @override
  void executarHabilidade(String escolha, Lutador alvo) {
    pedirEscolha();
    switch (escolha) {
      case "1":
        alvo.vida - 10;
        mana - 0;
        break;
      case "2":
        alvo.vida - 25;
        mana - 20;
        break;
    }
  }
}

int gerarRandom() {
  return Random().nextInt(11);
}

void main(List<String> arguments) {

  Guerreiro guerreito1 = Guerreiro("spike", 200);
  Mago mago1 = Mago("Barley", 150);

  while (guerreito1.vida > 0 && mago1.vida > 0) {
    int numeromagico = gerarRandom();

    try {
      print("\n--- RODADA DE COMBATE ---");

      if (numeromagico % 2 == 0) {
        print("Turno do GUERREIRO");
        String escolha = guerreito1.pedirEscolha();
        guerreito1.executarHabilidade(escolha, mago1);
      } else {
        print("Turno do MAGO");
        String escolha = mago1.pedirEscolha();
        mago1.executarHabilidade(escolha, guerreito1);
      }
    } on FormatException {
      print("Erro: Entrada inválida.");
    } catch (e) {
      print("Erro inesperado: $e");
    } finally {
      print(
          "STATUS ATUAL: ${guerreito1.nome}: ${guerreito1.vida} de vida \n ${mago1.nome}: ${mago1.vida} de vida");
    }
  }

  print("\n--- FIM DA LUTA ---");

  if (guerreito1.vida <= 0) {
    print("O vencedor é ${mago1.nome}!");
  } else {
    print("O vencedor é ${guerreito1.nome}!");
  }
}



