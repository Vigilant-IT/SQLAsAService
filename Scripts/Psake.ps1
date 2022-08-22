param([parameter(mandatory = $false, position = 1, ValueFromRemainingArguments = $true)]$args)
Import-Module (Resolve-Path 'src\packages\psake.4.6.0\tools\psake.psd1') -ErrorAction stop

Invoke-Psake @args