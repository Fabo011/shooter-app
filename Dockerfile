# Lightweight container with nginx
FROM nginx:alpine

# Copy the HTML file to nginx
COPY index.html /usr/share/nginx/html/

# Copy minimal nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
