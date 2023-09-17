# Etapa 1: Use a imagem oficial do Go para compilar
FROM golang:alpine AS build

# Copie o código fonte para o diretório de trabalho dentro do contêiner
COPY main.go /app/main.go

# Compile o código Go com flags para produção
RUN go build -ldflags "-w -s" -o /app/app /app/main.go

# Etapa 2: Crie uma imagem mínima a partir da imagem Alpine
FROM scratch

# Copie o executável compilado da etapa anterior para a imagem final
COPY --from=build /app/app /app/app

# Execute o aplicativo quando o contêiner for iniciado
CMD ["/app/app"]
