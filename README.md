# node-with-nginx-docker-image 配置了node和nginx的前端镜像
## 构建

```
sudo docker build . -t zonghua/node-with-nginx-docker-image
```

## 推送
先要登录
```
sudo docker tag zonghua/node-with-nginx-docker-image zonghua/node-with-nginx-docker-image:0.0.1
sudo docker push zonghua/node-with-nginx-docker-image:0.0.1
```

## 用例
您需要在前端项目中添加以下两个文件

`theNginx.conf`和 `Dockerfile`

`Dockerfile`内容如下
```
FROM zonghua/node-with-nginx-docker-image:latest

WORKDIR /app
ADD . /app/
RUN npm install && \
    npm run build && \
    cp -R /app/dist/*  /usr/share/nginx/html && \
    cat /app/theNginx.conf > /etc/nginx/conf.d/default.conf

EXPOSE 8000

ENTRYPOINT ["nginx", "-g","daemon off;"]
```
## 使用环境变量
webpack 使用系统环境变量,赋值到配置模板中从而配置参数到生产测试环境
```
let appID = JSON.stringify(process.env.APP_ID || 'lalalalalalal')
```
docker 运行时设置环境变量
```
docker run --env <key>=<value>
```
Dockerfile 设置环境变量
```
ENV key=value
```