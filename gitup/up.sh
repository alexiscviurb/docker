#!/bin/sh

# Funções

file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "ERROR: Ambas variáveis $var e $fileVar estão declaradas (Apenas uma deve ser utilizada)!"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# Variáveis obrigatórias
[ "$GIT_REPO" ] || { echo >&2 "ERROR: Repositório Git não informado!" ; exit 1; }

file_env 'GIT_USER'
[ "$GIT_USER" ] || { echo >&2 "ERROR: Usuário Git não informado!" ; exit 1; }

file_env 'GIT_PASSWORD'
[ "$GIT_PASSWORD" ] || { echo >&2 "ERROR: Senha Git não informada!" ; exit 1; }

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
