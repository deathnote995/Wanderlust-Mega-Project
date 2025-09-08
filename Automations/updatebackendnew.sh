#!/bin/bash

# Use Kind control-plane IP instead of EC2
ipv4_address=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kind-control-plane)

# Path to the backend .env file
file_to_find="../backend/.env.docker"

# Ensure file exists
if [ ! -f $file_to_find ]; then
  echo "ERROR: $file_to_find not found"
  exit 1
fi

# Update FRONTEND_URL inside backend env
sed -i -e "s|FRONTEND_URL.*|FRONTEND_URL=\"http://${ipv4_address}:5173\"|g" $file_to_find
echo "✅ Backend .env updated with FRONTEND_URL=http://${ipv4_address}:5173"
