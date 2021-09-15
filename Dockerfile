FROM python:3.9.6-alpine3.13

RUN apk add  \
	--no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/main \
	--update --no-cache \
	bash \
	boost-dev \
	curl \
	sudo \
	tar \
	xz
RUN apk add  \
	--no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
	--update --no-cache nix
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable
RUN nix-channel --update
RUN rm -rf /nix/var/nix/profiles/default
RUN ln -s /nix/var/nix/profiles/per-user/root /nix/var/nix/profiles/default
RUN nix-env -iA nixpkgs.nixfmt
RUN ln -s /nix/var/nix/profiles/default/bin/nixfmt /usr/bin
RUN nixfmt --version