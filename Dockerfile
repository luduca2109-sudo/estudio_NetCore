# Etapa 1: Compilación (Usa el SDK pesado de .NET)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar la solución y los archivos de proyecto (.csproj) para restaurar dependencias
COPY *.sln ./
COPY NetCoreAPI/*.csproj ./NetCoreAPI/
COPY NetCoreAPI.Tests/*.csproj ./NetCoreAPI.Tests/
RUN dotnet restore

# Copiar todo el resto del código y compilar la API en modo Release
COPY . ./
RUN dotnet publish NetCoreAPI/NetCoreAPI.csproj -c Release -o /out --no-restore

# Etapa 2: Producción (Usa una imagen ultra ligera que solo corre la API ya compilada)
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /out .

# Exponer el puerto en el que correrá tu API en AWS
EXPOSE 80
EXPOSE 443

# Comando para arrancar tu microservicio
ENTRYPOINT ["dotnet", "NetCoreAPI.dll"]