# Etapa 1: Compilación (Usa el SDK pesado de .NET)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar la solución y los archivos de proyecto (.csproj) para restaurar dependencias
COPY *.sln ./

# Origen (Mayúsculas Reales de Git) -> Destino (Minúsculas para el .sln)
COPY NetCoreAPI/*.csproj ./NetcoreApi/
COPY NetCoreAPI.Tests/*.csproj ./NetcoreApi.Tests/
RUN dotnet restore

# CORRECCIÓN AQUÍ:
# Origen (Mayúsculas Reales de Git) -> Destino (Minúsculas para el .sln)
COPY NetCoreAPI/. ./NetcoreApi/
COPY NetCoreAPI.Tests/. ./NetcoreApi.Tests/

# Compilar y publicar la API en modo Release apuntando a la ruta corregida
RUN dotnet publish NetcoreApi/NetCoreAPI.csproj -c Release -o /out --no-restore

# Etapa 2: Producción
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /out .

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "NetCoreAPI.dll"]