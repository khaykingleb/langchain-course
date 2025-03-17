.DEFAULT_GOAL = help

venv: ## Create a virtual environment
	@uv venv --python=python3.11

install: venv ## Install the dependencies
	@uv pip install -r requirements.txt

env: ## Create .env file if it doesn't exist
	@if ! [ -e .env ]; then \
		cp .env.example .env; \
		echo "Created .env file. Please edit it according to your setup."; \
	fi
.PHONY: env

help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; \
		printf "\nUsage:\n  make \033[36m<target>\033[0m\n\n"} \
		/^[a-zA-Z0-9_-]+%?:.*?##/ { \
			printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 \
		} \
		/^##@/ { \
			printf "\n\033[1m%s\033[0m\n", substr($$0, 5) \
		}' $(MAKEFILE_LIST)
.PHONY: help
