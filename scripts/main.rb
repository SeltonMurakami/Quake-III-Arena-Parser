gamelog = File.open("games.log", "r").read.split("\n")
#Divide game.log em um array de linhas
#Registro geral dos kills TODO
def CreateGameReport(start,gamelog)
  a = start+1
  #contador
  total_kills = 0
  #conta todos os kills do jogo
  players = []
  #Lista os players no formato [nome, tag]
  kills = []
  #Lista os kills individuais no formato [nome, tag, no de kills]
  while not gamelog[a].include? "InitGame:" and a != gamelog.length-1
    #analisa todas as linhas até o começo de outro jogo (ou final do arquivo)
    line = gamelog[a].split(" ")
    #divide a linha em palavras
    if line.include? "Kill:"
      #se há um kill, aumente o total de kills
      total_kills += 1
      if line[2] == "1022"
        #se a tag for "1022" (tag de <world>), diminua os kills da vítima
        for i in kills
          if i.include? "Tag:"+line[3]
            i[2] += -1
          end
        end
      else
        #caso contrário, aumente o no de kills de quem o fez
        for i in kills
          if i.include? "Tag:"+line[2]
            i[2] += 1
          end
        end
      end
    end
    
    if line.include? "ClientUserinfoChanged:"
      #se as info do jogador mudaram, atualize as listas
      str = line[3,line.length].join(" ")[2,line[3,line.length].join(" ").index("\\t")-2]
      b = true
      #se o cadastro ja existe, o atualize
      for i in players
        if i.include? line[2]
          i[0] = str
          for j in kills
            if j.include? "Tag:"+line[2]
              j[0] = i[0]
            end
          end
          b = false
        end
      end
      #caso contrário, crie um novo cadastro (fiz uma estrutura análoga ao mecanismo for..else do python)
      if b
        players.push([str, line[2]])
        kills.push([str, "Tag:"+line[2], 0])
      end
    end
    
    #aumente o contador
    a+=1
  end
  #retorne os dados
  return [total_kills,players,kills]
end
def format(data,gameno)
  #formata os dados no formato pedido
  a = "game_"+gameno.to_s+": {\n
    total_kills: "+data[0].to_s+"\n
    players: ["
  for i in data[1]
    a+="'"+i[0]+"', "
  end
  a+="]
    kills: {\n"
  for i in data[2]
    a+="        '"+i[0]+"' : "+i[2].to_s+",\n"
  end
  a+="    }\n}"
  return a
end
result = ""
contador = 1
i = 0

while i < gamelog.length
  #analiza cada linha e cria um report caso seja o começo de um jogo(inclui "InitGame:")
  if gamelog[i].include? "InitGame:"
    #assimila o report ao resultado final e aumenta o contador
    result += format(CreateGameReport(i,gamelog),contador)
    #registra os kills desse jogo no ranking geral TODO
    contador += 1
  end
  #aumenta o contador i
  i += 1
end
#Registra o resultado no arquivo data.log
File.open("data.log","w") { |file| file.write(result)}
#imprime o relatório dos jogos
puts result
#coloca o Registro Geral de kills num arquivo TODO