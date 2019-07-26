@echo off
rem no se usa
set user="DOMAIN\user:password"  

set version=evo3
set server=localhost
set virtualdir=WS.NetEnvironment
set dir1=%server%%version%
call ProcesoRequests.cmd

set version=gx16
set server=localhost
set virtualdir=WSgx16.NetEnvironment
set dir2=%server%%version%
call ProcesoRequests.cmd



echo Sustituyo diferencias en WSDL
"utiles\fnr.exe" --cl --dir . --fileMask "*.wsdl" --includeSubDirectories --useRegEx --find "<soap:address.*/>"                       --replace "" 1> nul 2>nul
rem "utiles\fnr.exe" --cl --dir . --fileMask "*.wsdl" --includeSubDirectories            --find "minOccurs=\"0\" maxOccurs=\"unbounded\"" --replace "" > nul
rem "utiles\fnr.exe" --cl --dir . --fileMask "*.wsdl" --includeSubDirectories            --find "form=\"unqualified\""                    --replace "" > nul
rem "utiles\fnr.exe" --cl --dir . --fileMask "*.wsdl" --includeSubDirectories --useRegEx --find "<documen([\n]|.)*\/document>"            --replace ""
rem "utiles\fnr.exe" --cl --dir . --fileMask "*.wsdl" --includeSubDirectories --useRegEx --find "<documentation([\n]|.)*\/documentation>" --replace ""

"utiles\WinMergeU" /r /e /f *.xml;*.txt;*.wsdl /xq   /minimize  %dir1% %dir2%  
