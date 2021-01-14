# Precio-Petroleo
---
title: "Pronóstico del Precio del Petróleo Oriente y WTI"
author: "Ramiro Mosquera"
date: "13 January 2021"
output:
  html_document:
    keep_md: yes
  pdf_document: default
---






## Método Holt-Winters

### Introducción
El método de Holt-Winters es técnica de suavizamiento de series de tiempo que produce pronósticos para series de tiempo que poseen tendencia y estacionalidad. 
Es un método antiguo, pero aún tiene sigue siendo utilizado porque es sencillo de modelar y que porte permite realizar pronósticos recurrir modelos más complejos.

El propósito de este artículo es hacer un comparativo entre el pronóstico que realiza el métido de Holt-Winters estimado los parámetros $\alpha$, $\beta$ y $\gamma$ y el pronóstico que realiza la función Holt-Winters de la librería `forecast`.

Nota: Realizar pronósticos de series de tiempo no es una tarea trivial y requiere de mucho tiempo. Sin embargo este modelamiento es bastante útil cuando el tiempo apremia y se requiere tener una noción básica de los pronósticos.

## Precio del barril de petróleo ecuatoriano
El precio del barril de petróleo es uno de los indicadores más importantes para la economía ecuatoriana porque es la principal fuente de divisas para el país y porque su precio es el que determina la estimación para el presupuesto general del Estado.

La serie `ts_oriente` contiene los precios del barril de crudo Oriente dólares estadounidenses desde enero de 2010 hasta octubre de 2020. La serie `ts_wti` contiene los precios del barril marcador West Texas Intermediate (WTI) desde enero de 2010 hasta octubre de 2020.

Los datos fueron obtenidos de Informe Estadístico Mensual del Banco Central del Ecuador.

A continuación graficamos 





<img src="Pronóstico-del-Precio-del-Petróleo_files/figure-html/grafica descomposicion de la serie-1.png" style="display: block; margin: auto;" />

A través de la gráfica podermos determinar que la serie es aditiva debido a que las variaciones del componente estacional son constantes en el tiempo. Para corroborar que la serie es aditiva se puede corroborar empleando la función `decompose()`. 


```r
decompose(ts_oriente)$type
```

```
## [1] "additive"
```

## Modelamiento Holt-Winters con parametros
Para esa sección 

oriente <- HoltWinters(ts_oriente, alpha = 0.910317658, 
                       beta = 0.144444714, gamma = 1)

