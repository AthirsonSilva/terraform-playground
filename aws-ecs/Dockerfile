# Use the official Nginx base image
FROM nginx

# Copy custom configuration file to the container
COPY ./scripts/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]