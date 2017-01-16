function Remove-Secure {
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [String]$Name
    )
    
    begin {
        $path = [IO.Path]::Combine(
            [Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments),
            'secure.csv'
        )
    }

    process {
        if (Get-Secure $Name) {
            $updated = Import-Csv $path | Where-Object Name -ne $Name
            $updated | Export-Csv $path -NoTypeInformation
        }
    }
}