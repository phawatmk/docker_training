# docker_training

## Remote to Server
Remote to VM by Secure Shell (SSH) protocol. <br />
<br />
```
ssh {user}@{host}
```
Change ```{user}``` to your user and ```{host}``` to your external IP of VM. <br />
After run command. There are 2 promts in terminal.<br />
- Trust this connection. Type ```yes```.<br />
- Authen your user.Type your password.<br />

If connection success.You will be logged into the remote server, and you'll see the remote system's command prompt.<br />


## Create Docker project directory
Create directory for docker project.<br />

```
cd /
sudo mkdir docker
sudo chown {user}:{user} docker
```

## Pull docker images
Pull docker images which be used on this project.<br />

```
cd /docker
sudo docker pull jupyter/scipy-notebook
```
After docker images was pull check docker images by run this command.<br />

```
sudo docker images
```
![alt text](https://github.com/phawatmk/docker_training/blob/main/images/pull_images.png) <br /><br />

## Run docker images
Run docker images in this project is jupyter notebook.<br />

```
sudo docker run -d -p 10000:8888 jupyter/scipy-notebook start-notebook.sh --NotebookApp.token=''
```

After run docker images.Run this command to check docker images run.<br />
```
sudo docker ps
```
![alt text](https://github.com/phawatmk/docker_training/blob/main/images/run_docker_images.png) <br /><br />

Open web browser and go to link ```http://{YOUR HOST}:10000``` to access ```JupyterLab``` .<br />

![alt text](https://github.com/phawatmk/docker_training/blob/main/images/jupyter_lab_1.png) <br /><br />

Stop jupyter images for next step.<br />

```
sudo docker stop {CONTAINER_ID}
```

![alt text](https://github.com/phawatmk/docker_training/blob/main/images/stop_docker_images.png) <br /><br />

## Run docker compose
Previous step is running docker image by command. In this step run docker by docker compose.<br />
Download ```docker-compose-1.yml``` file.<br />

```
wget -O docker-compose.yml https://raw.githubusercontent.com/phawatmk/docker_training/refs/heads/main/docker-compose-1.yml
```

Run docker compose.<br />

```
sudo docker compose up -d
```

Check docker images run.<br />
```
sudo docker ps
```
![alt text](https://github.com/phawatmk/docker_training/blob/main/images/run_docker_compose_1.png) <br /><br />

Go to link ```http://{YOUR HOST}:10000``` to access ```JupyterLab``` again .<br />

Download jupyter notebook by run this command.<br />
```
sudo chown {user}:{user} notebooks
wget -O notebooks/notebook.ipynb https://raw.githubusercontent.com/phawatmk/docker_training/refs/heads/main/notebook.ipynb
```

In JupyterLab. Access to ```work``` folder and open ```notebook.ipynb``` file.<br />
Run first cell and you will get error.<br />
![alt text](https://github.com/phawatmk/docker_training/blob/main/images/notebook_error.png) <br /><br />
To install additional python libary.Docker image will be revised.<br />

## Revise docker image
Revised image by create new image from image ```jupyter/scipy-notebook```.<br />
Download ```Dockerfile``` by run this command.<br />

```
wget -O Dockerfile https://raw.githubusercontent.com/phawatmk/docker_training/refs/heads/main/Dockerfile
```
Dockerfile is use image ```jupyter/scipy-notebook``` and install more python libraries ```Faker``` and ```psycopg2-binary```.<br />

```
# Start from a core stack version
FROM jupyter/scipy-notebook:latest
RUN pip install --quiet --no-cache-dir 'Faker==30.1.0' && \
    pip install 'psycopg2-binary' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
```

Build new image on local by run this command.<br />
```
sudo docker build -t myapp:latest .
```
After build new image. Run this command to check new image.<br />
```
sudo docker images
```

![alt text](https://github.com/phawatmk/docker_training/blob/main/images/build_new_image.png) <br /><br />

Download ```docker-compose-2.yml``` file which run with new image.<br />

```
wget -O docker-compose.yml https://raw.githubusercontent.com/phawatmk/docker_training/refs/heads/main/docker-compose-2.yml
```

Image will be change to myapp:latest as we built before.<br />
```
services:
  jupyter:
    image: myapp:latest
```
Stop container and run container with new images.<br />
```
sudo docker compose down
sudo docker compose up -d
```
![alt text](https://github.com/phawatmk/docker_training/blob/main/images/stop_and_run_container.png) <br /><br />
Go to JupyterLab. Access to ```work``` folder and open ```notebook.ipynb``` file.<br />
Run first cell again and you will not get error.<br />

## Add service to container
Add postgresql to same container by edit ```docker-compose.yml```. <br />
Download ```docker-compose-3.yml``` file which add postgres to container.<br />

```
wget -O docker-compose.yml https://raw.githubusercontent.com/phawatmk/docker_training/refs/heads/main/docker-compose-3.yml
```
In this ```docker-compose.yml```.Postgres was added to this container.<br />
```
  postgres:
    image: postgres:13
    environment:
      POSTGRES_USER: docker
      POSTGRES_PASSWORD: docker
      POSTGRES_DB: postgres
    ports:
      - "5432:5432"
    volumes:
      - ./postgres-db-volume:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "postgres"]
      interval: 10s
      retries: 5
      start_period: 5s
    restart: always
```

Stop container and run new container.<br />
```
sudo docker compose down
sudo docker compose up -d
```
![alt text](https://github.com/phawatmk/docker_training/blob/main/images/run_new_container.png) <br /><br />

## Execute inside to contianer
Go to JupyterLab. Access to ```work``` folder and open ```notebook.ipynb``` file.<br />
Run all cell until last cell shown as picture below.<br />

![alt text](https://github.com/phawatmk/docker_training/blob/main/images/run_notebook_success.png) <br /><br />

Excute to postgres container to check data by run this command.<br />
```
sudo docker exec -it docker-postgres-1 /bin/bash
```

After execute to container run psql command to access psql cli.<br />

```
psql -d postgres -U docker
```

Query to check data.<br />
```
select * from customer_detail limit 10;
```
Result will be shown like this :<br /><br />
![alt text](https://github.com/phawatmk/docker_training/blob/main/images/docker_exec.png) <br /><br />
