#!/bin/bash
cd scripts
ruby rank.rb
function pause(){
   read -p "$*"
}
pause 'Ranking completo, pressione [Enter] para sair'