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
sudo docker-compose up -d
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
