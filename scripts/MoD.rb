gamelog = File.open("games.log", "r").read.split("\n")
#Divide game.log em um array de linhas

def CreateGameReport(start,gamelog)
  a = start+1
  #contador
  mod = []
  while not gamelog[a].include? "InitGame:" and a != gamelog.length-1
    #analisa todas as linhas até o começo de outro jogo (ou final do arquivo)
    line = gamelog[a].split(" ")
    #divide a linha em palavras
    if line.include? "Kill:"
      m = line[line.index("by")+1]
      tmp = true
      for i in mod
        if i.include? m
          i[1] += 1
          tmp = false
        end
      end
      if tmp
        mod.push([m,1])
      end
    end
    #aumente o contador
    a+=1
  end
  #retorne os dados
  return mod
end
def format(data,gameno)
  #formata os dados no formato pedido
  a = "game_"+gameno.to_s+": {\n
    kill_by_means: {\n"
  for i in data
    a+="        '"+i[0]+"': "+i[1].to_s+",\n"
  end
  a+="    }\n}\n"
  return a
end
contador = 1
result = ""
for l in gamelog
  if l.include? "InitGame:"
    result+=format(CreateGameReport(gamelog.index(l),gamelog),contador)
    contador += 1
  end
end
#Registra o resultado no arquivo MoD.log
File.open("MoD.log","w") { |file| file.write(result)}
#imprime o relatório dos jogos
puts result
