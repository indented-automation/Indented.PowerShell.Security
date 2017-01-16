function Get-Secure {
    param(
        [String]$Name = '*',

        [Switch]$Clipboard,

        [Switch]$Detail
    )

    $path = [IO.Path]::Combine(
        [Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments),
        'secure.csv'
    )
    if (Test-Path $path) {
        Import-Csv $path | Where-Object Name -like $Name | ForEach-Object {
            $credential = New-Object PSCredential(
                $_.Username,
                ($_.Password | ConvertTo-SecureString)
            )
            if ($Clipboard) {
                $credential.GetNetworkCredential().Password | Set-Clipboard
            }
            if ($Detail) {
                [PSCustomObject]@{
                    Name       = $_.Name
                    Username   = $_.Username
                    URL        = $_.URL
                    Credential = $credential
                }
            } else {
                $credential
            }
        }
    }
}