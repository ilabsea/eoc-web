# eoc_web

EoC web is a web application which allow admin to upload and manage content which will be used later in EoC mobile application

## Features

- Create and manage standard operation procedure with attachment
- Create and manage category
- Import Sop from .zip file
- Notify to mobile app when there's new sop

## Docker development


```docker-compose.yml``` file build a development environment mounting the current folder and running rails in development environment.

App configuration are stored in ```docker-env```. Please check sample config in ```docker-env.example```.

Start project with docker-compose:

```
docker-compose up
```

Run migration & seed data

```
docker-compose run --rm web rake db:setup
```

Install latest JS dependency

```
docker-compose run --rm web yarn install --check-files
```

#### Run test with spring


First start spring server

```
docker-compose run --name=spring --rm web bundle exec spring server
```

Run rspec

```
docker exec -it spring rspec
```

