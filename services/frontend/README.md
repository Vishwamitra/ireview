# Run locally. These are notes and might be deleted later

## Build image
```docker build -t front-end .```

## Build image
```docker run -d -p [my-port]:80 --name [name] -v $(pwd):/usr/share/nginx/html front-end```