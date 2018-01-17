# Quake-III-Arena-Parser
Parser para o arquivo games.log gerado pelo Quake III

# Requirements
- Ruby instalado no seu sistema

# Running the application
Primeiro coloque uma cópia do seu arquivo games.log dentro da pasta scripts.
Depois, entre na pasta do projeto e clique no arquivo de seu interesse referente ao seu sistema (.sh para Linux e .bat para Windows)
- MoD.sh ou . bat gera um relatório das causas de morte, um arquivo MoD.log será criado na pasta scripts

- Parse.sh ou .bat executa o parser de games.log, um arquivo data.log será criado na pasta scripts

- Rank.sh ou .bat executa o ranking de kills de todos os jogos em games.log, um arquivo rank.log será criado na pasta scripts

# Observações
- o código está em Ruby
- Dois jogadores diferentes podem assumir o mesmo nome, seriam tratados com um jogador só em MoD, e separados em Parser, que utiliza do sistema de Tags (Devido a explicação do problema, presumi que isto seria o certo a fazer, mas esse problema pode ser evitado com o uso de Tags em MoD)
