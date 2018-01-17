gamelog = File.open("games.log", "r").read.split("\n")
#Divide game.log em um array de linhas
kills = []
#Registro Geral dos kills, no formato [Nome, Tag, killcount]
for line in gamelog
  #analisa cada linha do log
  line = line.split(" ")
  #divide a linha em segmentos separados por " "
  if line.include? "Kill:"
    #se a linha representa um Kill...
    if line[2] != "1022"
      #se a tag de quem matou não é a tag de <world>...
      name = line[5..line.index("killed")-1].join(" ")
      #Nome do jogador que realizou o kill
      tmp = true
      for i in kills
        #checa se o nome já existe em kills
        if i.include? name
          i[1] += 1
          tmp = false
        end
      end
      if tmp
        kills.push([name,1])
      end
    else
      #se <world> realizou o kill, decresça um dos kills do jogador que sofreu o kill
      name = line[line.index("killed")+1..line.index("by")-1].join(" ")
      #Nome do jogador que sofreu o kill
      tmp = true
      for i in kills
        #checa se o nome já existe em kills
        if i.include? name
          i[1] += -1
          tmp = false
        end
      end
      if tmp
        kills.push([name,-1])
      end
    end
  end
end
#Organiza kills de jogador com mais kills para jogador com menos
kills = kills.sort_by(&:last).reverse
a = ""
for i in kills
  a += "'"+i[0]+"', KILLS:"+i[1].to_s+"\n"
end
#cria a string contendo as informações organizadas
puts a
#imprime essa string
File.open("rank.log","w") { |file| file.write(a)}
#Registra esse ranking no arquivo rank.log