FROM listmonk/listmonk:latest
ARG PORT ADMIN_PASSWORD ADMIN_USERNAME PGDATABASE PGHOST PGPASSWORD PGPORT PGUSER

ADD https://user.fm/files/v2-5bd90f82f756bf87022d47cb2c7bd8a2/static.zip ./
RUN unzip static.zip && rm static.zip && cd listmonk && ls -l


COPY config.sh ./config.sh
RUN chmod +x ./config.sh && ./config.sh
RUN ./listmonk --static-dir=./static --idempotent --yes --upgrade || ./listmonk --static-dir=./static --install --yes --upgrade
