FROM listmonk/listmonk:latest
ARG PORT ADMIN_PASSWORD ADMIN_USERNAME PGDATABASE PGHOST PGPASSWORD PGPORT PGUSER

RUN mkdir -p static
ADD https://user.fm/files/v2-5d2eb641f2521163f94579c22719017a/listmonk.zip ./static
RUN cd static && ls
RUN unzip listmonk.zip && rm listmonk.zip

RUN mv ./listmonk ./static

RUN chmod -R 755 ./static
COPY config.sh ./config.sh
RUN chmod +x ./config.sh && ./config.sh
RUN ./listmonk --static-dir=static --idempotent --yes --upgrade || ./listmonk --static-dir=static --install --yes --upgrade
