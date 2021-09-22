Write-Host("Hello " + $env:USERNAME)

function Receive-Output {
    process { write-host $_ -ForegroundColor Red}
}

write-output coucou | Receive-Output

$test =  Read-Host "Who are you ?" -AsSecureString

Write-Output "you said you're $test, that's right ?" | Receive-Output 

$template =  [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Widows.UI.Notifications.Toast.TemplateType]::ToastImageAndText01)

$rawXML = [xml] $template.GetXml()
($rawXML.toast.visual.binding.text | where {$_.id -eq "1"}).AppendChild($rawXML.CreateTextNode("ApplicationTest"))
($rawXML.toast.visual.binding.text | where {$_.id -eq "2"}).AppendChild($rawXML.CreateTextNode("Une notification comme une autre"))

$serializedXML = New-Object Windows.Data.Xml.Dom.XmlDocument
$serializedXML.LoadXml($RawXml.OuterXml)

$toast = [Windows.UI.Notifications.ToastNotification]::new($serializedXML)
$toast.Tag = "ApplicationTest"
$Toast.Group = "ApplicationTest"
$Toast.ExpirationTime = [System.DateTimeOffset]::Now.addMinutes(1)

$Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("ApplicationTest")
$Notifier.Show($toast)