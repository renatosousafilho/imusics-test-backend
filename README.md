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
