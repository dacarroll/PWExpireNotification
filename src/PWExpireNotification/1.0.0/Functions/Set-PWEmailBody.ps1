function Set-PWEmailBody {
    [cmdletbinding()]
    param (
      [string]$Subject,
      [string]$Importance,
      [String]$Message,
      [string]$EmailAddress
    )

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