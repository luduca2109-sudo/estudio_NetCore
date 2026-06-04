#!/bin/bash
echo "Conectando Docker a Amazon ECR..."
AWS_ACCOUNT_ID="469039262667"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com

echo "Descargando la última versión de la imagen desde ECR..."
docker pull ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/netcoreapi-repo:latest

echo "Iniciando el contenedor de la API en el puerto 5000..."
docker run -d --name netcore-api-container -p 5000:80 ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/netcoreapi-repo:latest