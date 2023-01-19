#This package kind of do the job. Running docker build -t <name image> . will set up a image that will run gitea without an database. It has to be set 
#up in a diffrent container. run docker -dp 3000:3000 <image> will start a gitea server.

FROM alpine:latest
RUN apk add wget
RUN apk add git
RUN addgroup --system git
RUN adduser --system --shell /bin/bash --gecos 'Git Version Control' --ingroup git --disabled-password --home /home/git git

RUN mkdir -p /var/lib/gitea/custom
RUN mkdir -p /var/lib/gitea/custom/conf
RUN mkdir -p /var/lib/gitea/data
RUN mkdir -p /var/lib/gitea/log
RUN chown -R git:git /var/lib/gitea/
RUN chmod -R 755 /var/lib/gitea/
RUN mkdir /etc/gitea
RUN chown root:git /etc/gitea
RUN chmod 770 /etc/gitea
#RUN chmod 755 /var/lib/gitea/gitea
RUN wget https://github.com/go-gitea/gitea/releases/download/v1.18.1/gitea-1.18.1-linux-amd64 -O /var/lib/gitea/gitea
RUN chmod 755 /var/lib/gitea/gitea
WORKDIR /var/lib/gitea/
COPY /app.ini /etc/app.ini
EXPOSE 22 3000
USER 1000
CMD ["/var/lib/gitea/gitea", "web"]
