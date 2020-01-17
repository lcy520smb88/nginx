#!/bin/bash\
echo -e '\033[94m'
yum -y install gcc pcre-devel openssl-devel
useradd -s /sbin/nologin nginx
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make
make install

nginx=/usr/local/nginx
$nginx/sbin/nginx
sed -i '37a auth_basic "Input Password:";' $nginx/conf/nginx.conf  #加密认证
sed -i '38a auth_basic_user_file "/usr/local/nginx/pass";' $nginx/conf/nginx.conf
yum -y install httpd-tools
htpasswd -bc $nginx/pass  tom 123
$nginx/sbin/nginx -s reload

cd $nginx/conf                       #ssl虚拟主机
openssl genrsa > cert.key
openssl req -new -x509 -key cert.key > cert.pem  <<EOF
CN






EOF
sed -i '98,115s/#//' $nginx/conf/nginx.conf
sed -i '100s/#/ /' $nginx/conf/nginx.conf   #设置域名
$nginx/bin/nginx -s reload   

#sed -i '37s/localhost/$1/' $nginx/conf/nginx.conf  #基于域名


yum -y install mariadb mariadb-server mariadb-devel php php-mysql  php-fpm
systemctl start  mariadb                    #lnmp环境平台
systemctl enable mariadb
systemctl start php-fpm
systemctl enable php-fpm
sed -i '65,71s/#//' $nginx/conf/nginx.conf
sed -i 's/fastcgi_params/fastcgi.conf/' $nginx/conf/nginx.conf
sed -i '69s/^/#/' /usr/local/nginx/conf/nginx.conf
systemctl stop httpd
$nginx/sbin/nginx -s reload

#sed -i '37a rewrite /$2   /$3;'  $nginx/conf/nginx.conf #地址跳转
#$nginx/sbin/nginx -s reload




