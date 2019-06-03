docker-debian-systemd-kitchen
=============================

Docker image for a Debian with a working Systemd, provisionned with Chef
to be used in Test Kitchen.

Test it easily with:

    # Get the image
    docker pull chefplatform/debian-systemd-kitchen
    # Run it (do not forget cgroup volume for systemd)
    docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name dsk \
      chefplatform/debian-systemd-kitchen
    # Open a shell in it, you can try 'systemctl' for instance
    docker exec -it dsk bash -c 'TERM=xterm bash'
    # Kill and remove the container
    docker kill dsk; docker rm dsk
