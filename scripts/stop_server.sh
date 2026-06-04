#!/bin/bash
echo "Deteniendo contenedor anterior de la API si existe..."
docker stop netcore-api-container || true
docker rm netcore-api-container || true