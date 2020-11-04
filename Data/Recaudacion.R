#Ingresos Totales de la federación 2012-2020 por Mes, Banxico
#https://www.banxico.org.mx/SieInternet/consultarDirectorioInternetAction.do?sector=9&accion=consultarCuadro&idCuadro=CG2&locale=es

library(xlsx)
rec_total<-read.xlsx('IngresosTot12_20.xlsx',header = F, startRow = 36, endRow = 59,sheetName = 'Hoja1')
dim(rec_total)
times<-read.xlsx('IngresosTot12_20.xlsx',header = F, startRow = 9, endRow = 9,sheetName = 'Hoja1')
dim(times)
#setting times to be column names then transposing
colnames(rec_total) <- times[1,]
rec_total<-t(rec_total)

#setting variables to be column names then erasing
colnames(rec_total)<-rec_total[1,]
rec_total <- rec_total[-1,]

View(rec_total)
dim(rec_total)

#Ingresos totales recadación por Estado 2004-2019, Anual, Transparencia presupuestaria
#https://www.transparenciapresupuestaria.gob.mx/es/PTP/EntidadesFederativas
library(data.table)
rec_estat<-read.csv('total_recaudacion.csv',header=T)
rec_estat<-data.table(rec_estat)
listarecestat<-split(rec_estat,rec_estat$CICLO)
length(listarecestat)
View(rec_estat)

estatal_2013<-listarecestat[[10]]
View(estatal_2013)
estatal_2019<-listarecestat[[16]]

