# Stage 1: Build the React app
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm cache clean --force && npm install -g npm@latest

COPY . .

RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy the build files from the first stage
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 909

CMD ["nginx", "-g", "daemon off;"]
