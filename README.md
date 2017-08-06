
# Docker Dynamodb
✨ Dockerized Dynamodb for Local Development ✨

<p align="center">
  <img src="https://github.com/ykrevnyi/docker-dynamodb-local/blob/master/assets/gui.jpg" alt="docker dynamodb local gui"/>
</p>

## Quickstart

```bash
# Start database, keep data between runs, publish port to host on :8000
docker run \
  -p 8000:8000 \
  -v "/opt/dynamodb-storage" ykrevnyi/docker-dynamodb-local \
  -dbPath "/opt/dynamodb-storage" \
  -sharedDb
```

Looking for `docker-compose` version? Here you go:

```bash
services:
  dynamodb:
    image: "ykrevnyi/docker-dynamodb-local"
    command: -dbPath "/opt/dynamodb-storage" -sharedDb
    ports:
      - "8000:8000"
    volumes:
      - "/opt/dynamodb-storage"
```


## Howto

1. Start database (do not publish port to the host):
  ```bash
  docker run ykrevnyi/docker-dynamodb-local
  ```

2. Start database (publish port to the host):
  ```bash
  # Publish hardcoded port to the host (format "host:container")
  # Database will be available on host port 8000
  docker run -p 8000:8000 ykrevnyi/docker-dynamodb-local

  # Publish dynamic port to the host
  # Run `docker ps` to see dynamic port
  docker run -p 8000 ykrevnyi/docker-dynamodb-local
  ```

3. Keep data between container restarts:
  ```bash
  # Store data in volume
  docker run -v "/opt/dynamodb-storage" ykrevnyi/docker-dynamodb-local -dbPath "/opt/dynamodb-storage"

  # Store data in volume and publish static port to host
  docker run \
    -p "8000:8000" \
    -v "/opt/dynamodb-storage" \
    ykrevnyi/docker-dynamodb-local \
      -dbPath "/opt/dynamodb-storage" \
      -sharedDb
  ```

## Configuration

How to use configuration?

Example:
```bash
# Format [CONFIGURATION]
# docker run ykrevnyi/docker-dynamodb-local [CONFIGURATION]

docker run ykrevnyi/docker-dynamodb-local
docker run ykrevnyi/docker-dynamodb-local -cors "*"
docker run ykrevnyi/docker-dynamodb-local -cors "*" -delayTransientStatuses
docker run ykrevnyi/docker-dynamodb-local -delayTransientStatuses -optimizeDbBeforeStartup
docker run -v "/opt/dynamodb-storage" ykrevnyi/docker-dynamodb-local -dbPath "/opt/dynamodb-storage"
docker run ykrevnyi/docker-dynamodb-local -inMemory -delayTransientStatuses -optimizeDbBeforeStartup
```


* `-port value` — DynamoDB uses 8000 port. Do not change this value.

  Example:
  ```bash
  # Publish hardcoded port to the host (format "host:container")
  # Database will be available on host port 8000
  docker run -p 8000:8000 ykrevnyi/docker-dynamodb-local

  # Publish dynamic port to the host
  # Run `docker ps` to see dynamic port
  docker run -p 8000 ykrevnyi/docker-dynamodb-local
  ```


* `-cors value` — Enable CORS support (cross-origin resource sharing) for JavaScript. You must provide a comma-separated "allow" list of specific domains. The default setting for -cors is an asterisk (*), which allows public access.

  Example:
  ```bash
  docker run ykrevnyi/docker-dynamodb-local -cors "*"
  ```

* `-dbPath value` — The directory where DynamoDB will write its database file. Note that you cannot specify both -dbPath and -inMemory at once.

  Don't forget to create `volume` if want to keep data between container restarts.

  Example:
  ```bash
  docker run -v "/opt/dynamodb-storage" ykrevnyi/docker-dynamodb-local -dbPath "/opt/dynamodb-storage"
  ```


* `-delayTransientStatuses` — Causes DynamoDB to introduce delays for certain operations. DynamoDB can perform some tasks almost instantaneously, such as create/update/delete operations on tables and indexes; however, the actual DynamoDB service requires more time for these tasks. Setting this parameter helps DynamoDB simulate the behavior of the Amazon DynamoDB web service more closely. (Currently, this parameter introduces delays only for global secondary indexes that are in either CREATING or DELETING status.)

  Example:
  ```bash
  docker run ykrevnyi/docker-dynamodb-local -delayTransientStatuses
  ```

* `-inMemory` — DynamoDB; will run in memory, instead of using a database file. When you stop DynamoDB;, none of the data will be saved. Note that you cannot specify both -dbPath and -inMemory at once.

  Example:
  ```bash
  docker run ykrevnyi/docker-dynamodb-local -inMemory
  ```

* `-optimizeDbBeforeStartup` — Optimizes the underlying database tables before starting up DynamoDB on your computer. You must also specify -dbPath when you use this parameter.

  Example:
  ```bash
  docker run ykrevnyi/docker-dynamodb-local -optimizeDbBeforeStartup
  ```

* `-sharedDb` — DynamoDB will use a single database file, instead of using separate files for each credential and region. If you specify -sharedDb, all DynamoDB clients will interact with the same set of tables regardless of their region and credential configuration.


## Need Help?
Please submit an issue on GitHub and provide information about your setup.


## License
This project is licensed under the terms of the MIT license. See the LICENSE file.