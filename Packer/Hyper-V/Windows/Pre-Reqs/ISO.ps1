#This will build your secondary ISO you will require a mkisofs ... see txt file for it and this will need to be in the same folder as this is executed 
$isoFolder = "answer-iso"
if (test-path $isoFolder){
  remove-item $isoFolder -Force -Recurse
}

if (test-path answer.iso){
  remove-item answer.iso -Force
}

mkdir $isoFolder

copy Autounattend.xml $isoFolder\
#copy sysprep-unattend.xml $isoFolder\
#copy .\sysprep.bat $isoFolder\
copy .\bootstrap.ps1 $isoFolder\
$textFile = "$isoFolder\Autounattend.xml"

$c = Get-Content -Encoding UTF8 $textFile

# Enable UEFI and disable Non EUFI
$c | % { $_ -replace '<!-- Start Non UEFI -->','<!-- Start Non UEFI' } | % { $_ -replace '<!-- Finish Non UEFI -->','Finish Non UEFI -->' } | % { $_ -replace '<!-- Start UEFI compatible','<!-- Start UEFI compatible -->' } | % { $_ -replace 'Finish UEFI compatible -->','<!-- Finish UEFI compatible -->' } | sc -Path $textFile

& .\mkisofs.exe -r -iso-level 4 -UDF -o secondary.iso $isoFolder

if (test-path $isoFolder){
  remove-item $isoFolder -Force -Recurse
}
