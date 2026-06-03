# Etapa 1: Compilación (Usa el SDK pesado de .NET)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar la solución y los archivos de proyecto (.csproj) para restaurar dependencias
COPY *.sln ./
# CORRECCIÓN: Destinos en minúsculas para alinearse con el archivo .sln internamente
COPY NetCoreApi/*.csproj ./NetcoreApi/
COPY NetCoreApi.Tests/*.csproj ./NetcoreApi.Tests/
RUN dotnet restore

# Copiar todo el resto del código a las carpetas correspondientes
COPY NetCoreApi/. ./NetcoreApi/
COPY NetCoreApi.Tests/. ./NetcoreApi.Tests/

# Compilar y publicar la API en modo Release apuntando a la ruta corregida
RUN dotnet publish NetcoreApi/NetCoreAPI.csproj -c Release -o /out --no-restore

# Etapa 2: Producción (Usa una imagen ultra ligera que solo corre la API ya compilada)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /out .

# Exponer el puerto en el que correrá tu API en AWS
EXPOSE 80
EXPOSE 443

# Comando para arrancar tu microservicio
ENTRYPOINT ["dotnet", "NetCoreAPI.dll"]