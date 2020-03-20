$Value = Read-Host -Prompt "Do you want to start a new Get-Clutter Command ? "
if ($Value -eq "yes"){
    $Answer = $false
    # This is to set the headers of the excel file that stores the gotten clutter details
    $Header1 = "Serial Number|" + "UserPrincipalName|" + "RunspaceId|" + "Enabled value|" + "MailboxIdentity|" + "IsValid|"+"ObjectState" + "`r`n"
    # This is to Out put the headers in a txt file name ClutterLogs1.txt in your C drive
    $Header1 | Out-File -FilePath C:\ClutterLogs1.txt
    # This is to set the headers of the excel file that stores the details of the users not worked on
    $Header2 = "Serial Number|" + "Not Gotten Clutter Details" + "`r`n"
    # This is to Out put the headers in a txt file name NotDone1.txt in your C drive
    $Header2 | Out-File -FilePath C:\NotDone1.txt
}elseif($Value -eq "no"){
    $Answer = $true
    $FirstNum = Read-Host -Prompt "Enter Number You want to Start From ? "
}else{
    $Answer = "do nothing"
}
# If new 
if($Answer -eq $false){
    # $GetMailBoxes = Get-Mailbox | Select-Object UserPrincipalName
    # $SumOfMailBoxes = $GetMailBoxes.Count
    #---------------------------------------------------
    #-----------Update------------------------------------
    $WhatIsLeft = Import-Csv -Path C:\NotDone.csv 
    $SearchString = "Not Gotten Clutter Details"
    $UserPrincipalName = ($WhatIsLeft).$SearchString
    $SumOfMailBoxes = $UserPrincipalName.Count
    #----------------------------------------------------
    #----------------------------------------------------
    $FirstNum = 0
    $LastNum = $SumOfMailBoxes-1
    # start Loop
    $Looper = @($FirstNum..$LastNum)
    foreach($Loop in $Looper){
        # Get Clutter details with UPN from Get-Mailbox command
        $GetClutterDetails = Get-Clutter -Identity $UserPrincipalName[$Loop]
        If($null -ne $GetClutterDetails){
            # This sets the values from the Get-Clutter command as a body in the TXT file 
            $Body = $Loop.ToString() + "|" + $UserPrincipalName[$Loop].ToString() + "|" + $GetClutterDetails.RunspaceId.ToString() + "|" + $GetClutterDetails.IsEnabled.ToString() + "|" + $GetClutterDetails.MailboxIdentity.ToString() + "|" + $GetClutterDetails.IsValid.ToString() + "|" + $GetClutterDetails.ObjectState.ToString() + "`r`n"
            # Sends and Appends details to ClutterLogs1 txt file
            $Body | Out-File -FilePath C:\ClutterLogs1.txt -Append
            Write-Host "I have Completed " $Loop
        }else{
            if($null -ne $UserPrincipalName[$Loop]){
                Write-Host $Loop
                $Loop.ToString() + "|" + $UserPrincipalName[$Loop].ToString() | Out-File -FilePath C:\NotDone1.txt -Append
            }else{
                Write-Host $Loop
                $Loop.ToString() + "|" | Out-File -FilePath C:\NotDone1.txt -Append
            }
        }
    }
# If Old
}elseif($Answer -eq $true){
    # $GetMailBoxes = Get-Mailbox | Select-Object UserPrincipalName
    # $SumOfMailBoxes = $GetMailBoxes.Count
    #---------------------------------------------------
    #-----------Update------------------------------------
    $WhatIsLeft = Import-Csv -Path C:\NotDone.csv 
    $SearchString = "Not Gotten Clutter Details"
    $UserPrincipalName = ($WhatIsLeft).$SearchString
    $SumOfMailBoxes = $UserPrincipalName.Count
    #----------------------------------------------------
    #----------------------------------------------------
    $LastNum = $SumOfMailBoxes-1
    # start Loop
    $Looper = @($FirstNum..$LastNum)
    foreach($Loop in $Looper){
        # Get Clutter details with UPN from Get-Mailbox command
        $GetClutterDetails = Get-Clutter -Identity $UserPrincipalName[$Loop]
        If($null -ne $GetClutterDetails){
            # This sets the values from the Get-Clutter command as a body in the TXT file 
            $Body = $Loop.ToString() + "|" + $UserPrincipalName[$Loop].ToString() + "|" + $GetClutterDetails.RunspaceId.ToString() + "|" + $GetClutterDetails.IsEnabled.ToString() + "|" + $GetClutterDetails.MailboxIdentity.ToString() + "|" + $GetClutterDetails.IsValid.ToString() + "|" + $GetClutterDetails.ObjectState.ToString() + "`r`n"
            # Sends and Appends details to ClutterLogs1 txt file
            $Body | Out-File -FilePath C:\ClutterLogs1.txt -Append
            Write-Host "I have Completed " $Loop
        }else{
            if($null -ne $UserPrincipalName[$Loop]){
                Write-Host $Loop
                $Loop.ToString() + "|" + $UserPrincipalName[$Loop].ToString() | Out-File -FilePath C:\NotDone1.txt -Append
            }else{
                Write-Host $Loop
                $Loop.ToString() + "|" | Out-File -FilePath C:\NotDone1.txt -Append
            }   
        }
    }
}elseif($Answer -like "do nothing"){
    Write-Host "Error !! Enter A Valid Option.."
}

# $WhatIsLeft = Import-Csv -Path C:\NotDone.csv 
# $SearchString = "Not Gotten Clutter Details"
# $UserPrincipalName = ($WhatIsLeft).$SearchString
# echo $UserPrincipalName.Count
# echo $UserPrincipalName