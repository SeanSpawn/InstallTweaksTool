<#
        .SYNOPSIS
        Adjusts the volume of the media player and saves the setting for persistence.
        .DESCRIPTION
        The `MuteMusic` function sets the volume of the media player to a specified level and saves this volume setting to the registry. 
        This ensures that the volume level is persisted even after restarting the application or the system. 
        The function also updates the window's title to indicate the current state.
        .PARAMETER value
        The volume level to set. It should be an integer value between 0 (muted) and 100 (full volume). The function uses this value to adjust the media player's volume and to store the setting in the registry.
        .EXAMPLE
        MuteMusic -value 50
        Sets the media player's volume to 50% and updates the window title to indicate the current volume level.
        .NOTES
        - The volume value should be an integer between 0 and 100.
    #>
    
function MuteMusic {

    param($value)
    $itt.mediaPlayer.settings.volume = $value
    Set-ItemProperty -Path $itt.registryPath -Name "Music" -Value "$value" -Force
    $itt["window"].title = "Install Tweaks Tool #StandWithPalestine 🔈"
}
# Unmute the music by setting the volume to the specified value
function UnmuteMusic {
    param($value)
    $itt.mediaPlayer.settings.volume = $value
    Set-ItemProperty -Path $itt.registryPath -Name "Music" -Value "$value" -Force
    $itt["window"].title = "Install Tweaks Tool #StandWithPalestine 🔊"
}
# Stop the music and clean up resources
function StopMusic {
    $itt.mediaPlayer.controls.stop()   
    $itt.mediaPlayer = $null
    $script:powershell.Dispose()
    $itt.runspace.Dispose()
    $itt.runspace.Close()
}
# Stop all runspaces, stop the music, and exit the process
function StopAllRunspace {
    $script:powershell.Dispose()
    $itt.runspace.Dispose()
    $itt.runspace.Close()
    $script:powershell.Stop()
    StopMusic
    $newProcess.exit
    [System.GC]::Collect()
}