# DockerNotes
A poorly named repository. Currently, an example of building a docker image/container for development or testing with your user setup to match the host system, largely via [BoxBoat fixuid](https://github.com/boxboat/fixuid).

## Creating a development image
With `build_image.sh` we create our development image. For example, to create an image based off of Debian Stretch:
```
$ ./build_image.sh debian:stretch debian_stretch_dev
Sending build context to Docker daemon  112.6kB
Step 1/9 : ARG IMAGE_NAME
...
Successfully built 0bfd50e08feb
Successfully tagged debian_stretch_dev:latest
```

In this example `debian:stretch` is the `stretch` tag of the official [debian](https://hub.docker.com/_/debian/) image and `debian_stretch_dev` is an arbitrary name that we made up for the image that we are creating. We optionally could have specified a tag with the normal `image:tag` format.

## Creating the development container
Now that we have a development image, let's create a development container to actually build, debug, or test code in with `create_container_and_run.sh`:
```
$ ./create_container_and_run.sh debian_stretch_dev debian_stretch_dev_container /work/docker_work
5cd188c52813d2e059f484eaa484f32039ae677fd920680c9086db7a2ad968fa
```

In this example `debian_stretch_dev` is the name of our development image (above), `debian_stretch_dev_container` is an arbitrary name for our container and `/work/docker_work` is an existing directory to [bind-mount](https://docs.docker.com/storage/bind-mounts/) into the docker container.

At this point we can see that our container is actually running:
```
$ docker ps
CONTAINER ID        IMAGE                COMMAND             CREATED             STATUS              PORTS               NAMES
5cd188c52813        debian_stretch_dev   "fixuid bash"       2 minutes ago       Up 2 minutes                            debian_stretch_dev_container
```

At this point we can use `docker attach` to attach to our development container, eg `docker attach debian_stretch_dev_container`. The contents of the host directory which we specified (`/work/docker_work`) is now available as `/work` in the container, with correct file ownership between the host and the container. Any change to this container will be persistent, and if it needs to be restarted in the future that can be accomplished with `docker restart`.

## Closing thoughts
To quote BoxBoat "**DO NOT USE IN PRODUCTION**." Also, `build_image.sh` copies in your `.bashrc` and `.ssh` into the image to be nice, but that means that **your private .ssh keys were copied**. This is great for development inside the container, but you wouldn't want the image or the container to leave your system.
