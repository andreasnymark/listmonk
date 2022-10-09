FROM listmonk/listmonk:latest
ADD static static
ARG PORT ADMIN_PASSWORD ADMIN_USERNAME PGDATABASE PGHOST PGPASSWORD PGPORT PGUSER
COPY config.sh ./config.sh
RUN chmod +x ./config.sh && ./config.sh
RUN chmod +x ./static && ./static
RUN ./listmonk --static-dir=static --idempotent --yes --upgrade || ./listmonk --static-dir=static --install --yes --upgrade
