# Use the official R base image
FROM rocker/r-ver:latest

# Install plumber package
RUN install2.r plumber

# Set the working directory
WORKDIR /usr/src/api

# Copy the API files from your local machine to the container
COPY plumber.R .

# Expose the port on which the API will run
EXPOSE 8080

# Command to run the API using plumber
CMD ["R", "-e", "plumber::plumb('plumber.R')$run(host='0.0.0.0', port=3838)"]
