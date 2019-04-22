# 编译nginx版本PHP
1. `configue`
<br>`./configure --prefix=/usr/local/fastphp \`
<br>`--with-mysqli \`
<br>`--enable-embedded-mysqli \`
<br>`--with-pdo-mysql \`
<br>`--enable-mysqlnd \`
<br>`--with-gd \`
<br>`--enable-gd-jis-conv \`
<br>`--enable-fpm`


2. `make & makeinstall`


# gzip配置
`gzip on;`
<br>`gzip_buffers 32 4k;`
<br>`gzip_comp_level 6;`
<br>`gzip_min_length 200;`
<br>`gzip_type text/css text/xml application/x-javascript;`