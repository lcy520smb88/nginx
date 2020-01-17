#!/bin/bash
      #设置集群
sed -i 'a upstream webserver { \n         server 192.168.2.100:80; \n        server 192.168.2.200:80; \n  }'   $nginx/conf/nginx.conf
sed -i 'a proxy_pass http://webserver;' $nginx/conf/nginx.conf
$nginx/sbin/nginx -s reload  
    #集群权重
#sed -i 's/:80/weight=1 max_fails=1 fail_timeout=30;'  $nginx/conf/nginx.conf
#sed -i 's/:80/weight=1 max_fails=1 fail_timeout=30;'  $nginx/conf/nginx.conf     
#$nginx/sbin/nginx -s reload
       #源地址哈希
#sed -i 'a    ip_hash;'     $nginx/conf/nginx.conf
        #TCP/UDP调度器    #远程连接
sed -i 'a stream {  \n              upstream backend { \n             server 192.168.2.100:22; \n                   server 192.168.2.200:22;  \n  }'  $nginx/conf/nginx.conf
sed -i 'a server {  \n           listen 12345;  \n          proxy_pass backend;  \n  }   \n   }' $nginx/conf/nginx.conf
$nginx/sbin/nginx -s reload
           #自定义报错
#sed -i 's/#//' $nginx/conf/nginx.conf
#sed -i 's/#//' $nginx/conf/nginx.conf
#$nginx/sbin/nginx -reload
             #查看状态
#sed -i 'a/location /status { \n          stub_status on; \n   }' $nginx/conf/nginx.conf
#$nginx/sbin/nginx -s reload
