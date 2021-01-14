## Suavizamiento Holt-Winters

# El metodo de Holt-Winters generaliza el metodo de suavizamiento exponencial
# El objetivo del Holt-Winters es suavizar la serie para pronosticar. Es un metodo no parametrico
# El problema de este modelo es porque no puedes sacar intervalos de confianza 
# El suavimzamiento de Holt-Winters esta compuesto por tres componentes: alfa, beta y gamma

# Cargamos las libreias

library(tidyverse)
library(forecast)
library(ggthemes)
library(TSstudio)
# Cargamos el documento

datos <- read_csv(file.choose())

# Limpiamos la base de datos
datos <- datos %>%
          select("Crudo Oriente", "Crudo Napo", "Crudo WTI") %>%
          na.omit()

# Creamos series de tiempo

ts_oriente <- ts(datos$`Crudo Oriente`, start = c(2010, 1), frequency = 12)
ts_napo <- ts(datos$`Crudo Napo`, start = c(2010, 1), frequency = 12)
ts_wti <- ts(datos$`Crudo WTI`, start = c(2010, 1), frequency = 12)

# Descomposicion de las series

decompose(ts_oriente)
autoplot(decompose(ts_oriente))

# Graficamos si la serie tiene comportamiento estacional
ggseasonplot(ts_oriente) +
  labs(title = "Seasonal Oriente Oil Price",
       subtitle = "In USD per barrel",
       y = "USD per Barrel")+
  theme_fivethirtyeight()

# Graficamos la serie si es estacional con la libreria TSstudio
ts_seasonal(ts_oriente,type = "box")

decompose(ts_napo)
autoplot(decompose(ts_napo))
ggseasonplot(ts_napo) +
  labs(title = "Seasonal Napo Oil Price",
       subtitle = "In USD per barrel",
       y = "USD per Barrel")+
  theme_fivethirtyeight()

decompose(ts_wti)
autoplot(decompose(ts_wti))
ggseasonplot(ts_wti) +
  labs(title = "Seasonal WTI Oil Price",
       subtitle = "In USD per barrel",
       y = "USD per Barrel")+
  theme_fivethirtyeight()

# Modelamiento Holt-Winters sin parametros

hw_oriente <- HoltWinters(ts_oriente, seasonal = "additive")
plot(hw_oriente)

hw_napo <- HoltWinters(ts_napo, seasonal = "additive")
plot(hw_napo)

hw_wti <- HoltWinters(ts_wti, seasonal = "additive")
plot(hw_wti)

# Para realizar predicciones

oriente_forecast <- forecast(hw_oriente, h = 6)
oriente_forecast
summary(oriente_forecast)
autoplot(oriente_forecast, ylab = "Precio barril") + 
  labs(subtitle = "Barril Oriente en USD",
       caption = "Data source: BCE")
autoplot(oriente_forecast$residuals, ylab = "Residuals") +
  labs(title = "Residuals from Oriente",
       caption = "Data Source: BCE")

napo_forecast<- forecast(hw_napo, h = 6)
napo_forecast
summary(napo_forecast)
autoplot(napo_forecast, ylab = "Precio barril") + 
  labs(subtitle = "Barril Napo en USD",
       caption = "Data source: BCE")
autoplot(napo_forecast$residuals, ylab = "Residuals") +
  labs(title = "Residuals from Napo",
       caption = "Data Source: BCE")

wti_forecast <- forecast(hw_wti, h = 6)
wti_forecast
summary(wti_forecast)
autoplot(wti_forecast, ylab = "Precio barril") + 
  labs(subtitle = "Barril WTI en USD",
       caption = "Data source: BCE")
autoplot(wti_forecast$residuals, ylab = "Residuals") +
  labs(title = "Residuals from WTI",
       caption = "Data Source: BCE")

# Modelamiento Holt-Winters con parametros

oriente <- HoltWinters(ts_oriente, alpha = 0.910317658, 
                       beta = 0.144444714, gamma = 1)
plot(oriente) 

napo <- HoltWinters(ts_napo, alpha = 0.907018985, 
                       beta = 0.1108539, gamma = 1)
plot(napo) 

wti <- HoltWinters(ts_wti, alpha = 1, 
                    beta = 0.140342658, gamma = 0.025567313)
plot(wti) 

# Para realizar predicciones

oriente_forecast_param <- forecast(oriente, h = 6)
oriente_forecast_param
summary(oriente_forecast_param)
autoplot(oriente_forecast_param, ylab = "Precio barril") + 
  labs(subtitle = "Barril Oriente en USD",
       caption = "Data source: BCE")
autoplot(oriente_forecast_param$residuals, ylab = "Residuals") +
  labs(title = "Residuals from Oriente",
       caption = "Data Source: BCE")

napo_forecast_param <- forecast(napo, h = 6)
napo_forecast_param
summary(napo_forecast_param)
autoplot(napo_forecast_param, ylab = "Precio barril") + 
  labs(subtitle = "Barril Napo en USD",
       caption = "Data source: BCE")
autoplot(napo_forecast_param$residuals, ylab = "Residuals") +
  labs(title = "Residuals from Napo",
       caption = "Data Source: BCE")

wti_forecast_param <- forecast(wti, h = 6)
wti_forecast_param 
summary(wti_forecast_param )
autoplot(wti_forecast_param , ylab = "Precio barril") + 
  labs(subtitle = "Barril WTI en USD",
       caption = "Data source: BCE")
autoplot(wti_forecast_param $residuals, ylab = "Residuals") +
  labs(title = "Residuals from Napo",
       caption = "Data Source: BCE")

# Comparacion de los errores

oriente$SSE
hw_oriente$SSE


