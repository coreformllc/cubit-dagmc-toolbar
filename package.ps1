# Get the directory of this script
$curr_dir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Write-Host "Generating toolbar file for directory: $curr_dir"

# Replace @TOOLBAR_INSTALL_DIR@ in template.tmpl
(Get-Content "$curr_dir/toolbars/template.tmpl") -replace '@TOOLBAR_INSTALL_DIR@', $curr_dir |
    Set-Content "$curr_dir/toolbars/dagmc_toolbar.ttb"

# Replace @TOOLBAR_INSTALL_DIR@ in .mappings
(Get-Content "$curr_dir/mappings.tmpl") -replace '@TOOLBAR_INSTALL_DIR@', $curr_dir |
    Set-Content "$curr_dir/.mappings"

# Create tar.gz archive (Windows 10+ includes tar via bsdtar)
tar -czvf "cubit_dagmc_toolbar.tar.gz" `
    "./scripts" `
    "./toolbars/dagmc_toolbar.ttb" `
    "./icons" `
    "./.mappings"

# Cleanup the generated .ttb file
Remove-Item "$curr_dir/toolbars/dagmc_toolbar.ttb"
Remove-Item "$curr_dir/.mappings"
