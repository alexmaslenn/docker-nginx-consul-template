#!/bin/bash

service nginx start &
consul-template -consul-addr=$CONSUL_URL -template="$TEMPLATE_PATH:/etc/nginx/conf.d/default.conf:service nginx reload"