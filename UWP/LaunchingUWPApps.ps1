<#Lauching an UWP/AppX Application from Powershell

Basic Syntax is#> Start-Process shell:appsFolder\($AppXPackage.PackageFamilyName)!($ApplicationID)

<#Example One - Launching Trello from Powershell
I selected Trello as an example as it has an application ID that is not standard. For most applications the ID is 'app'#>

    Start-Process shell:appsFolder\45273LiamForsyth.PawsforTrello_7pb5ddty8z1pa!trello

        <#'45273LiamForsyth.PawsforTrello_7pb5ddty8z1pa' is the PackageFamilyName of the AppX Package, which can be found with something like;#>

            Get-AppXPackage | Where-Object -Property Name -like *Trello* | Select-Object -Property PackageFamilyName                                                                                                                
            
            PackageFamilyName
            -----------------
            45273LiamForsyth.PawsforTrello_7pb5ddty8z1pa


        <# 'trello' is the ID of the Appliction found in the appxmanifest.xml file in the application's install location.
        The XML layout for this appliction is 'Package.Applications.Application.ID' #>

            Get-AppXPackage | Where-Object -Property Name -like *Trello* | Select-Object -Property InstallLocation                                                                                                                  
            
            InstallLocation
            ---------------
            C:\Program Files\WindowsApps\45273LiamForsyth.PawsforTrello_2.10.8.0_x64__7pb5ddty8z1pa

            Get-ChildItem 'C:\Program Files\WindowsApps\45273LiamForsyth.PawsforTrello_2.10.8.0_x64__7pb5ddty8z1pa'                                                                                                                 

            Directory: C:\Program Files\WindowsApps\45273LiamForsyth.PawsforTrello_2.10.8.0_x64__7pb5ddty8z1pa

            Mode                LastWriteTime         Length Name
            ----                -------------         ------ ----
            d-----        7/11/2018  11:46 AM                app
            d-----        7/11/2018  11:46 AM                AppxMetadata
            d-----        7/11/2018  11:46 AM                assets
            -a----        7/11/2018  11:46 AM         243939 AppxBlockMap.xml
            -a----        7/11/2018  11:46 AM           1855 AppxManifest.xml
            -a----        7/11/2018  11:46 AM          11212 AppxSignature.p7x
#>    

#An over-engineerd Script for Example One

$AppXPackage = Get-AppXPackage | Where-Object -Property Name -Like *Trello*

$ApplicationID = ([xml](Get-Content (Join-Path -Path $AppXPackage.InstallLocation -ChildPath "\appxmanifest.xml"))).Package.Applications.Application.ID

[String]$AppXLaunchPath = $AppXPackage.PackageFamilyName + '!' + $ApplicationID

Start-Process shell:appsFolder\"$AppXLaunchPath"

<#Notes
    1) appxmanifest.xml can have mulitple applications listed in them.
    2) Most applications, including the once provided with Windows 10, have an application ID of 'app'. Extracting the ID from the Application Manifest may not be nessecery. 
#>
