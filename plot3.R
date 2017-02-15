# saviosampaio - 20170215-0124
# - plot3.R do course-project-1 de exploratory-data-analysis / coursera

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

# definimos o device PNG, com o nome do arquivo e as dimensoes da imagem
png("plot3.png", width=480, height=480)

# criar o primeiro gráfico, com PLOT e Y LABEL, para subMetering1
plot(datas, subMetering1, type="l", ylab="Energy Submetering", xlab="")

# adicionar uma linha com subMetering2 (vermelho)
lines(datas, subMetering2, type="l", col="red")

# adicionar uma linha com subMetering3 (azul)
lines(datas, subMetering3, type="l", col="blue")

# adicioanr legendas no canto superior direito
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# encerramos o device PNG
dev.off()

