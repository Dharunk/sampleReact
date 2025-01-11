# # Step 1: Use official Node.js image
# FROM node:16 AS build

# # Step 2: Set the working directory
# WORKDIR /app

# # Step 3: Copy package.json and package-lock.json
# COPY package*.json ./

# # Step 4: Install dependencies
# RUN npm install

# # Step : Install missing web-vitals package
# RUN npm install web-vitals

# # Step 5: Copy the rest of the app
# COPY . .

# # Step 6: Build the React app for production
# RUN npm run build

# # Step 7: Serve the build using a lightweight server
# FROM nginx:alpine

# # Step 8: Copy the build files from the build stage
# COPY --from=build /app/build /usr/share/nginx/html

# # Step 9: Expose the port the app will run on
# EXPOSE 80

# # Step 10: Start nginx server
# CMD ["nginx", "-g", "daemon off;"]

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
