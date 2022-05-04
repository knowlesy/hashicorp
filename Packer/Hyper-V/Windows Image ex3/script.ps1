#https://github.com/robertmircea/packer-collections/blob/master/scripts/

#Creates standard directorys
New-Item -Path "c:\" -Name "temp" -ItemType "directory"
New-Item -Path "c:\" -Name "support" -ItemType "directory"
New-Item -Path "c:\support" -Name "logs" -ItemType "directory"
New-Item -Path "c:\support" -Name "run-once" -ItemType "directory"
New-Item -Path "c:\support" -Name "scheduled" -ItemType "directory"
New-Item -Path "c:\support" -Name "temp" -ItemType "directory"
New-Item -Path "c:\support" -Name "modules" -ItemType "directory"
New-Item -Path "c:\support" -Name "tools" -ItemType "directory"
New-Item -Path "c:\support" -Name "key" -ItemType "directory"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
#Disable TLS 1.0
new-item -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" -Name "TLS 1.0"
new-item -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0" -Name "Server"
new-item -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0" -Name "Client"
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled" -Value 0
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "DisabledByDefault" -Value 1
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -Value 0
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledByDefault" -Value 1
 
#Disable TLS 1.1
new-item -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" -Name "TLS 1.1"
new-item -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1" -Name "Server"
new-item -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1" -Name "Client"
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -Value 0
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "DisabledByDefault" -Value 1
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -Value 0
new-itemproperty -path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledByDefault" -Value 1
#Shows file extension
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0 -Verbose -Force
#rearming for sysprep
Set-ItemProperty -Path 'HKLM:\SYSTEM\Setup\Status\SysprepStatus' -Name 'GeneralizationState' -Value 7 -Verbose -Force
#sets timezone
Set-TimeZone -Name "GMT Standard Time" -PassThru
#get-sysinternals
function get-sysinternals {
    if (test-connection google.com -Quiet -Count 2) { 
        Write-Host Connected to outside world.......Downloading Sysinternals;
           (New-Object Net.WebClient).DownloadFile('https://download.sysinternals.com/files/SysinternalsSuite.zip', 'C:\support\temp\sysinternals.zip')
           (new-object -com shell.application).namespace('C:\support\tools\').CopyHere((new-object -com shell.application).namespace('C:\support\temp\sysinternals.zip').Items(), 16)
    }
    else
    {write-host Not Downloading zero}
}

get-sysinternals

Remove-Item -Path "C:\support\temp" -Include *.zip -Recurse
# Reset auto logon count
# https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-autologon-logoncount#logoncount-known-issue
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0
#Power Performance
powercfg.exe /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
#Disable Hibernation
powercfg.exe /hibernate off

#Cleanup
# resetbase/thin winsxs
dism /online /cleanup-image /StartComponentCleanup /ResetBase
dism /online /cleanup-Image /SPSuperseded

# optimize disk
Write-Output "Optimizing Disk"
if (Get-Command Optimize-Volume -ErrorAction SilentlyContinue) {
    Optimize-Volume -DriveLetter C -Defrag -verbose
    } else {
    Defrag.exe c: /H
}

#Zeroing Disk 

Start-Job -ScriptBlock { C:\support\tools\sdelete64.exe -accepteula -nobanner -z c:}
Start-Sleep -Seconds 10
$wait = Get-Process "sdelete64" -ErrorAction SilentlyContinue| select-object *
$z = 0
$zmax = 40 
if ($wait.Responding -eq "True")
{
    Write-Host "SDELETE is running this wil ltake some time"
    while ($wait.Responding -eq "True") {
        if ($z -eq $zmax) {
            write-host "Zeroing ran for over 20 mintes terminating process"
            stop-process $wait.Id -force
        }
        else {
            write-host "Zeroing C Drive ($z/$zmax)"
            start-sleep -seconds 30
            $wait = Get-Process "sdelete64" -ErrorAction SilentlyContinue | select-object *
            $z++
        }
    }
}
else
{ 
    Write-Host "SDELETE failed to run"
    #stop-process $wait.Id -force -ErrorAction SilentlyContinue
}
