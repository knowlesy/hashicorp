#ref
#https://petri.com/how-to-stop-an-unresponsive-hyper-v-virtual-machine/
$VmGUID = Get-VM | where {$_.State -eq "Running"} | Select id
$VMWMProc = (Get-WMIObject Win32_Process | ? {$_.Name -match 'VMWP' -and $_.CommandLine -match $VmGUID.Id})
Stop-Process ($VMWMProc.ProcessId) –Force