function New-Secure {
    param(
        [Parameter(Mandatory = $true)]
        [String]$Name,

        [String]$URL,

        [Parameter(Mandatory = $true)]
        [PSCredential]$Credential
    )

    $path = [IO.Path]::Combine(
        [Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments),
        'secure.csv'
    )

    Remove-Secure -Name $Name

    [PSCustomObject]@{
        Name       = $Name
        URL        = $URL
        Username   = $credential.Username
        Password   = $credential.Password | ConvertFrom-SecureString
    } | Export-Csv $path -Append -NoTypeInformation
}