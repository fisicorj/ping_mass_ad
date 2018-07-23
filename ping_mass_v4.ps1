##################################
###### Autor: Manoel Guilherme ###
###### Versão: 4.0 ###############
###### Licensa GLPv3 #############
###### Email: fisicorj@gmail.com #
##################################

$date = "1" # Informar a quantidade de dias desejeda para verificação
$filter = 'operatingsystem -like "*Windows 10*"' # Faça aqui o filtro desejado
#query de consulta no AD
$ad = Get-ADComputer -Filter $filter -properties operatingsystem, PasswordLastSet | Where-Object {((Get-Date) - $_.PasswordLastSet).Days -lt $date} | Select-Object -Property DNSHostName -ExpandProperty DNSHostName

#Criando array vazia
$array_true = @()
$array_false = @()

#Laço de testes
foreach ($Server in $ad) {

  $PingRequest = Test-Connection -ComputerName $Server -Count 2 -Quiet  # Teste conexão com o objeto do AD

        if ($PingRequest -eq $True)  {

        $array_true += $Server  #Adiciona o objeto com valor true na array
        write-output  $array_true | Select-Object -Last 1 | Write-Host -ForegroundColor Green
       } else {
        $array_false += $Server  #Adiciona o objeto com valor true na array
        write-output  $array_false | Select-Object -Last 1 | Write-Host -ForegroundColor Red
       }
}

# Escreve resultado na tela.
Write-Host $array_true.Count "connection successfully" -ForegroundColor Green -nonewline ; write-host " and " -ForegroundColor Blue -nonewline ; write-host $array_false.Count "unsuccessful connection" -ForegroundColor Red -nonewline ; Write-Host " of" $ad.Count -ForegroundColor Blue -nonewline