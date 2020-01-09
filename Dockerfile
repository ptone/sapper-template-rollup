FROM mhart/alpine-node:12

# install dependencies
WORKDIR /app
COPY package.json ./
# RUN npm init -y
RUN npm i
# Run npm ci --production
COPY . .
RUN npm run build

###
# Only copy over the Node pieces we need
# ~> Saves 35MB
###
FROM mhart/alpine-node:slim-12

WORKDIR /app
COPY --from=0 /app .
COPY . .
ENV PORT=8080
EXPOSE 8080
CMD ["node", "__sapper__/build"]
