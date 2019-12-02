# eoc_web

EoC web is a web application which allow admin to upload and manage content which will be used later in EoC mobile application

## Features

- Create and manage standard operation procedure with attachment
- Create and manage category
- Import Sop from .zip file
- Notify to mobile app when there's new sop

## Docker development

Start project with docker-compose

```
docker-compose up
```

Run migration & seed data

```
docker-compose run --rm web rake db:setup
```
#### Run test and console with spring


First start spring server

```
docker-compose run --name=spring --rm web bundle exec spring server
```

Run rspec

```
docker exec -it spring rspec
```

