FROM listmonk/listmonk:latest
ARG PORT ADMIN_PASSWORD ADMIN_USERNAME PGDATABASE PGHOST PGPASSWORD PGPORT PGUSER
COPY static ./static
RUN chmod -R 755 ./static
COPY config.sh ./config.sh
RUN chmod +x ./config.sh && ./config.sh
RUN ./listmonk --static-dir=static --idempotent --yes --upgrade || ./listmonk --static-dir=static --install --yes --upgrade
