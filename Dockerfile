# Étape 1 : build
FROM node:18 AS build
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

# Étape 2 : run
FROM node:18
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY package.json .
COPY yarn.lock .
RUN yarn install --production
EXPOSE 3000
CMD ["node", "dist/index.js"]