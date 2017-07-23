# Gitup Docker Image

Imagem docker para automatizar clone de repositório git e definir período de git pull.
O objetivo desta imagem é disponibilizar o conteúdo do repositóio através de um volume para outros containers.

### Variáveis de ambiente

#### Obrigatórios

**GIT_USER:** Usuário do repositório reponsável por fazer o git clone e git pull.  
**GIT_PASSWORD:** Senha do usuário GIT_USER.  
**GIT_REPO:** Endereço do repositório ao qual será clonado. Formato: github.com/alexiscviurb/docker.git  
**GIT_FOLDER:** Pasta onde o clone será realizado.  

#### Opcionais

**GIT_PROTOCOL:** Protocolo a ser utilizado. HTTP ou HTTPS.  
**GIT_BRANCH:** Caso deseje utilizar um branch diferente do master.  
**GIT_TEST_FILE:** Arquivo que será procurado para validar se clone ja foi feito. Padrão: README.md  
**GIT_FREQUENCY:** Período de frequência do git pull. Se não for passado o container vai fazer o clone e depois vai parar. Valor em segundos.  

### Exemplo de uso

Executando o container para git clone do repositório:

```bash
docker run -d --name gitup_repo -e GIT_USER=alexiscviurb -e GIT_PASSWORD=senha -e GIT_REPO=github.com/alexiscviurb/docker.git -e GIT_FOLDER=/conteudo/repo -e GIT_FREQUENCY=60 --volume=/conteudo/repo alexiscviurb/gitup
```

Montar o volume em outro container:

```bash
docker run -d --volumes-from gitup_repo app_image
```
