# PROYECTO ELECTRÓNICA DIGITAL 2 - 2022-2: Grabadora inteligente de habitos de conducción
Integrantes
* Javier Leonardo Suarez Pedraza
* Laura María Ruiz Vallejo

El dispositivo propuesto busca recolectar la información necesaria para calificar los hábitos de conducción durante un viaje. Para poder cumplir tal proposito, se utilizará una cámara de vídeo, una memoria micro SD y el acelerómetro incluido en la tarjeta Nexys A7. Los datos recolectados por la cámara y el acelerómetro serán almacenados en la memoria SD.

## Procesador

## Periféricos

### Cámara
Para el proyecto se utilizó el módulo de cámara OV7670. Los diferentes formatos que ofrece este módulo se pueden configurar por medio de interfaz SCCB (Serial Camera Control Bus). Este dispositivo puede dar una resolución de 640x480 pixeles, lo que implica que para una imagen se necesitan 600 KBytes para su almacenamiento. Sin embargo, la tarjeta Nexys A7 tiene una memoria de 4860 Kbits. El procesador se gasta aproximadamente la mitad de esta memoria, por lo tanto se requiere reducir el tamaño de la imagen; el tamaño que se escogió fue de 240x320 pixeles que reducirá a 1200 Kbits por imagen.

La configuración del módulo se realizó con un Arduino UNO, a través del archivo `archivo confi`.

Para el driver de la cámara se implementaron tres bloques: "Pixel Counter", "Control" y "Memory". En ls siguiente imagen se muestra el bloque completo del driver de la cámara.

![Image text](https://github.com/zzuljs/CppLearning/blob/master/CppLearning/raw/master/Itachi.jpg)

### Memoria SD

### Acelerómetro


