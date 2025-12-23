#!/bin/bash

docker run --rm -it \
	--privileged \
	--sysctl net.ipv6.conf.lo.disable_ipv6=0 \
	-v $(pwd)/vyos-build:/vyos \
	-v /dev:/dev \
	-w /vyos \
vyos/vyos-build:current bash
