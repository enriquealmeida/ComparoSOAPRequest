# ComparoSOAPRequest
 Compara request en GX16 y Evo3
 
Herramienta que permite ejecutar request SOAP generados para GXevo3 en una KB GX16 y comparar las diferencias. 

Genera los WSDL de los servicios
Genera un Response de salida (xml)
Transforma el response de salida en un txt para que sea mas facil de comparar. 

Prerequisitos
=============
Instalar WinMerge   http://winmerge.org/downloads/
Instalar curl      https://curl.haxx.se/download.html

Ambos deben estar en path.

Instalacion.
============

Crear KB en Evo3 e importar el WSEvo3.xpz (Ponerle WebRoot http://localhost/WS.NetEnvironment/)
Crear KB en GX16 e importar el WSGx16.xpz (Ponerle WebRoot http://localhost/WSgx16.NetEnvironment/)

Ambas KB tendran Use SOAP nativo = NO y usan el generador C#.  
El namespace de la KB es el mismo y fijo en ambas KB. 

En el directorio REQUESTS hay un archivo request.ini que tiene la listas de request a realizar. 
En el mismo se tienen el nombre del objeto generado, el soapaction y un numero de request (para poder tener mas de un request por objeto y guardar el log). 

Revisar el archivo ComparoSOAPRequests.cmd y cambiar si se necesita algo. 

Ejecutar el ComparoSOAPRequest.cmd y va a dejar en (por ejemplo)

localhostevo3
localhostgx16 

y va a comparar las diferencias con WinMerge. 

El nombre de los objetos, tiene cierta aproximacion con los problemas planteados en la planilla, pero no tiene una correspondencia absoluta. 
