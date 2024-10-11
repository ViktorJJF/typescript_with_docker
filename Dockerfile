# Stage 1: Build the application
FROM node:18-alpine AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies using npm ci (faster for CI/CD and clean installs)
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the TypeScript files
RUN npm run build


# Stage 2: Create the production image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy only the necessary files from the build stage
COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Expose the application port (adjust if necessary)
EXPOSE 3000

# Command to run the application
CMD ["npm", "run", "start"]
