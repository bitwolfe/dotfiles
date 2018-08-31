#!/usr/bin/env zsh
docker_prune() {
	docker system prune --volumes -fa
}