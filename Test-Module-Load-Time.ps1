# create a script block to mesure the load time of every powershell modules

$modules = Get-Module -ListAvailable
$measurements = @{}

foreach ($module in $modules) {
    $moduleName = $module.Name
    $measurements[$moduleName] = Measure-Command { Import-Module -Name $moduleName }
}

$measurements
