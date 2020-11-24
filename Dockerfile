# Set up base image and set working directory
FROM node:alpine
WORKDIR '/app'
# Copy package.json file
COPY package.json .
RUN npm install
# Copy remaining files and execute build
COPY . .
RUN npm run build

# Use new Nginx image
FROM nginx
EXPOSE 80
# Copy build folder from previous docker buils to new directory
COPY --from=0 /app/build /usr/share/nginx/html