
rem --- Ejecuta una url de web service con un request, genera el wsdl y graba un log con el httpcode ---
rem --- Se genera un txt con el formato del xml para que sea mas facil de comparar                   ---
rem ---    *.wsdl Definicion del WSDL
rem ---    *.xml  Request de salida
rem ---    *.txt  Request de salida traducido a texto
@echo off

echo --------------------------------------------------
echo  PROCESO %SERVER% %VERSION% %DATE% %TIME%
echo --------------------------------------------------

del %server%%version%\*.xml  1> nul 2> nul
del %server%%version%\*.txt  1> nul 2> nul 
del %server%%version%\*.wsdl 1> nul 2> nul
md %server%%version%         1> nul 2> nul

REM Leo archivo con los request y ejecuto un Request al server
for /f "usebackq tokens=1-5 delims=," %%a in (".\requests\requests.ini") do ( call :ejecutoUnRequest %%a %%b %%c %%d %%e) 

echo Transformo XML en TXT para hacer mas facil la comparacion. 
for %%f in (%server%%version%\*.xml) do call utiles\axmltoText.exe  %%f > %%f.txt 

exit /b

:ejecutoUnRequest
set primer=%1
if [%primer:~0,1%]==[#] (exit /b)  
if [%primer:~0,1%]==[ ] (exit /b)

set nombrews=%1
set soapaction=%2
set numerorequest=%3
set filename=.\requests\%nombrews%%numerorequest%.request
set endpoint=http://%subdominio%%server%/%virtualdir%/%nombrews%.aspx
set outputfile=.\%server%%version%\%nombrews%%numerorequest%.xml
set wsdlfile=.\%server%%version%\%nombrews%.wsdl
set runlogfile=.\%server%%version%\run.txt

rem if not exist %filename% (echo http://localhost/LUCIAx_v105ProtDotNet/%nombrews%.aspx?wsdl && pause)
if not exist %filename% (echo *** ERROR : No existe archivo %filename% && echo "vacio" > %filename%.VACIO && pause) 

rem call :DEBUG

@echo %endpoint%

rem Request para generar log y ver el http_code de la llamada
utiles\curl -o /dev/null -s  --insecure --user %user%  %endpoint% -w "%%{http_code} - %endpoint%\n" >> %runlogfile%
rem Request para generar el WSDL
utiles\curl -s --insecure --user %user%  %endpoint%?wsdl >  %wsdlfile%
rem Request para ejecutar el SOAP con parametros
utiles\curl -s --insecure --user %user% --header "Content-Type: text/xml;charset=UTF-8" --header "SOAPAction: %soapaction%" --data @%filename% --output %outputfile% %endpoint% 

exit /b


:DEBUG
echo :::::::::::::::::::::::::::::::::::::::::::::::
echo virtualdir=%virtualdir%
echo subdominio=%subdominio%
echo nombrews=%nombrews%
echo soapaction=%soapaction%
echo numerorequest=%numerorequest%
echo filename=%filename%
echo endpoint=%endpoint% 
echo server=%server%
echo user=%user%
echo outputfile=%outputfile%
echo runlogfile=%runlogfile%
echo wsdlfile=%wsdlfile%
echo :::::::::::::::::::::::::::::::::::::::::::::::
pause
exit /b