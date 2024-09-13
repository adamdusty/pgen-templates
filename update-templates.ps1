Get-ChildItem -Filter *.yaml | %{ git checkout template-sources $_.Name}
git commit -m "Updated templates from template-sources branch"