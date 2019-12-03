<#
    .EXAMPLE
    Send Tweet today at 5:59 PM
    New-ScheduledTweet -Date (Get-Date -Hour 17 -Minute 59) -Message "Test tweet."
#>
function New-ScheduledTweet {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [datetime]$Date,

        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    <#
    $Date = Get-Date -Hour 18 -Minute 10
    $Message = "This is a test."
    #>

    if(-not (Get-Module MyTwitter)){
        Import-Module "$($env:USERPROFILE)\Documents\WindowsPowerShell\Modules\MyTwitter\MyTwitter.psm1"
    }

    $guid = New-Guid
    $trigger =  New-ScheduledTaskTrigger -Once -At $Date
    # Added due to compatability issues with it not being autopopulated
    $trigger.EndBoundary = $Date.AddSeconds(1).ToString('s')
    $action = New-ScheduledTaskAction -Execute 'Powershell.exe' `
        -Argument "-NoProfile -WindowStyle Hidden -command `"& {Import-Module $($env:USERPROFILE)\Documents\WindowsPowerShell\Modules\MyTwitter\MyTwitter.psm1; Send-Tweet -Message '$Message'}`""
    $settings = New-ScheduledTaskSettingsSet -DeleteExpiredTaskAfter 00:00:01 -DisallowDemandStart
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "SendTweet-$guid" -Description "Automatic tweet at $Date. Created by automation." -Settings $settings -User "$env:USERDOMAIN\$env:USERNAME"
}