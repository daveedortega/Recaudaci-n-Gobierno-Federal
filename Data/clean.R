library(xlsx)
library(data.table)
#Usando datos SCHCP: http://presto.hacienda.gob.mx/EstoporLayout/Layout.jsp
recaudacion<-read.xlsx('IngresosFinal.xlsx', sheetName = 'Sheet1', header = F)
columnas<-c(2012:2019)
filas<-recaudacion[2:length(recaudacion[,1]),1]

recaudacion<-recaudacion[,-1]
colnames(recaudacion)<-columnas
recaudacion<-t(recaudacion)
recaudacion<-recaudacion[,-1]
colnames(recaudacion)<-filas
recaudacion<-t(recaudacion)

recaudacion<-data.table(recaudacion, keep.rownames = T)

r<-apply(recaudacion[,2:9],c(1,2), as.numeric)
r<-apply(r,c(1,2),function(x){if(is.na(x)==T)x<-0 else x=x})

#final
dtf<-data.table(recaudacion[,1],round(r,3))
dtf[,Porcentaje2012:=NULL]

#sacando porcentajes
c<-copy(dtf[,Porcentaje2012:={round(dtf$'2012'/dtf[[1,2]],4)}])
c[,Porcentaje2013:={round(dtf$'2013'/dtf[[1,3]],4)}]
c[,Porcentaje2014:={round(dtf$'2014'/dtf[[1,4]],4)}]
c[,Porcentaje2015:={round(dtf$'2015'/dtf[[1,5]],4)}]
c[,Porcentaje2016:={round(dtf$'2016'/dtf[[1,6]],4)}]
c[,Porcentaje2017:={round(dtf$'2017'/dtf[[1,7]],4)}]
c[,Porcentaje2018:={round(dtf$'2018'/dtf[[1,8]],4)}]
c[,Porcentaje2019:={round(dtf$'2019'/dtf[[1,9]],4)}]
#final porcentajes
c[,c(as.character(2012:2019)):=NULL]
c
#pi chart total
pic<-copy(c[c(1,2,8,41),])
pic$rn[2]<-'Petroleros'
pic

pie2012<-pic$Porcentaje2012[2:4]
par(mar=c(2, 2, 2, 2),xpd=TRUE)
pie(pie2012, labels=pie2012*100,main = 'Composicion del Ingreso 2012',col = rainbow(length(pie2012)))
legend(0,-0.88, c("Ingresos Petroleros","Ingresos Tributarios","Ingresos No tributarios"),
       cex = 0.8,fill = rainbow(length(pie2012)))

pie2014<-pic$Porcentaje2014[2:4]
par(mar=c(2, 2, 2, 2),xpd=TRUE)
pie(pie2014, labels=pie2014*100,main = 'Composicion del Ingreso 2014',col = rainbow(length(pie2014)))
legend(0,-0.88, c("Ingresos Petroleros","Ingresos Tributarios","Ingresos No tributarios"),
       cex = 0.8,fill = rainbow(length(pie2014)))

pie2016<-pic$Porcentaje2016[2:4]
par(mar=c(2, 2, 2, 2),xpd=TRUE)
pie(pie2016, labels=pie2016*100,main = 'Composicion del Ingreso 2016',col = rainbow(length(pie2016)))
legend(0,-0.88, c("Ingresos Petroleros","Ingresos Tributarios","Ingresos No tributarios"),
       cex = 0.8,fill = rainbow(length(pie2016)))

pie2019<-pic$Porcentaje2019[2:4]
par(mar=c(2, 2, 2, 2),xpd=TRUE)
pie(pie2019, labels=pie2019*100,main = 'Composicion del Ingreso 2019',col = rainbow(length(pie2019)))
legend(0,-0.88, c("Ingresos Petroleros","Ingresos Tributarios","Ingresos No tributarios"),
       cex = 0.8,fill = rainbow(length(pie2019)))


#composición de los ingresos tributarios

imp<-copy(c[c(10,11,12,13,31,34,35,43),])
imp12<-imp$Porcentaje2012
par(mar=c(2, 2, 2, 2),xpd=TRUE)
pie(imp12, labels=imp12*100,main = 'Composicion del Ingreso Tributario 2012',col = rainbow(length(imp12)))
legend(0.3,-0.7, c("ISR","IETU","IDE","IVA","Importaciones","Exportaciones", "Tenencia","Derechos"),
       cex = 0.8,fill = rainbow(length(imp12)))

imp
impt<-t(imp[,2:9])

impti<-data.table(imp$rn,impt)

imp12<-imp[,1:2]
ggplot(data=imp, aes(x=rn, y=Porcentaje2012, fill=rn)) +
        geom_bar(stat="identity")



