FROM alpine:3.14

# Install Bash
RUN apk add --no-cache bash

# Create a data directory for the volume
RUN mkdir -p /usr/local/src/app/

# Define the volume
COPY . /usr/local/src/app
WORKDIR /usr/local/src/app

# Set the default command to run Bash
CMD ["bash"]
