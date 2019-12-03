if(-not (Test-Path "$($env:USERPROFILE)\Documents\WindowsPowerShell\Modules\MyTwitter\MyTwitter.psm1")){
    Invoke-Expression (New-Object Net.WebClient).DownloadString("https://gist.githubusercontent.com/stefanstranger/2138dc710576bc40b64b/raw/bfd25a0e7363e9a1906908b0695ebcffaa508276/InstallMyTwitterModule.ps1") -ErrorAction SilentlyContinue
}