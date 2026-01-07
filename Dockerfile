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
	bat \
	curl \
	direnv \
	file \
	git \
	jq \
	python3 \
	python3-pip \
	shellcheck \
	shfmt \
	ripgrep

RUN pip install --break-system-packages \
	black \
	flake8 \
	isort \
	mypy \
	pylint \
	ruff \
	uv

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
	apt update && \
	apt install -y nodejs

RUN npm install -g \
	@github/copilot \
	@google/gemini-cli \
	@openai/codex \
	opencode-ai

RUN curl -fsSL https://claude.ai/install.sh | bash
