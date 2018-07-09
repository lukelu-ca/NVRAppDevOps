function Read-ALConfiguration
{    
    Param(
        #Path to the repository
        $Path='.\',
        #If set, scripts will work as under VSTS/TFS. If not set, it will work in "interactive" mode
        $Build,
        #Password which will be used for the container user - when WindowsAuthentication used, it is the domain password of the current user
        $Password
    )

    $SettingsScript = (Join-Path $Path 'Scripts\Settings.ps1')
    if (Test-Path $SettingsScript) {
        Write-Host "Running $SettingsScript ..."
        . (Join-Path $Path 'Scripts\Settings.ps1')
    }
    $ClientPath = Get-ALDesktopClientPath -ContainerName $ContainerName
    $Configuration = Get-ALConfiguration `
                            -ContainerName $ContainerName `
                            -ImageName $ImageName `
                            -LicenseFile $LicenseFile `
                            -VsixPath $VsixPath `
                            -PlatformVersion $AppJSON.platform `
                            -AppVersion $AppJSON.version `
                            -TestAppVersion $TestAppJSON.version `
                            -AppName $AppJSON.name `
                            -TestAppName $TestAppJSON.name `
                            -AppFile $AppFile `
                            -TestAppFile $TestAppFile `
                            -Publisher $AppJSON.publisher `
                            -TestPublisher $TestAppJSON.publisher `
                            -RepoPath $RepoPath `
                            -AppPath $AppPath `
                            -TestAppPath $TestAppPath `
                            -Build $Build `
                            -Password $Password `
                            -ClientPath $ClientPath

    Write-Output $Configuration
}