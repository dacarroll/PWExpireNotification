function New-PWEmailBody {
    [cmdletbinding(SupportsShouldProcess=$true)] 
    param (
    [string]$Subject,
    [string]$Importance,
    [String]$Message,
    [string]$EmailAddress
    )
    if ($PSCmdlet.ShouldProcess(("Subject:{0}; Message: {1}; Recipient(s):{2}" -f $Subject,$Message,$EmailAddress))) {
        $body = [pscustomobject]@{
            Message = [pscustomobject]@{
                Subject = $subject
                importance = $importance
                Body = [pscustomobject]@{
                    ContentType = "Text"
                    Content = $Message
                }
                ToRecipients = [array][pscustomobject]@{
                    EmailAddress = [pscustomobject]@{
                        Address = $emailaddress
                    }
                }
            }
            SaveToSentItems = $false
            isDraft = $false
        }
        return $body
    }
}