FROM bandsintown/nginx

ADD vhost.conf /etc/nginx/conf.d/default.conf
