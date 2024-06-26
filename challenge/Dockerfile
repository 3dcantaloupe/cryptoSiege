# sudo docker build -t system_health_check .
# sudo docker run -d -p 1024:1024 --rm -it system_health_check


# FROM ubuntu:22.04 as base
FROM ubuntu:19.10

# ### Stage 1 - add/remove packages ###

# # Ensure scripts are available for use in next command
# COPY ./container/root/scripts/* /scripts/
# COPY ./container/root/usr/local/bin/* /usr/local/bin/

# # - Symlink variant-specific scripts to default location
# # - Upgrade base security packages, then clean packaging leftover
# # - Add S6 for zombie reaping, boot-time coordination, signal transformation/distribution: @see https://github.com/just-containers/s6-overlay#known-issues-and-workarounds
# # - Add goss for local, serverspec-like testing
# RUN /bin/bash -e /scripts/ubuntu_apt_config.sh && \
#     /bin/bash -e /scripts/ubuntu_apt_cleanmode.sh && \
#     ln -s /scripts/clean_ubuntu.sh /clean.sh && \
#     ln -s /scripts/security_updates_ubuntu.sh /security_updates.sh && \
#     echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
#     /bin/bash -e /security_updates.sh && \
#     apt-get install -yqq \
#       curl \
#       gpg \
#       apt-transport-https \
#     && \
#     /bin/bash -e /scripts/install_s6.sh && \
#     /bin/bash -e /scripts/install_goss.sh && \
#     apt-get remove --purge -yq \
#         curl \
#         gpg \
#     && \
#     /bin/bash -e /clean.sh

# # Overlay the root filesystem from this repo
# COPY ./container/root /


# ### Stage 2 --- collapse layers ###

# FROM scratch
# COPY --from=base / .

# # Use in multi-phase builds, when an init process requests for the container to gracefully exit, so that it may be committed
# # Used with alternative CMD (worker.sh), leverages supervisor to maintain long-running processes
# ENV SIGNAL_BUILD_STOP=99 \
#     S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
#     S6_KILL_FINISH_MAXTIME=5000 \
#     S6_KILL_GRACETIME=3000

# RUN goss -g goss.base.yaml validate

# # NOTE: intentionally NOT using s6 init as the entrypoint
# # This would prevent container debugging if any of those service crash





RUN apt-get update

RUN useradd -d /home/ctf/ -m -p ctf -s /bin/bash ctf
RUN echo "ctf:ctf" | chpasswd

WORKDIR /home/ctf

COPY system_health_check .
COPY flag .
COPY ynetd .

RUN chown -R root:root /home/ctf
# CMD ["/bin/bash", "/run.sh"]
# RUN 

USER ctf
EXPOSE 1024
CMD ./ynetd -p 1024 ./system_health_check
