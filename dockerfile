# Use uma imagem base leve e oficial do Python
FROM python:3.12-slim

# Define variáveis de ambiente para otimização
ENV PYTHONUNBUFFERED=1 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_NO_INTERACTION=1

# Adicione o Poetry ao PATH
ENV PATH="$POETRY_HOME/bin:$PATH"

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Instala dependências do sistema operacional necessárias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    libopenblas-dev \
    libomp-dev \
    python3-dev \
    libffi-dev \
    libssl-dev \
    libcurl4-openssl-dev \    
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instala o Poetry diretamente no local correto
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && ln -s $POETRY_HOME/bin/poetry /usr/local/bin/poetry \
    && poetry --version

# Copia arquivos de configuração do Poetry
COPY pyproject.toml poetry.lock ./

# Instala dependências do projeto
RUN poetry lock && poetry check
RUN poetry install --no-root

# Copia o código-fonte da aplicação
COPY app.py ./

# Remove arquivos desnecessários e otimiza o tamanho da imagem
RUN rm -rf $POETRY_CACHE_DIR

# Exposição da porta padrão do Streamlit
EXPOSE 8501

# Define o comando de entrada do container
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.enableCORS=false"]