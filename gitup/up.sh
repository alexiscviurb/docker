#!/bin/sh

# Função que verifica se foi passado argumento como arquivo
file_env() {
	local VAR="$1"
	local FILEVAR="${VAR}_FILE"
	local DEF="${2:-}"
	if eval [ "\${$VAR}" ] && eval [ "\${$FILEVAR}" ]; then
		echo >&2 "ERROR: Ambas variáveis $VAR e $FILEVAR estão declaradas (Apenas uma deve ser utilizada)!"
		exit 1
	fi
	VAL="$DEF"
	if eval [ "\${$VAR}" ]; then
		eval VAL="\${$VAR}"
	elif eval [ "\${$FILEVAR}" ]; then
		eval FILE="\${$FILEVAR}"
		if [ -f "${FILE}" ]; then
			VAL="$(< "${FILE}")"
		fi
	fi
	export "$VAR"="$VAL"
	unset "$FILEVAR"
}

# Valida variáveis
${GIT_REPO:?"Repositório Git não informado!"}

file_env 'GIT_USER'
${GIT_USER:?"Usuário Git não informado!"}

file_env 'GIT_PASSWORD'
${GIT_PASSWORD:?"Senha Git não informada!"}

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
