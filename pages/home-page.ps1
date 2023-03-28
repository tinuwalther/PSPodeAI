Set-PodeWebHomePage -Title  "ChatGPT with PowerShell" -DisplayName 'Jira' -Layouts @(

    New-PodeWebCard -Name "Hey PowerShellAI, let's talk about Jira" -Content @(
    #New-PodeWebHero -Title 'Welcome!' -Message 'This is the PSPodeAI home page' -Content @(

        New-PodeWebForm -Name 'Jira' -ScriptBlock {
            Import-Module PowerShellAI
            $env:OpenAIKey = $($WebEvent.Data.OpenAIKey)
            $data = Get-GPT3Completion -max_tokens 500 -Prompt "$($WebEvent.Data.Question) $($WebEvent.Data.Summary)"
            $data.Trim() | Out-PodeWebTextbox -Multiline
        } -Content @(
            $Properties = @{
                Name        = 'OpenAIKey'
                DisplayName = 'OpenAIKey'
                Type        = 'Password'
                Required    = $true
            }
            New-PodeWebTextbox @Properties -AutoFocus

            $Properties = @{
                Name        = 'Question'
                DisplayName = 'Question'
                Type        = 'Text'
                Value       = 'Generate an agile story description as an engineer with 5 acceptance criterias and 2 deliverable objects for'
                Required    = $true
            }
            New-PodeWebTextbox @Properties
            
            $Properties = @{
                Name        = 'Summary'
                DisplayName = 'Summary'
                Type        = 'Text'
                Value       = 'the usage of open ai to generate jira stories'
                Required    = $true
            }
            New-PodeWebTextbox @Properties
        )

    )

    <#
    New-PodeWebHero -Title 'Welcome!' -Message 'This is the PSPodeAI home page' -Content @(
        New-PodeWebText -Value 'Start pode server: Start-PodeServer.ps1' -InParagraph
        New-PodeWebText -Value 'Restart pode server: Ctrl. + R' -InParagraph
        New-PodeWebText -Value 'Stop pode server: Ctrl. + C' -InParagraph
        New-PodeWebText -Value 'All Pages are locatad in ./PodeWeb/pages/' -InParagraph
    )
    #>

    <#
    Import-Module PowerShellAI
    $env:OpenAIKey = ']xn7M9TmcFeNy##hf(AJ9'
    $summary
    $Question = "Generate an agile story description as an engineer with no acceptance criteria for $($summary)"
    Get-GPT3Completion -max_tokens 500 -Prompt $Question
    #>

)
