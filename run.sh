#!/bin/bash

docker run --rm -t \
	--privileged \
	--sysctl net.ipv6.conf.lo.disable_ipv6=0 \
	-v $(pwd)/vyos-build:/vyos \
	-v /dev:/dev \
	-w /vyos \
	--entrypoint /vyos/entrypoint.sh \
vyos/vyos-build:current
