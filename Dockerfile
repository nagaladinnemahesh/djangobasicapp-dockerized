# === Stage 1: Build Stage ===
FROM python:3.8 AS build-stage

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt /app/

# Install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files to the container
COPY . /app/

# === Stage 2: Production Stage ===
FROM gcr.io/distroless/python3 AS production-stage

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Copy only necessary files from the build stage
COPY --from=build-stage /app /app

# Expose the port that the app will run on
EXPOSE 8000

# Command to run the application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

