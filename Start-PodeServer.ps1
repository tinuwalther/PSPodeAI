Import-Module Pode.Web

Start-PodeServer {

    # Enable Loggin to Terminal
    New-PodeLoggingMethod -Path .\logs -Name "PodeWebServer.log" | Enable-PodeErrorLogging
    #New-PodeLoggingMethod -Terminal | Enable-PodeErrorLogging

    # Use default system Theme
    Use-PodeWebTemplates -Title "Tinu's PSPodeAI" -Theme Dark

    # Add Navbar
    $Properties = @{
        Name = 'PowerShellAI on GitHub'
        Url  = 'https://github.com/dfinke/PowerShellAI'
        Icon = 'help-circle'
    }
    $navgithub = New-PodeWebNavLink @Properties -NewTab
    Set-PodeWebNavDefault -Items $navgithub
    
    # Running on Windows
    if(($PSVersionTable.PSVersion.Major -lt 6) -or ($IsWindows)){
        Write-Host "Running on Windows $($PSScriptRoot)"
        # Add dynamic pages
        foreach($item in (Get-ChildItem (Join-Path $PSScriptRoot -ChildPath 'pages'))){
            . "$($item.FullName)"
        }
        # Add Listener to Tcp Port 8080 on localhost
        $EPProperties = @{
            Address  = 'localhost'
            Port     = 8090
            Protocol = 'http'
        }
        Add-PodeEndpoint @EPProperties #-SelfSigned
        # Start Browser
        $Path = "microsoft-edge:$($EPProperties.Protocol)://$($EPProperties.Address):$($EPProperties.Port)/"
        Start-Process $Path -WindowStyle maximized       
    }else{
        Write-Host "Running on Linux $($PSScriptRoot)"
        # Add dynamic pages
        foreach($item in (Get-ChildItem (Join-Path $PSScriptRoot -ChildPath 'pages') -Exclude 'win_*')){
            . "$($item.FullName)"
        }
        # Add Listener to Tcp Port 8080 on localhost
        $EPProperties = @{
            Address  = 'localhost'
            Port     = 8090
            Protocol = 'http'
        }
        Add-PodeEndpoint @EPProperties
        # Start Browser
        $Path = "$($EPProperties.Protocol)://$($EPProperties.Address):$($EPProperties.Port)/"
        Start-Process $Path
    }

}