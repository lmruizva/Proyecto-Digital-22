# PROYECTO ELECTRÓNICA DIGITAL 2 - 2022-2: Grabadora inteligente de habitos de conducción
Integrantes
* Javier Leonardo Suarez Pedraza
* Laura María Ruiz Vallejo

El dispositivo propuesto busca recolectar la información necesaria para calificar los hábitos de conducción durante un viaje. Para poder cumplir tal proposito, se utilizará una cámara de vídeo, una memoria micro SD y el acelerómetro incluido en la tarjeta Nexys A7. Los datos recolectados por la cámara y el acelerómetro serán almacenados en la memoria SD.


## Periféricos
En un principio se tenía pensado usar solamente dos cámaras digitales como se muestra en la siguiente imagen. 

![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/eeec2f4df958ab22d49a85660d95b20754356869/imagenes/idea1.png)

Sin embargo es posible utilizar el acelerómetro que viene integrado en la tarjeta, el cual también provee información útil para el propósito del dispositivo. El diagrama siguiente muestra el flujo de la información recolectada en este nuevo planteamiento del proyecto.

![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/eeec2f4df958ab22d49a85660d95b20754356869/imagenes/flujo_datos.png)

Por lo tanto, se observa que se emplearán 3 periféricos. De ellos, solamente la cámara necesita conexiones cableadas, por lo que se va a simplificar el ensamblaje del hardware completo del proyecto. Como tal, dos perifericos requieren especial atención: la cámara y la tarjeta SD.

### Cámara
Para el proyecto se utilizó el módulo de cámara OV7670. Los diferentes formatos que ofrece este módulo se pueden configurar por medio de interfaz SCCB (Serial Camera Control Bus). Este dispositivo puede dar una resolución de 640x480 pixeles, lo que implica que para una imagen se necesitan 600 KBytes para su almacenamiento. Sin embargo, la tarjeta Nexys A7 tiene una memoria de 4860 Kbits. El procesador se gasta aproximadamente la mitad de esta memoria, por lo tanto se requiere reducir el tamaño de la imagen; el tamaño que se escogió fue de 240x320 pixeles que reducirá a 1200 Kbits por imagen.

Para el driver de la cámara se implementaron tres bloques: "Pixel Counter", "Control" y "Memory". En ls siguiente imagen se muestra el bloque completo del driver de la cámara.

![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/2f50caa55661111a0cf234ccee30a453a028e99a/imagenes/Driver_camara.png)

#### Bloque Control
El bloque de control tiene como función, como lo dice su nombre, controlar la toma de imagen. Sus señales de entrada *PCLOCK, HREF, VSYNC* y *TAKE PHOTO* son las señales necesarias para empezar a capturar la imagen. Como salida está la señal *PHOTO READY* que indica que la imagen está lista. Para hacer el bloque de control se planteó una máquina de estados que se muestra a continuación. Las demás salidas son 3 señales de control utilizadas en los módulos de Memoria y contador.

![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/2304d7cbd51b4ba39fec8ea204e2ee99e96fb883/imagenes/Maquina_estados.png)


#### Bloque Pixel Counter
El módulo de la cámara que se está usando es el OV7670 y este no indica cuál es el pixel al que pertenece cada dato de la cámara. Por lo tanto, este módulo cuenta cada dos flancos del PixelClock, para saber qué pixel está capturando. En total, cada imagen tiene 76800 pixeles y se ennumeran del 0 al 76799 y esta ennumeración también se usa para que la memoria devuelva el valor de los tres colores correspondientes al pixel.

#### Bloque Memory
Este modulo consiste de dos pilas de datos memorias con 76800 direcciones de 1 byte, en una pila se almacena la primera mitad del pixel, y en la otra la otra mitad del pixel, Si el dato se guarda en una pila o en la otra depende de dos señales de control.


#### Bloque Memory

