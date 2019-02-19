FROM node:alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# The directory we care about is /app/build

# The FROM statement stops the previous block
FROM nginx
# /user/share/nginx/html is the recommended directory for nginx
COPY --from=builder /app/build /user/share/nginx/html
# We don't need to explicitely execute anything. nginx will do the rest.
