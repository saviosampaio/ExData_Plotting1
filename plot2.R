# saviosampaio - 20170215-0052
# - plot2.R do course-project-1 de exploratory-data-analysis / coursera

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

# definimos o device PNG, com o nome do arquivo e as dimensoes da imagem
png("plot2.png", width=480, height=480)

# desenhamos o grafico do tipo HIST, na cor vermelha, com um titulo e um X LABEL
hist(as.numeric(analisar$Global_active_power), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# criar um vetor de "tempo" (YYYY-MM-DD hh:mm:ss), com a juncao das colunas Date e Time, que estao no formato "%d/%m/%Y %H:%M:%S"
datas <- strptime(paste(analisar$Date, analisar$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# em portugues, os dias da semana sairam: qui sex sab
# - para ficar em ingles (Thu, Fri, Sat), devemos usar o comando abaixo
Sys.setlocale("LC_ALL", "English")
# - para retornar ao Portugues do Brasil, usamos o seguinte comando
# Sys.setlocale("LC_ALL", "Portuguese_Brazil")

# imprimir o grafico PLOT, com a evolucao dos valores de Global_active_power no decorrer do tempo (datas)
plot(datetime, as.numeric(analisar$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)") 

# encerramos o device PNG
dev.off()

