function Compile-ALProject 
{
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$True)]
        $ContainerName,
        [Parameter(ValueFromPipelineByPropertyName=$True)]
        $AppPath,
        [Parameter(ValueFromPipelineByPropertyName=$True)]
        $TestAppPath,
        [Parameter(ValueFromPipelineByPropertyName=$True)]
        $TestApp
    )

    $ALC = (Get-ChildItem "C:\ProgramData\NavContainerHelper\Extensions\$ContainerName\" -Filter alc.exe -Recurse).FullName
    if (-not $TestApp) {
        Write-Host "Running $ALC for MainApp"
        Push-Location
        Set-Location $AppPath
        & $ALC --% /project:.\ /packagecachepath:.\.alpackages | Convert-ALCOutputToTFS
        Pop-Location
    } else {
        if ($TestAppPath) {
            Write-Host "Running $ALC for TestApp"
            Push-Location
            Set-Location $TestAppPath
            & $ALC --% /project:.\ /packagecachepath:.\.alpackages | Convert-ALCOutputToTFS
            Pop-Location
        }
    }
}