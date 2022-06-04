# RedM Development Container

## Summary

*An Ubuntu container configured for RedM Linux development. This devcontainer is based on the [Microsoft Ubuntu devcontainer](https://github.com/microsoft/vscode-dev-containers/tree/main/containers/ubuntu).*

| Metadata | Value |  
|----------|-------|
| *Definition type* | Docker Compose |
| *Available image variants* | ubuntu-22.04 / jammy, ubuntu-20.04 / focal, ubuntu-18.04 / bionic ([full list](https://mcr.microsoft.com/v2/vscode/devcontainers/base/tags/list)) |
| *Available CFX server variants* | latest-recommended, latest-optional, latest, *<version_number>* ([full list](https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/)) |
| *Available CFX base resources variants* | latest, *<commit_hash>* ([full list](https://github.com/citizenfx/cfx-server-data/commits/master)) |
| *Works in Codespaces* | Yes |
| *Container host OS support* | Linux, macOS, Windows |
| *Container OS* | Ubuntu |

## Important Notes

This devcontainer only provides the CFX server and resource files. It does not contain a pre-configured and ready game server. For set-up and configuration please refer to the [official documentation](https://docs.fivem.net/docs/server-manual/setting-up-a-server-vanilla/#linux).

**Do note** that some configuration needs to be changed from the defaults in order for it to work with GitHub Codespaces. These are as followed:

### Configuring endpoints in server.cfg

It seems that the default port (`30120`) that CFX server is already in use when trying to build the containers. Which is why we'll use a different port to prevent conflicting ports. In your `server.cfg` the following fields `endpoint_add_tcp` and `endpoint_add_udp` should contain the port `30125`.

```c
endpoint_add_tcp "0.0.0.0:30125"
endpoint_add_udp "0.0.0.0:30125"
```
### Tunneling 

It seems that GitHub Virtual Codespaces does not support forwarding UDP ports out of codespaces. This is why we'll use the **Remote UDP Tunnel** extension to forward our UDP ports. This extension comes pre-installed with the devcontainer. A port can be forwarded by running the `Remote UDP Tunnel: Forward a Port` command, which can be accessed via the **Command Palette**. 

Press <kbd>F1</kbd><sup> 1<sup> and run `Remote UDP Tunnel: Forward a Port`, which in turn will give a prompt where you can fill the `30125` port in.

[1] Command Palette can also be accessed via **<kbd>ctrl</kbd> + <kbd>shift</kbd> + <kbd>p</kbd>** on *Windows* and **<kbd>⌘</kbd> + <kbd>shift</kbd> + <kbd>p</kbd>** on *Mac*.

### Connecting the the development server

When you have configured your server correctly and the additional configurations (as mentioned above) you should be able to connect in-game to the server by pressing <kbd>F8</kbd> and running `connect 127.0.0.1:30125`.

## Using this definition

While the definition itself works unmodified, you can select specify the version of Ubuntu, CFX server, CFX resources and CFX path in your container. 

These can be changed by updating the values `VARIANT`, `SERVER_VERSION`, `RESOURCES_VERSION` and `CFX_PATH` args in the included `devcontainer.json` (and rebuilding if you've already created the container).


```json
"args": { 
    "VARIANT": "ubuntu-18.04",
    "SERVER_VERSION": "latest-recommended",
    "RESOURCES_VERSION": "latest",
    "CFX_PATH": "/home/vscode/cfx"
 }
```

Besides the main Ubuntu container a MariaDb Container has also be configured, which can be accesed via:

```bash
mariadb -umariadb -pmariadb -h db
```
The MariaDb configuration such as username, password, database, etc.. can be changed in the `docker-compose.yml` file.

The Ubuntu container also includes `git`, `node:12`, pre-installed VS Code extensions for UDP tunneling and a non-root `vscode` user with `sudo` access, and a set of common dependencies for development.

### Adding the definition to a project or codespace

1. If this is your first time using a development container, please see getting started information on [setting up](https://aka.ms/vscode-remote/containers/getting-started) Remote-Containers or [creating a codespace](https://aka.ms/ghcs-open-codespace) using GitHub Codespaces.

2. To use the pre-built image:
   1. Start VS Code and open your project folder or connect to a codespace.
   2. Press <kbd>F1</kbd> select and **Add Development Container Configuration Files...** command for **Remote-Containers** or **Codespaces**.
   4. Select this definition. You may also need to select **Show All Definitions...** for it to appear.

3. To build a custom version of the image instead:
   1. Clone this repository locally.
   2. Start VS Code and open your project folder or connect to a codespace.
   3. Use your local operating system's file explorer to drag-and-drop the locally cloned copy of the `.devcontainer` folder for this definition into the VS Code file explorer for your opened project or codespace.
   4. Update `.devcontainer/devcontainer.json` to reference `"dockerfile": "base.Dockerfile"`.

4. After following step 2 or 3, the contents of the `.devcontainer` folder in your project can be adapted to meet your needs.

5. Finally, press <kbd>F1</kbd> and run **Remote-Containers: Reopen Folder in Container** or **Codespaces: Rebuild Container** to start using the definition.

## License

Copyright (c) Microsoft Corporation. All rights reserved.

Licensed under the MIT License. See [LICENSE](https://github.com/microsoft/vscode-dev-containers/blob/main/LICENSE)
