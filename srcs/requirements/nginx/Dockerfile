FROM alpine:3.24

RUN apk update && apk add --no-cache nginx

COPY conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 80

# daemon off: stay in the foreground so the container keeps running
CMD [ "nginx", "-g", "daemon off;" ]
