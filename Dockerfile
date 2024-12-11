# Use an official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    SOLC_VERSION=0.8.0

# Update and install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install solc-select
RUN pip install solc-select && \
    solc-select install ${SOLC_VERSION} && \
    solc-select use ${SOLC_VERSION}

# Install Slither dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-dev \
    libssl-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Slither
RUN pip install slither-analyzer

# Create a directory for your project inside the container
WORKDIR /app

# Install Python dependencies (optional, depending on requirements.txt)
COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt || true

# Default command for development mode
CMD ["bash"]
