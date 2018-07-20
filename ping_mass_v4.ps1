﻿##################################
###### Autor: Manoel Guilherme ###
###### Versão: 3.0 ###############
###### Licensa GLPv3 #############
###### Email: fisicorj@gmail.com #
##################################

$date = "1" # Informar a quantidade de dias desejeda para verificação
$filter = 'operatingsystem -like "*Windows 10*"' # Faça aqui o filtro desejado
#query de consulta no AD
$ad = Get-ADComputer -Filter $filter -properties operatingsystem, PasswordLastSet | Where-Object {((Get-Date) - $_.PasswordLastSet).Days -lt $date} | Select-Object -Property DNSHostName -ExpandProperty DNSHostName

#Criando array vazia
$array = @()

#Laço de testes
foreach ($Server in $ad) {

  $PingRequest = Test-Connection -ComputerName $Server -Count 2 -Quiet  # Teste conexão com o objeto do AD

        if ($PingRequest -eq $True)  {

         $array += $Server  #Adiciona o objeto com valor true na array
         #$string = $array -join "`n"
         #Write-Host $string  -ForegroundColor Green
         write-output  $array | Select-Object -Last 1 | Write-Host -ForegroundColor Green
       }
}

#write-output $array.Count "of" $ad.Count | Format-Table  # Escreve resultado na tela.
Write-Host $array.Count -ForegroundColor Green -nonewline "of " ; write-host $ad.Count -ForegroundColor Red #| Format-Table  # Escreve resultado na tela.