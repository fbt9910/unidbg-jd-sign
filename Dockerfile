FROM openjdk:8u212-jre-alpine3.9
MAINTAINER zhx47

EXPOSE 8080
WORKDIR /app
VOLUME /app/data/

ENV TZ=Asia/Shanghai
RUN apk update && \
    apk add curl && \
    curl -o unidbg-jd-sign-0.0.1-SNAPSHOT.jar -L https://github.com/YYWO/unidbg-jd-sign/releases/download/0.1/unidbg-jd-sign-0.0.1-SNAPSHOT.jar && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY target/unidbg-jd-sign-0.0.1-SNAPSHOT.jar /app/
COPY jd.apk /app/init/
COPY libjdbitmapkit.so /app/init/
COPY start.sh /app/

RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
