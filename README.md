# Attendances Simulator

Application to simulate and test dealing with big data volume to Data Engineering MBA at IGTI.

## Dependencies

*  [`docker`](https://docs.docker.com/engine/install/) > 18 (or newer)
*  [`docker-compose`](https://docs.docker.com/compose/install/) > 1.20 (or newer)

## Instalation

To install the project open a terminal and run:

```
docker-compose up -d
```

Wait it can take while to build the docker images.

After finish, create the database:

```
# create databases
docker-compose exec run app rails db:create

# run migrations to create tables
docker-compose exec run app rails db:migrate

# populate with base data
docker-compose exec run app rails db:seed
```

If every is ok go to a browser and access:

```
http://localhost:3000
```

## Utilites

Start/stop the application:
```
docker-compose start/stop
```

Stop and remove containers:
```
docker-compose down
```

Rails console:
```
docker-compose exec app rails console
```

Shell:
```
docker-compose exec app sh
```

Access MongoDB database:
```
docker-compose exec mongodb sh
# mongo
> show databases
> use igti_attendances_simulator_development
> show collections
```

## Running the proccess

### Generate random data

To generante random attendances in database, run in rails console:

```
Generators::Attendances.new(params).generate
```

avaliable params:

* **stores:** _default: nil_. If nil generate data for all stores in database.
* **start_date:** _default: Date.today_
* **end_date:** _default: Date.today_
* **monthly_amount:** _default: 10_000_000_
* **log_sql:** _default: false_

### ETL Postgresql > MongoDB

To execute the script to transform attendances and load at MongoDB database, run in rails console:

#### Lost Reasons
Compilation of lost reasons per day:
```
Etls::LostReasons.generate_by_date(date)
```
