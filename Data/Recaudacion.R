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
View(estatal_2019)


#plotting total income 
dates<-seq(as.Date("2012/1/1"), by = "month", length.out = length(rec_total[,1]))
ingresototal<-as.numeric(rec_total[,1])
ingresoiva<-as.numeric(rec_total[,7])
ingresoisr<-as.numeric(rec_total[,3])
hidrocarburos<-as.numeric(rec_total[,20])
derechos<-as.numeric(rec_total[,19])
#Recaudación es acumulada
df<-data.table(Meses=dates, Recaudacion_Total=ingresototal,IVA=ingresoiva,ISR=ingresoisr,
               Hidrocarburos=hidrocarburos, Derechos=derechos)
#Recogiendo la recaudación total de los años
df_rectotal<-subset(df, format.Date(Meses, "%m")=="12")



library(ggplot2)
# Basic line plot with points
p_rectot<-ggplot(data=df_rectotal, aes(x=Meses, y=Recaudacion, group=1)) +
        geom_line()+
        geom_point()

p_rectot + ggtitle("Recaudación Anual Total") +
        xlab("Años") + ylab("Recaudación, MDP")

