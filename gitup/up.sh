#!/bin/sh

# Variáveis obrigatórias
[ "$GIT_USER" ] || { echo "Usuário Git não informado!" ; exit 1; }
[ "$GIT_PASSWORD" ] || { echo "Senha Git não informada!" ; exit 1; }
[ "$GIT_REPO" ] || { echo "Repositório Git não informado!" ; exit 1; }
[ "$GIT_FOLDER" ] || { echo "Pasta para git clone não informada!" ; exit 1; }

# Variáveis opcionais
[ "$GIT_PROTOCOL" ] || GIT_PROTOCOL=https
[ "$GIT_BRANCH" ] || GIT_BRANCH=master
[ "$GIT_TEST_FILE" ] || GIT_TEST_FILE=README.md

# Cria pasta de clone caso não exista
[ ! -d "$GIT_FOLDER" ] && mkdir -p $GIT_FOLDER

# Verifica se clone ja foi feito baseado no arquivo de teste (GIT_TEST_FILE).
# Se não foi feito faz o clone.
[ ! -e "$GIT_FOLDER/$GIT_TEST_FILE" ] && git clone $GIT_PROTOCOL://$GIT_USER:$GIT_PASSWORD@$GIT_REPO $GIT_FOLDER && git -C $GIT_FOLDER checkout $GIT_BRANCH

# Faz o primeiro pull
git -C $GIT_FOLDER reset --hard HEAD
git -C $GIT_FOLDER pull

# Se foi definida frequência para executar o pull, neste momento entra no loop.
if [ "$GIT_FREQUENCY" ]; then
	while true; do
		git -C $GIT_FOLDER reset --hard HEAD
		git -C $GIT_FOLDER pull
		sleep $GIT_FREQUENCY
	done
fi
