# 🚀 **Launch a Yii2 App with Docker Swarm, CI/CD, & Ansible!**

This project deploys a **PHP Yii2 app** on AWS EC2 using *Docker Swarm*, *NGINX*, *Ansible*, and *GitHub Actions*.  
Get ready to automate, deploy, and shine! ✨

---

## 📋 **What’s Inside?**

- [🌟 **Project Overview**](#-project-overview)  
- [🛠️ **What You’ll Need**](#️-what-youll-need)  
- [🚀 **Let’s Set It Up!**](#-lets-set-it-up)  
- [🤔 **Key Assumptions**](#-key-assumptions)  
- [🧪 **Test Your Deployment**](#-test-your-deployment)  
- [🎉 **Cool Extras**](#-cool-extras)  
- [📂 **File Structure**](#-file-structure)  
- [🔧 **Fixing Issues**](#-fixing-issues)

---

## 🌟 **Project Overview**

Dive into a *modern DevOps setup*! 🚀  
This project uses a sample Yii2 app ([`yiisoft/yii2-app-basic`](https://github.com/yiisoft/yii2-app-basic)) with these awesome tools:  

- **Docker Swarm**: Orchestrates the application container.  
- **NGINX**: Runs on the EC2 host as a reverse proxy.  
- **Ansible**: Automates EC2 setup (Docker, NGINX, Swarm).  
- **GitHub Actions**: Automates building, pushing, and deploying.  

---

## 🛠️ **What You’ll Need**

Let’s make sure you’re ready! ✅  

- **AWS Account**: Access to EC2 with a key pair (e.g., `my-key.pem`).  
- **GitHub Account**: To host your repo and run CI/CD.  
- **Docker Hub Account**: For storing your Docker image.  
- **Local Machine Tools**:  
  - Git  
  - Ansible  
  - Docker  
- **EC2 Instance**: Ubuntu Server 20.04 LTS, t2.micro (free tier eligible).  

---

## 🚀 **Let’s Set It Up!**

Follow these steps to launch your app! 🌟  

### 1. Launch Your EC2 Instance  
Log in to AWS EC2 and launch an **Ubuntu Server 20.04 LTS** instance.  
Configure the security group:  
- Allow **SSH (port 22)** from your IP.  
- Allow **HTTP (port 80)** from `0.0.0.0/0`.  
Save your SSH key pair (e.g., `my-key.pem`).  
Note the public IP (e.g., `54.123.45.67`).  

### 2. Clone This Repo  
```bash
git clone https://github.com/your-username/yii2-swarm-cicd.git
cd yii2-swarm-cicd
```

### 3. Add the Yii2 App  
```bash
git clone https://github.com/yiisoft/yii2-app-basic.git .
git add .
git commit -m "Add Yii2 basic application"
```

### 4. Update Config Files  
In `setup.yml` and `deploy.yml`, replace `your_dockerhub_username` with your Docker Hub username.  
Ensure `docker-compose.yml` points to the correct Docker Hub image.  

### 5. Automate with Ansible  
Run this command to set up your EC2 instance:  
```bash
ansible-playbook -i <ec2-public-ip>, setup.yml --user ubuntu --key-file ~/path/to/my-key.pem
```  
This installs Docker, NGINX, sets up Docker Swarm, and deploys the initial stack.  

### 6. Set Up GitHub Secrets  
Go to your GitHub repo > Settings > Secrets and variables > Actions.  
Add these secrets:  
- `DOCKER_USERNAME`: Your Docker Hub username.  
- `DOCKER_PASSWORD`: Your Docker Hub password or access token.  
- `EC2_HOST`: EC2 public IP (e.g., `54.123.45.67`).  
- `EC2_SSH_KEY`: Contents of your private SSH key (`my-key.pem`).  

### 7. Push and Deploy!  
```bash
git push origin main
```  
Watch GitHub Actions build, push, and deploy your app! 🚀  

---

## 🤔 **Key Assumptions**

Here’s what we’re assuming:  

- Your EC2 instance runs Ubuntu 20.04 with internet access.  
- The Yii2 app is the basic template (`yiisoft/yii2-app-basic`) without a database.  
- A single-node Docker Swarm is used for simplicity.  
- NGINX runs on the host, proxying to the container on port 8080.  
- You’re familiar with AWS, Git, Docker, and Ansible basics.  

---

## 🧪 **Test Your Deployment**

Let’s make sure everything works! ✅  

### 1. Visit Your App  
Open your browser and go to:  
`http://<ec2-public-ip>`  
You should see the Yii2 welcome page! 🎉  

### 2. Test the CI/CD Pipeline  
Make a change (e.g., edit `web/index.php`).  
Commit and push to `main`.  
Monitor the GitHub Actions pipeline to confirm deployment.  
Refresh the URL to see your update live!  

### 3. Check the Health  
SSH into your EC2 instance:  
```bash
ssh -i ~/path/to/my-key.pem ubuntu@<ec2-public-ip>
```  
Verify the service:  
```bash
docker service ls
```  
Check NGINX:  
```bash
sudo systemctl status nginx
```

---

## 🎉 **Cool Extras**

We’ve added some awesome features! ✨  

- **GitHub Secrets**: Securely stores your Docker credentials and SSH keys.  
- **Health Checks**: Ensures your app is running smoothly (see `docker-compose.yml`).  
- **Rollback Support**: Docker Swarm rolls back if the new image fails.  

---

## 📂 **File Structure**

Here’s what’s in the repo:  
```
📦 yii2-swarm-cicd  
 ┣ 📜 Dockerfile         🛠️ Builds the Yii2 app container  
 ┣ 📜 docker-compose.yml 🐳 Defines the Docker Swarm service  
 ┣ 📜 setup.yml          ⚙️ Ansible playbook for EC2 setup  
 ┣ 📜 nginx.conf         🌐 NGINX config for the container  
 ┣ 📜 nginx-host.conf    🌐 NGINX config for the host  
 ┣ 📜 start.sh           🚀 Starts NGINX and PHP-FPM  
 ┣ 📂 .github/workflows/  
 ┃ ┗ 📜 deploy.yml       🤖 GitHub Actions CI/CD pipeline  
 ┣ 📂 web/               💻 Yii2 application code  
 ┗ 📜 README.md          📖 This file  
```

---

## 🔧 **Fixing Issues**

Running into problems? Don’t worry! 🛠️  

- **NGINX Proxy Issues**: Check if `/etc/nginx/sites-available/default` matches `nginx-host.conf`.  
- **Docker Pull Errors**: Verify `DOCKER_USERNAME` and `DOCKER_PASSWORD` in GitHub Secrets.  
- **Ansible Failures**: Ensure SSH key permissions (`chmod 400 my-key.pem`) and EC2 security group rules.  
- **Service Not Running**: Check logs with `docker service logs myapp_app`.
  
---

Happy Deploying! 🌟 Let’s make DevOps fun and efficient! 😄
