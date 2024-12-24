# Como executar este projeto

Este projeto utiliza Docker para facilitar a execução do ambiente.

## Requisitos

- Docker instalado ([instale aqui](https://docs.docker.com/get-docker/))

## Passos para execução

1. Clone este repositório:

   ```bash
   git clone https://github.com/nilo-lima/LLM_RAG_Documents.git
   cd LLM-RAG-Documents

2. Renomei o arquivo .env-example para .env, e informe os tokens nas respectivas variáveis

3. Para construir o container ambientes Windows, faça:

   ```bash
   docker compose up --build ou ( docker compose build --no-cache )

4. Para encerrar, digite:

   ```bash
   docker compose up



4. Execute o comando abaixo para construir e rodar o container:

   ```bash
   make all