# Running systemd in Docker
## Background
The systemd developers and the Docker developers have different philosophies in life. With that said there are many advantages to running systemd in docker. You can find some further reading [here](https://developers.redhat.com/blog/2016/09/13/running-systemd-in-a-non-privileged-container/).

## Bulding and running
Included here are strips `build.sh` to build a systemd based Docker image and `run.sh` to run the resulting image. `run.sh` does not grant the container any extra permissions (eg, `--cap-add SYS_ADMIN`). Because of this systemd will complain about not being able to unmount some stuff on shutdown but otherwise works:
```
[FAILED] Failed unmounting /etc/hosts.
[FAILED] Failed unmounting /etc/resolv.conf.
[FAILED] Failed unmounting /tmp.
[FAILED] Failed unmounting /etc/hostname.
```

Adding `--cap-add SYS_ADMIN` fixes the error but is not necessary. You probably want to think twice before doing this:
* [CAP_SYS_ADMIN: the new root](https://lwn.net/Articles/486306/)
* [capabilities(7)](https://linux.die.net/man/7/capabilities)

## Attaching to a running container
```
docker exec -it running_systemd bash
```

# Licenses
## Solita
This is based off of work by [Solita](https://github.com/solita/docker-systemd/blob/master/Dockerfile):
```
The MIT License (MIT)

Copyright (c) 2016 Solita

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

## Julien Reichardt

This is based off of work by [Julien Reichardt](https://github.com/j8r/dockerfiles/blob/master/systemd/ubuntu/Dockerfile-18.04):
```
ISC License

Copyright (c) 2018-2019 Julien Reichardt <mi@jrei.ch>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

## This work
This work is licensed under the MIT license (included [here](./LICENSE))
