FROM debian:stable
MAINTAINER Samuel Bernard "samuel.bernard@gmail.com"

# Let's run stuff
RUN \
# Classic yum update
  apt-get update; apt-get dist-upgrade -y; apt-get install dialog -y; \
  apt-get install systemd -y; \
# Mask failing services
  systemctl mask -- \
    sys-fs-fuse-connections.mount \
    dev-hugepages.mount \
    systemd-tmpfiles-setup.service \
    systemd-hostnamed.service; \
# Useful packages
  apt-get install -y iproute2 sudo less vim tree curl dmidecode gpg procps; \
# Basic latest chef install
  curl -L https://omnitruck.chef.io/install.sh | bash; \
  ln -s /opt/chef/bin/chef-client /bin/chef-client; \
# Installing Busser
  GEM_HOME="/tmp/verifier/gems" \
  GEM_PATH="/tmp/verifier/gems" \
  GEM_CACHE="/tmp/verifier/gems/cache" \
  /opt/chef/embedded/bin/gem install busser --no-document \
    --no-format-executable -n /tmp/verifier/bin --no-user-install; \
# Busser plugins
  GEM_HOME="/tmp/verifier/gems" \
  GEM_PATH="/tmp/verifier/gems" \
  GEM_CACHE="/tmp/verifier/gems/cache" \
  /opt/chef/embedded/bin/gem install \
    busser-serverspec serverspec --no-document; \
# Webmock can be very useful to test cookbooks
  GEM_HOME="/tmp/verifier/gems" \
  GEM_PATH="/tmp/verifier/gems" \
  GEM_CACHE="/tmp/verifier/gems/cache" \
  /opt/chef/embedded/bin/gem install \
    webmock --no-document; \
# Last command, clean all
  apt-get clean autoclean

VOLUME ["/sys/fs/cgroup", "/run", "/run/lock"]
CMD  ["/lib/systemd/systemd"]
