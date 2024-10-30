# 构建阶段
<<<<<<< Updated upstream
FROM node:20-alpine as builder
=======
FROM node:20-alpine AS builder
>>>>>>> Stashed changes

# 设置工作目录
WORKDIR /app

<<<<<<< Updated upstream
# 配置 npm 镜像源
RUN npm config set registry https://registry.npmmirror.com

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm ci

=======
# 配置npm镜像
RUN npm config set registry https://registry.npmmirror.com

# 复制package.json和package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install

>>>>>>> Stashed changes
# 复制源代码
COPY . .

# 构建应用
RUN npm run build

<<<<<<< Updated upstream
# 生产阶段
FROM nginx:alpine

# 复制构建产物到 Nginx 目录
=======
# 运行阶段
FROM nginx:alpine AS runtime

# 复制nginx配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 复制构建产物到nginx目录
>>>>>>> Stashed changes
COPY --from=builder /app/dist /usr/share/nginx/html

# 复制 Nginx 配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 添加环境变量替换脚本
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# 暴露端口
EXPOSE 9002

<<<<<<< Updated upstream
# 使用环境变量替换脚本作为入口
ENTRYPOINT ["/docker-entrypoint.sh"]

# 启动 Nginx
=======
# 复制并设置 entrypoint 脚本
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
>>>>>>> Stashed changes
CMD ["nginx", "-g", "daemon off;"]
