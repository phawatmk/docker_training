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
___________________________picture____________________________________.<br />

## Run docker images
Run docker images in this project is jupyter notebook.<br />

```
sudo docker run -d -p 10000:8888 jupyter/scipy-notebook start-notebook.sh --NotebookApp.token=''
```

After run docker images.Run this command to check docker images run.<br />
```
sudo docker ps
```