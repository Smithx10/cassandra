FROM centos:7

COPY ./etc/cassandra.repo /etc/yum.repos.d/cassandra.repo

RUN yum update -y \
		&& yum install -y \
			cassandra \
			curl \
			openjdk-8-jre-headless \
			unzip \
			which \
		&& yum clean all

# # Install Consul
# # Releases at https://releases.hashicorp.com/consul
# # Add Consul and set its configuration
# RUN export CONSUL_VER=0.9.0 \
#     && export CONSUL_PKG=consul_${CONSUL_VER}_linux_amd64.zip \
#     && export CONSUL_URL=https://releases.hashicorp.com/consul/${CONSUL_VER}/${CONSUL_PKG} \
#     && export CONSUL_SHA1=345efaf9b055c92caf6221a5d58d84e96acddf24 \
#     && curl -Ls --fail -o /tmp/${CONSUL_PKG} ${CONSUL_URL} \
#     && echo "${CONSUL_SHA1} /tmp/${CONSUL_PKG}" | sha1sum -c \
#     && unzip /tmp/${CONSUL_PKG} -d /usr/local/bin \
#     && rm /tmp/${CONSUL_PKG} \
#     && mkdir /etc/consul \
#     && mkdir /var/lib/consul \
#     && mkdir /data \
#     && mkdir /config
#
# # Install Consul template
# # Releases at https://releases.hashicorp.com/consul-template/
# RUN export CT_VER=0.19.0 \
#     && export CT_PKG=consul-template_${CT_VER}_linux_amd64.zip \
#     && export CT_URL=https://releases.hashicorp.com/consul-template/${CT_VER}/${CT_PKG} \
#     && export CT_SHA1=52e1c81a66ac63444321b0361baee46d34988505 \
#     && curl -Ls --fail -o /tmp/${CT_PKG} ${CT_URL} \
#     && echo "${CT_SHA1} /tmp/${CT_PKG}" | sha1sum -c \
#     && unzip /tmp/${CT_PKG} -d /usr/local/bin \
#     && rm /tmp/${CT_PKG}
#
# # Add Containerpilot and set its configuration
# ENV CONTAINERPILOT_VER=3.3.0
# ENV CONTAINERPILOT=/etc/containerpilot.json5
# RUN export CP_VER=3.3.0 \
#     && export CP_PKG=containerpilot-${CP_VER}.tar.gz \
#     && export CP_SHA1=62621712ef6ba755e24805f616096de13e2fd087 \
#     && export CP_URL=https://github.com/joyent/containerpilot/releases/download/${CP_VER}/${CP_PKG} \
#     && curl -Ls --fail -o /tmp/${CP_PKG} ${CP_URL} \
#     && echo "${CP_SHA1} /tmp/${CP_PKG}" | sha1sum -c \
#     && tar zxf /tmp/${CP_PKG} -C /usr/local/bin \
#     && rm /tmp/${CP_PKG}

# ref https://www.rethinkdb.com/docs/config-file/
# Add Configs and Binaries
# COPY etc/containerpilot.json5 /etc
# COPY bin /bin
