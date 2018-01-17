#!/bin/bash
cd scripts
ruby main.rb
function pause(){
   read -p "$*"
}
pause 'Parser executado, pressione [Enter] para sair'