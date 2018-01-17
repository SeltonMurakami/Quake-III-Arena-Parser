#!/bin/bash
cd scripts
ruby MoD.rb
function pause(){
   read -p "$*"
}
pause 'Script para MoD executado, pressione [Enter] para sair'