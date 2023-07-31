# TODO: Add a good headewr here
# TODO: See if i can yank the vagrant keys for this so it can connect to the correct vagrant things. Also see if passwords can be sent in this. Maybe env vars?

FROM alpine:latest

# Install dependencies
RUN apk update && \
    apk upgrade &&  \
    apk add --no-cache --update ansible libffi-dev py-netaddr openssh sshpass zip
# Initialize
RUN mkdir -p /etc/ansible
RUN mkdir -p /playbooks
WORKDIR /playbooks

# RUN
