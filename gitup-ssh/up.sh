#!/bin/sh

[ "$UP_REPOS" ] || { echo "Nenhum repositório informado!" ; exit 1; }
[ "$UP_HOST" ] || { echo "Nenhum host informado!" ; exit 1; }
[ "$UP_USER" ] || { echo "Nenhum usuário informado!" ; exit 1; }
[ "$UP_FOLDER" ] || { echo "Nenhuma pasta informado!" ; exit 1; }

gitUp () {
	repo="$1.git"
	ssh $UP_USER@$UP_HOST -o PasswordAuthentication=no "cd $UP_FOLDER/$repo/ && git fetch origin +refs/heads/*:refs/heads/* && git reset --soft"
	if [ $? -gt 0 ]; then
                echo "Falha ao executar ssh! Pode ser necessário copiar a chave ssh para o servidor de destino!"
                echo "COMANDO: ssh-copy-id -i ~/.ssh/id_rsa.pub $UP_USER@$UP_HOST"
        fi
}

# Gera chave RSA se a mesma não existir
if [ ! -f ~/.ssh/id_rsa ]; then
	ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
fi

# Remove e adiciona RSA key fingerprint de UP_HOST
ssh-keygen -R $UP_HOST
ssh-keyscan $UP_HOST >> ~/.ssh/known_hosts

# Faz o pull para todos os repositórios definidos em UP_REPOS
for REPO in $UP_REPOS; do
	gitUp $REPO
done

# Se foi definida frequência para executar o pull, neste momento entra no loop.
if [ "$UP_FREQUENCY" ]; then
	for REPO in $UP_REPOS; do
		gitUp $REPO
	done
	sleep $UP_FREQUENCY
fi
