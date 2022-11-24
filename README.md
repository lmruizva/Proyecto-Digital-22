# PROYECTO ELECTRÓNICA DIGITAL 2 - 2022-2: Grabadora inteligente de habitos de conducción
Integrantes
* Javier Leonardo Suarez Pedraza
* Laura María Ruiz Vallejo

El dispositivo propuesto busca recolectar la información necesaria para calificar los hábitos de conducción durante un viaje. Para poder cumplir tal proposito, se utilizará una cámara de vídeo, una memoria micro SD y el acelerómetro incluido en la tarjeta Nexys A7. Los datos recolectados por la cámara y el acelerómetro serán almacenados en la memoria SD.

## Procesador

## Periféricos
En un principio se tenía pensado usar solamente dos cámaras digitales como se muestra en la siguiente imagen. 
![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/eeec2f4df958ab22d49a85660d95b20754356869/imagenes/idea1.png)

Sin embargo es posible utilizar el acelerómetro que viene integrado en la tarjeta, el cual también provee información útil para el propósito del dispositivo. El diagrama siguiente muestra el flujo de la información recolectada en este nuevo planteamiento del proyecto.
![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/eeec2f4df958ab22d49a85660d95b20754356869/imagenes/flujo_datos.png)
Por lo tanto, se observa que se emplearán 3 periféricos. De ellos, solamente la cámara necesita conexiones cableadas, por lo que se va a simplificar el ensamblaje del hardware completo del proyecto. Como tal, dos perifericos requieren especial atención: la cámara y la tarjeta SD.

### Cámara
Para el proyecto se utilizó el módulo de cámara OV7670. Los diferentes formatos que ofrece este módulo se pueden configurar por medio de interfaz SCCB (Serial Camera Control Bus). Este dispositivo puede dar una resolución de 640x480 pixeles, lo que implica que para una imagen se necesitan 600 KBytes para su almacenamiento. Sin embargo, la tarjeta Nexys A7 tiene una memoria de 4860 Kbits. El procesador se gasta aproximadamente la mitad de esta memoria, por lo tanto se requiere reducir el tamaño de la imagen; el tamaño que se escogió fue de 240x320 pixeles que reducirá a 1200 Kbits por imagen.

La configuración del módulo se realizó con un Arduino UNO, a través del archivo `archivo confi`.

Para el driver de la cámara se implementaron tres bloques: "Pixel Counter", "Control" y "Memory". En ls siguiente imagen se muestra el bloque completo del driver de la cámara.

![Image text](https://github.com/lmruizva/Proyecto-Digital-22/blob/0a010979a40a8faf8945ee88bca83bdd4059af30/imagenes/Driver_camara.png)

#### Bloque Control

### Memoria SD
Tiene un protocolo de comunicacion SPI cuya implementacion también se hace desde hardware con la ayuda de verilog. Gracias a un puerto especial que viene con la Nexys A7, entonces se puede insertar la tarjeta SD sin necesidad de cableado o hardware adicional.

### Acelerómetro
La tarjeta Nexys A7 posee el acelerómetro ADXL362, este es un acelerómetro de 3 ejes que tiene un consumo muy bajo lo que significa una gran ventaja al no necesitar consumir tantos recursos de potencia. Otra de las ventajas es que no produce alias de la señal de entrada. Este sensor ofrece una resolución de 12 bits que se puede reducir a 8 bits si es necesario una comunicación más eficiente. El sistema que utiliza para comunicarse con la FPGA es un bus SPI y mientras el sensor está en modo de medición siempre estará midiendo y almacenando los datos captados en los ejes *x, y*  y *z*; éstos serán almacenados en sus respectivos registros.