### Simulaciones y Código verilog
#### Módulo PixelCounter
En un inicio se tenía pensado que pixel counter contara con los flancos de subida de PixelClock, sin embargo cuando se hace el ensamble de los tres módulos para conformar el driver de la cámara, se observa que es más conveniente que se cuenten los flancos de bajada. Esto se observó en la simulación del Driver completo.
![Image Text](https://github.com/lmruizva/Proyecto-Digital-22/blob/300a503f9e7ff7229ef195c4fb588a2b050308e3/imagenes/PixelCounterSimulation.jpeg)

En el código que se muestra a continuación no es la versión final. Se modificó de forma que cuente los flancos de bajada y se salta un flanco de bajada de forma que no aumente.

![Image Text](https://github.com/lmruizva/Proyecto-Digital-22/blob/f91a9e51ceb243570688c5a5a7a32ca7b8b40f1b/imagenes/PixelCounterSimulation.jpeg)

#### Módulo Memory
En la simulación que se muestra a continuación se observa que memory almacena los valores en la dirección que se le pide, sólamente cuando se especificia en cual de las dos pilas se va a guardar el dato, es decir, si se especifica si es de la primera parte del pixel o de la segunda parte. Cuando se intenta acceder a una ubicación a la que no se le ha asignado un dato, entonces la memoria da como dato de salida un dato indeterminado, como es de esperarse.

![Image Text](https://github.com/lmruizva/Proyecto-Digital-22/blob/f91a9e51ceb243570688c5a5a7a32ca7b8b40f1b/imagenes/CameraMemorySimulation.jpeg)

A continuación se muestra el código en verilog de este módulo.

![Image Text](https://github.com/lmruizva/Proyecto-Digital-22/blob/f91a9e51ceb243570688c5a5a7a32ca7b8b40f1b/imagenes/CameraMemoryCode.jpeg)

#### Módulo Control

Al ser el control el encargado de las señales que se utilizan en los submodulos, entonces su desarrollo fue el último. En un principio se pensaba en asignarle la tarea de desactivar y activar el contador para que contara cada dos flancos, pero por conveniencia, en el ensamble de todo el driver se vió que lo mejor era que no se encargara de esta función.

![Image Text](https://github.com/lmruizva/Proyecto-Digital-22/blob/036f712657e55ff04af80e3449c427ddcfa6a77f/imagenes/ControlSimulation.jpeg)

El códio empleado para su implementación fue el siguiente.

![Image Text](https://github.com/lmruizva/Proyecto-Digital-22/blob/036f712657e55ff04af80e3449c427ddcfa6a77f/imagenes/ControlCode.jpeg)

#### Driver Completo

En la simulación del driver completó se encontraron algunos errores en el diseño de los submodulos que se comportaban como fueron diseñados, pero que al juntarlos algunos flancos cambian en momoentos críticos del PixelClock, por lo que tuvieron que cambiarse. Uno de estos cambios es que el contador aumentara con los flancos de bajada del PixelClock. Y el otro cambio fue que la memoria sólamente modificara su valor con el flanco de subida del PixelClock. A continuación se muestra una simulación final de todos los módulos con las modificaciones respectivas.

![Image Text](https://github.com/lmruizva/Proyecto-Digital-22/blob/036f712657e55ff04af80e3449c427ddcfa6a77f/imagenes/DriverSimulation.jpeg)
El código final del ensamble del driver se muestra a continuación.
![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/64794a9888e1559f843c4f5c30fd4fb2d4ed2feb/imagenes/Screenshot%20from%202022-11-24%2011-54-29.png)


### Memoria SD
Tiene un protocolo de comunicacion SPI cuya implementacion también se hace desde hardware con la ayuda de verilog. Gracias a un puerto especial que viene con la Nexys A7, entonces se puede insertar la tarjeta SD sin necesidad de cableado o hardware adicional.

### Acelerómetro
La tarjeta Nexys A7 posee el acelerómetro ADXL362, este es un acelerómetro de 3 ejes que tiene un consumo muy bajo lo que significa una gran ventaja al no necesitar consumir tantos recursos de potencia. Otra de las ventajas es que no produce alias de la señal de entrada. Este sensor ofrece una resolución de 12 bits que se puede reducir a 8 bits si es necesario una comunicación más eficiente. El sistema que utiliza para comunicarse con la FPGA es un bus SPI y mientras el sensor está en modo de medición siempre estará midiendo y almacenando los datos captados en los ejes *x, y*  y *z*; éstos serán almacenados en sus respectivos registros.



