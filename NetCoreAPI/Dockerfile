# Etapa 1: Compilación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar csproj y restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar todo lo demás y compilar
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa 2: Entorno de ejecución (Ligero)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Exponer el puerto interno de la API
EXPOSE 8080
ENTRYPOINT ["dotnet", "NetCoreAPI.dll"]