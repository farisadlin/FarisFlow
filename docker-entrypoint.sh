#!/bin/sh

# Use Railway's PORT or default to 80
PORT=${PORT:-80}

echo "Configuring nginx to listen on port $PORT..."

# Update nginx configuration to use the correct port
sed -i "s/listen 80;/listen $PORT;/" /etc/nginx/http.d/default.conf

# Start Node.js backend if server storage is enabled
if [ "$ENABLE_SERVER_STORAGE" = "true" ]; then
    echo "Starting FossFLOW backend server..."
    cd /app/packages/fossflow-backend
    npm install --production
    node server.js &
    echo "Backend server started on port 3001"
else
    echo "Server storage disabled, backend not started"
fi

# Start nginx
echo "Starting nginx on port $PORT..."
nginx -g "daemon off;"