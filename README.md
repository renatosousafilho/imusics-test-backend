# README

## Executar

Para executar a aplicação. Recomendo o uso do docker-compose. (https://docs.docker.com/compose/install/)

Uma vez instalado, basta executar o comando:

```
docker-compose up
```

Para criar o banco e executar as migrations.

```
docker-compose run --rm web rails db:create db:migrate
```

Criar arquivo .env com as chaves do OAuth do Spotify com o seguite conteúdo.

```
SPOTIFY_APP_ID=xxxxxxxxxxxxxxxxxxxx
SPOTIFY_SECRET_KEY=xxxxxxxxxxxxxxxxxxxx
```

# Setup Doorkeper

Para que a aplicação mobile precisamos criar uma aplicação oauth. Para isso acesse http://localhost:5000/oauth/applications e clique em Nova Aplicação.

- Em Name adicione qualquer valor de sua preferência.
- Em Callback URL adicione as url de Callback: http://localhost:3000/auth/doorkeeper/callback.
- Desmarque a opção cofidencial

Clicar em Submit.

Após isso será exibido as credenciais OAuth para nossa aplicação. Use elas para fazer o setup da aplicação cliente React.
