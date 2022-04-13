Function New-PWEmailMessagePayload {
    [cmdletbinding(SupportsShouldProcess=$true)]
    param (
        [parameter(
            Mandatory=$true,
            ParameterSetName = 'Message'
         )]
        [string]$TextToAdd,

        [parameter(
            Mandatory=$true,
            ParameterSetName = 'Message'
        )]
        [parameter(
            Mandatory=$true,
            ParameterSetName = 'Subject'
        )]
        [pscustomobject]$ADAccount,

        [parameter(
            Mandatory=$true,
            ParameterSetName = 'Message'
        )]
        [pscustomobject]$Signature,

        [parameter(
            Mandatory=$true,
            ParameterSetName = 'Subject'
        )]
        [String]$Subject
    )
    $text = @"
Dear {0},

Your Password will expire {1}

$TextToAdd

Thanks,

$Signature
"@

    if ($PSCmdlet.ShouldProcess("Creating new {0}" -f $PSCmdlet.ParameterSetName)) {

        if (($ADAccount.PasswordDaystoExpire) -gt "1") {
            $messageDays = "in " + "$($ADAccount.PasswordDaystoExpire)" + " days."
        }
        else {
            $messageDays = "today."
        }
        if ($PSBoundParameters.ContainsKey('Signature')) {

        $outtext = ($text -f $ADAccount.Name, $messageDays)
        }
        elseif ($PSBoundParameters.ContainsKey('Subject')) {
            $outtext = ($Subject -f $messageDays)
        }
        return $outtext
    }
}