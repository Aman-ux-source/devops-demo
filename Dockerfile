FROM nginx:alpine

# Remove default Nginx HTML
RUN rm -rf /usr/share/nginx/html/*

# Copy all files
COPY . /usr/share/nginx/html/

EXPOSE 80

