# Dockerfile for Frontend (React)
# FROM node:16

# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# RUN npm install web-vitals
# COPY . .
# RUN npm run build

# # Serve the app using serve
# RUN npm install -g serve

# EXPOSE 3000
# CMD ["serve", "-s", "build", "-l", "3000"]

# Multistage dockerfile
# Stage 1: Build the React app
FROM node:16 as build

WORKDIR /app
COPY package*.json ./
RUN npm install
RUN npm install web-vitals
COPY . .
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Remove default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy React build files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
