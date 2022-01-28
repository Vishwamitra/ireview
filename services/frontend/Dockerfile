FROM node:14-slim as ui-builder
WORKDIR /home/ui
COPY . .

# install and build
RUN npm install
ARG REACT_APP_BACKEND_URL
ENV REACT_APP_BACKEND_URL $REACT_APP_BACKEND_URL
RUN npm run build

# nginx deploy
FROM nginx
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=ui-builder /home/ui/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]