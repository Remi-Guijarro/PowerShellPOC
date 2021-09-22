Write-Host("Hello " + $env:USERNAME)

function Receive-Output {
    process { write-host $_ -ForegroundColor Red}
}

write-output coucou | Receive-Output

$test =  Read-Host "Who are you ?" -AsSecureString

Write-Output "you said you're $test, that's right ?" | Receive-Output 