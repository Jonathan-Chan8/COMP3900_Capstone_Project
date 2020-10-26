FROM node:alpine
LABEL description="Instant high-performance GraphQL API for your PostgreSQL database https://github.com/graphile/postgraphile"

# PostGraphile connection filter plugin
RUN npm install -g postgraphile@latest
RUN npm install -g postgraphile-plugin-connection-filter@latest

EXPOSE 5000

# exec format, which means command in docker-compose.yml fill
# will be appended
ENTRYPOINT ["postgraphile", "-n", "0.0.0.0"]