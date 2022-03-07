Function Get-ADDSExpiringPasswordList {
    [cmdletbinding()]
    param (
        $ExpireInDays = 30,

        [scriptblock]$ADFilter
    )
    begin {
    #ToDO
    # Email Attribute selection vs. current single attribute. Mail, custom attribute
    # Still needs logging
    }
    Process {
        # System Settings
        $textEncoding = [System.Text.Encoding]::UTF8
        $Today = Get-Date
        # End System Settings
        if ($PSBoundParameters.ContainsKey('ADFilter' )) {
            $users = get-aduser -filter $ADFilter -Properties Name, PasswordNeverExpires, PasswordExpired, PasswordLastSet, EmailAddress
            $users = $users | Where-Object { ($PSItem.Enabled -eq $true) -and ($PSItem.PasswordNeverExpires -eq $false) -and ($PSItem.PasswordExpired -eq $false) }
        }
        else {
            $users = Get-ADUser -filter * -Properties Name, PasswordNeverExpires, PasswordExpired, PasswordLastSet, EmailAddress
            $users = $users |  Where-Object { ($PSItem.Enabled -eq $true) -and ($PSItem.PasswordNeverExpires -eq $false) -and ($PSItem.PasswordExpired -eq $false) }
        }
        $DefaultmaxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge

        $UserCollection = [System.Collections.Generic.List[pscustomobject]]::new()

        foreach ($user in $users) {
            $PasswordPol = (Get-AduserResultantPasswordPolicy $user)
            # Check for Fine Grained Password
            if (($PasswordPol) -ne $null) {
                $maxPasswordAge = ($PasswordPol).MaxPasswordAge
            }
            else{
                # No FGP set to Domain Default
                $maxPasswordAge = $DefaultmaxPasswordAge
            }
            $UserCollection.Add(
                [pscustomobject]@{
                    Name = $user.Name
                    EmailAddress = $user.EmailAddress
                    PasswordExpiresOn = $user.PasswordLastSet + $maxPasswordAge
                    PasswordDaystoExpire = (New-TimeSpan -Start $Today -End ($user.PasswordLastSet + $maxPasswordAge)).Days
                }
            )
        }
        return $UserCollection
    }
    end {}
}