function Set-NTSTrustedToAuthForDelegation ([string[]]$Servers) {
    if ([string]::IsNullOrEmpty($Servers)) {throw "Enter servers"}

    $Servers = $Servers -replace ".$($env:USERDNSDOMAIN)"

    foreach ($s in $Servers) {

        $SPNs = @()

        foreach ($x in (Compare-Object $s $Servers | Where-Object {$_.SideIndicator -eq '=>'}).inputobject) {
            $SPNs += @("Microsoft Virtual System Migration Service/$x", "cifs/$x", "Microsoft Virtual System Migration Service/$x.$($env:USERDNSDOMAIN)", "cifs/$x.$($env:USERDNSDOMAIN)")
        }

        $Srv = Get-ADComputer $s
        $Srv | Set-ADObject -Add @{"msDS-AllowedToDelegateTo"=$SPNs}
        Set-ADAccountControl $Srv -TrustedToAuthForDelegation $true
    }
}