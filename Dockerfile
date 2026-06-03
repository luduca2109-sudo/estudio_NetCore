# Etapa 1: Compilación (Usa el SDK pesado de .NET)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar la solución
COPY *.sln ./

# Sincronización exacta con las entrañas del .sln:
# La API se busca en MAYÚSCULAS, los Tests se buscan en minúsculas
COPY NetCoreAPI/*.csproj ./NetCoreAPI/
COPY NetCoreAPI.Tests/*.csproj ./NetCoreAPI.Tests/
RUN dotnet restore

# Copiar el resto del código respetando el mismo patrón
COPY NetCoreAPI/. ./NetCoreAPI/
COPY NetCoreAPI.Tests/. ./NetCoreAPI.Tests/

# Compilar y publicar la API usando la ruta en MAYÚSCULAS
RUN dotnet publish NetCoreAPI/NetCoreAPI.csproj -c Release -o /out --no-restore

# Etapa 2: Producción
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /out .

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["dotnet", "NetCoreAPI.dll"]