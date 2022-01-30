# dump build stage
FROM postgres:13-alpine as dumper

COPY schema.sql /docker-entrypoint-initdb.d/

RUN ["sed", "-i", "s/exec \"$@\"/echo \"skipping...\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV POSTGRES_USER=postgresadmin
ENV POSTGRES_PASSWORD=admin123
ENV PGDATA=/data

RUN ["/usr/local/bin/docker-entrypoint.sh", "postgres"]

# final build stage
FROM postgres:13-alpine

EXPOSE 5432

COPY --from=dumper /data $PGDATA