#!/bin/sh
set -e

# 从环境变量更新 nginx 配置
cat > /etc/nginx/conf.d/default.conf << EOF
server {
    listen 9002;
    server_name ${DOMAIN:-localhost};

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location /api {
        proxy_pass http://service:9003;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

# 启动nginx
exec "$@" 