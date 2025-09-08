#!/bin/bash

# Use Kind control-plane IP instead of EC2
ipv4_address=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kind-control-plane)

# Path to the frontend .env file
file_to_find="../frontend/.env.docker"

# Ensure file exists
if [ ! -f $file_to_find ]; then
  echo "ERROR: $file_to_find not found"
  exit 1
fi

# Update VITE_API_PATH inside frontend env
sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${ipv4_address}:31100\"|g" $file_to_find
echo "✅ Frontend .env updated with VITE_API_PATH=http://${ipv4_address}:31100"
