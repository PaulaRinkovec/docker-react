# prva faza, tj. prvi build step (imena builder)
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# druga faza, tj. drugi build step (nismo joj dali ime, idk zasto)
FROM nginx
# kopiraj /app/build iz builder faze u /usr/share/nginx/html
# (sve ostalo iz prosle faze ce se zapravo izbrisati, tj. nece
# se skopirati u ovu fazu, npr. ne cemo sve one dependencies skopirati)
COPY --from=builder /app/build /usr/share/nginx/html
# ne trebamo pisati RUN jer je dafaultna naredba za nginx
# image (tj. container) naredba koja pokrece nginx tak da
# ne moramo mi specificirati naredbu da bi nam se pokrenuo nginx