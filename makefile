build:
	docker build -t rag-documents .

run:
	docker run --rm -p 8501:8501 --name llm-rag-documents rag-documents

all: build run
