# Use Debian 12 base image
FROM debian:12

# Install required packages
RUN apt update && apt install -y \
    python3 \
    python3-pip \
    apt-utils \
    apt-show-versions \
    curl \
    gnupg \
    && apt clean

# Set working directory inside container
WORKDIR /app

# Copy project files into container
COPY . /app

# Run script on container start
CMD ["python3", "aptworld.py"]


##Steps to run
## Build the Docker Image
## Step 1
# docker build -t aptworld .

#step 2 Run the Docker container
## docker run --rm -v "$PWD:/app" aptworld

##Step 3 Check output
#cat listofpackages.json

