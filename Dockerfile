FROM node:24-alpine

# Creatw a new folder for working directory in the container
RUN mkdir -p /usr/app

# Copy app data into container
COPY app/ /usr/app/

# Set working directory inside container
WORKDIR /usr/app

# Expose application port
EXPOSE 3000

RUN npm install

# Run the application
CMD ["node", "server.js"]