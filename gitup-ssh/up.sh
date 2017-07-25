#!/bin/sh

[ "$UP_REPOS" ] || { echo "Nenhum repositório informado!" ; exit 1; }
[ "$UP_HOST" ] || { echo "Nenhum host informado!" ; exit 1; }
[ "$UP_USER" ] || { echo "Nenhum usuário informado!" ; exit 1; }
[ "$UP_FOLDER" ] || { echo "Nenhuma pasta informado!" ; exit 1; }

if [ ! -f /root/.ssh/id_rsa ]; then
	# Gera chave 
	ssh-keygen -t rsa -b 4096 -N "" -f /root/.ssh/id_rsa
	# SSH yes
	ssh-keyscan $UP_HOST > /root/.ssh/known_hosts
fi

gitUp () {
	repo="$1.git"
	ssh $UP_USER@$UP_HOST -o PasswordAuthentication=no "cd $UP_FOLDER/$repo/ && git fetch origin +refs/heads/*:refs/heads/* && git reset --soft"
	if [ $? -gt 0 ]; then
                echo "Falha ao executar ssh! Pode ser necessário copiar a chave ssh para o servidor de destino!"
                echo "COMANDO: ssh-copy-id -i /root/.ssh/id_rsa.pub $UP_USER@$UP_HOST"
        fi
}

# Faz o pull para todos os repositórios definidos em UP_REPOS
fr REPO in $UP_REPOS; do
	gitUp $REPO
done

# Se foi definida frequência para executar o pull, neste momento entra no loop.
if [ "$UP_FREQUENCY" ]; then
	for REPO in $UP_REPOS; do
		gitUp $REPO
	done
	sleep $UP_FREQUENCY
fi
