FROM node:14-alpine as build

ARG USER=node
WORKDIR /app

COPY --chown=$USER:$USER package*.json .
COPY --chown=$USER:$USER index.js .

RUN npm install --production

FROM node:14-alpine

ARG USER=node
WORKDIR /app

COPY --from=build --chown=$USER:$USER /app/package.json .
COPY --from=build --chown=$USER:$USER /app/index.js ./
COPY --from=build --chown=$USER:$USER /app/node_modules node_modules

USER $USER

EXPOSE 3000

CMD ["npm","start"]



