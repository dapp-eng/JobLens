FROM python:3.11-slim
RUN useradd -m -u 1000 user
USER user
ENV PATH="/home/user/.local/bin:$PATH"

WORKDIR /app

COPY --chown=user:user dashboard/ /app/dashboard/

WORKDIR /app/dashboard

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p data/processed

EXPOSE 7860

CMD ["gunicorn", "app:app", "--workers", "1", "--threads", "4", "--bind", "0.0.0.0:7860", "--timeout", "180"]