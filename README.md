# Docker-Gollum

## Usage

With Docker run:

```bash
docker run \
    --rm \
    --name=golum \
    -e PUID=1000 \
    -e PGID=1000 \
    -p 4567:4567 \
    -v </path/to/your/share>:/wiki \
    cgspeck/gollum:latest
```

You can also add the following commands to the end of the run command to  change the way it behaves:

**`console`**

Bring up a bash terminal within the container.

**`root`**

Bring up a root terminal within the container.

## Ports

Port | Function
--- | ---
4567 | Gollum server


## Volumes

Volume | Function
--- | ---
`/wiki` | Git repository for this wiki

## Parameters

Parameter | Function
--- | ---
-e PUID=1000 | User ID
-e PGID=1000 | Group ID
-e GOLLUM_OPTIONS="--h1-title --allow-uploads --live-preview" | Options to pass to Gollum, detailed [here](https://github.com/gollum/gollum#configuration)
-e GOLLUM_AUTHOR_USERNAME="Gollum User" | Username to put on the git commits
-e GOLLUM_AUTHOR_EMAIL="gollum@example.org" | Email to put on the git commits

### User / Group Identifiers

You can specify user ID and group IDs for use in the container to avoid permission issues between the container and the host.

Ensure any volume directories on the host are owned by the same user you specify.

You can use `id` to find your user id and group id:

```
$ id foo
uid=1000(foo) gid=1000(foo)
```

## Credits/thank you

`wrapper.rb` from [gollum-portable](https://github.com/pjeby/gollum-portable) by [PJ Eby](https://github.com/pjeby)
