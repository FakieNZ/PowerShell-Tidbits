param()

Begin{
    $Name = 'Send Pictures with Document'
    $Value = 00000001

    If(Test-Path -Path HKCU:\Software\Microsoft\Office\15.0\Outlook) {
        $RegistyPath = 'HKCU:\Software\Microsoft\Office\15.0\Outlook\Options\Mail'
    }

    Elseif (Test-Path -Path HKCU:\Software\Microsoft\Office\16.0\Outlook) {
        $RegistyPath = 'HKCU:\Software\Microsoft\Office\16.0\Outlook\Options\Mail'
    }

    Else {
        Write-Error -Message 'Cannot find Outlook 2013 or 2016 in the Registry - Check installation and try again'
        Exit (Start-Sleep -Seconds 5)
    }
}

Process{
    $TestPath = Test-Path $RegistyPath

    If ($RegistyPath -eq $null){exit}      

    Elseif ($TestPath -ne 'true') {New-item -Path $RegistyPath}
    
    Else{}
          
    Set-ItemProperty -Path $RegistyPath -Name $Name -Value $Value | Out-Null

    Write-Output "Created a Registry Key - '$RegistyPath\$Name' with a value of 1"
}
End{}
