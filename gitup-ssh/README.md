# Gitup-SSH Docker Image

Imagem docker para automatizar execução de update em repositório git remoto através de SSH. Pode ser definido período de frequência de execução.
O objetivo desta imagem é acessar um servidor remoto, via ssh, e atualizar o repositório já clonado em uma pasta.

### Variáveis de ambiente

#### Necessárias

**UP_USER:** Usuário do repositório reponsável por fazer a atualização.  
**UP_HOST:** Senha do usuário **UP_USER**.  
**UP_REPOS:** Lista de nome de repositórios separados por espaço.  
**UP_FOLDER:** Pasta onde o repositório foi clonado.  

#### Opcionais

**UP_FREQUENCY:** Período de frequência da atualização. Se não for definido, o container vai fazer a atualização e depois parar. Valor em segundos.  

### Download da imagem

```bash
docker pull alexiscviurb/gitup-ssh
```

### Exemplo de uso

```bash
docker run -d --name gitupssh -e UP_USER=alexiscviurb -e UP_PASSWORD=senha -e UP_REPOS="repo1 repo2 repo3" -e UP_FOLDER=/conteudo/repos -e UP_FREQUENCY=600 --volume=~:/root alexiscviurb/gitup-ssh
```
