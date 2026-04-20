FROM python:3.11-slim

# Create non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

WORKDIR /app

# Copy dependencies first (better layer caching)
# If requirements.txt hasn't changed, this layer is cached
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code after dependencies
COPY . .

# Switch to non-root user
USER appuser

EXPOSE 80

CMD ["python", "app.py"]

