param
(
    [switch]$Clip,
    [Parameter (mandatory=$true)][string]$Username
)

Begin
{
    If ($Clip = $true) {
        Write-Output "Copying AD Membership to clipboard for $Username"
    }
    Else {Continue}
}
Process
{
    $Groups = Get-ADPrincipalGroupMembership -Identity $Username | Select-Object name

    If ($Clip = $true) {
        $Groups.name | ForEach-Object { $_ + ";" } | Clip
    }
    else {
        Write-Output $Groups.name
    }
}
