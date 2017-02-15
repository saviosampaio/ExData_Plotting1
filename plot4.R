# saviosampaio - 20170215-0132
# - plot4.R do course-project-1 de exploratory-data-analysis / coursera

# em portugues, os dias da semana sao escritos como: qui sex sab
# - para ficar em ingles (Thu, Fri, Sat), devemos usar o comando abaixo
Sys.setlocale("LC_ALL", "English")
# - para retornar ao Portugues do Brasil, usamos o seguinte comando
# Sys.setlocale("LC_ALL", "Portuguese_Brazil")

# aqui fiz uma melhoria, para realizar o download dos dados direto da fonte
# - salvei uma copia desse arquivo ZIP dentro do diretorio raiz desse course-project-1
#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(url, "household_power_consumption.zip")

# usei a funcao unz para tratar os dados compactados e facilitar o seu compartilhamento e a reproducao desse grafico
# o comando abaixo vai extrair o arquivo e importa-lo para a tabela "dados", usando informacoes como o separador ";"
dados <- read.table(unz("household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# podemos "filtrar" as linhas (rows) de varias maneiras
#analisar <- dados[dados$Date %in% c("1/2/2007","2/2/2007") ,]
analisar <- subset(dados, Date %in% c("1/2/2007","2/2/2007"))

# criar um vetor de "tempo" (YYYY-MM-DD hh:mm:ss), com a juncao das colunas Date e Time, que estao no formato "%d/%m/%Y %H:%M:%S"
datas <- strptime(paste(analisar$Date, analisar$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# criar 3 vetores para as colunas que queremos desenhar com evolução no tempo: subMetering1 subMetering2 subMetering3
subMetering1 <- as.numeric(analisar$Sub_metering_1)
subMetering2 <- as.numeric(analisar$Sub_metering_2)
subMetering3 <- as.numeric(analisar$Sub_metering_3)

# criar vetores para serem usados em outros graficos
globalActivePower <- as.numeric(analisar$Global_active_power)
globalReactivePower <- as.numeric(analisar$Global_reactive_power)
voltage <- as.numeric(analisar$Voltage)

# definimos o device PNG, com o nome do arquivo e as dimensoes da imagem
png("plot4.png", width=480, height=480)

# configurar o grafico como uma tela 2 x 2
par(mfrow = c(2, 2))

# ATENCAO: O tamanho das fontes teve uma aparencia bem diferente entre os Devices "screen" e "png"
# - No PNG as letras ficaram menores do que no SCREEN
# - Na tela, usei .75 para eixos e labels, e .77 para a legenda do canto superior direito
# - No PNG, tive que usar

# imprimir primeiro grafico, de globalActivePower x Time
# - importante observar que o grafico da tarefa esta com as fontes pequenas (cex.axis e cex.lab)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex.axis=.9, cex.lab=.9)

# imprimir segundo grafico, de voltage, com letras pequenas (cex.axis e cex.lab)
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage", cex.axis=.9, cex.lab=.9)

# imprimir terceiro grafico, com letras pequenas, e adicionando mais linhas e legenda
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="", cex.axis=.9, cex.lab=.9)
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
# a fonte dessa legenda eh um pouco maior do que a fonte dos eixos
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n", lty=1, lwd=2, col=c("black", "red", "blue"), cex=.9)

# imprimir quarto grafico, 
# - observe que esse grafico contem uma palavra "datetime" na parte inferior, e que as letras sao pequenas (cex.axis e cex.lab = .75)
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power", cex.axis=.9, cex.lab=.9)

# encerramos o device PNG
dev.off()
