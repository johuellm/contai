ARG UBUNTU_VERSION=25.10

FROM ubuntu:${UBUNTU_VERSION}

ARG UID
ARG USERNAME
ARG GID
ARG GROUPNAME

RUN userdel --force --remove ubuntu && \
	groupadd --gid ${GID} ${GROUPNAME} && \
	useradd --create-home --shell /bin/bash --gid ${GID} --uid ${UID} ${USERNAME}

RUN apt-get update && apt-get install -y \
	bash-completion \
	curl \
	file \
	ripgrep \
	bat \
	python3 \
	python3-pip \
	git

RUN pip install --break-system-packages \
	uv \
	ruff \
	black \
	isort \
	pylint \
	mypy \
	flake8

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
	apt update && \
	apt install -y nodejs

RUN npm install -g \
	@openai/codex \
	@github/copilot \
	@google/gemini-cli \
	opencode-ai

RUN curl -fsSL https://claude.ai/install.sh | bash
