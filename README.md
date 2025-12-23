## VYOS COMPILE
This repo documents steps taken to compile and deploy the latest rolling vyos images.  
These steps are based on https://docs.vyos.io/en/1.4/contributing/build-vyos.html

### compile new images
The following steps result in compiled vyos image in all 3 formats: [`raw`, `qcow2`, `iso`]  
Requires `docker` and `git` on the machine.  

#### clone vyos-build
```
git clone -b current --single-branch https://github.com/vyos/vyos-build
```

#### prepare new `custom.yaml` file with desired formats and packages
```
image_format = ["iso", "raw", "qcow2"]
packages = ["qemu-guest-agent", "cloud-init", "google-guest-agent"]
```

#### copy `custom.yaml` to folder
```
cp custom.toml vyos-build/data/build-flavors/
```

#### start build container with privileged permissions
```
docker run --rm -it \
	--privileged \
	--sysctl net.ipv6.conf.lo.disable_ipv6=0 \
	-v $(pwd)/vyos-build:/vyos \
	-v /dev:/dev \
	-w /vyos \
vyos/vyos-build:current bash
```

#### run compile script - using `custom.toml`
```
make clean
./build-vyos-image custom --architecture amd64 --build-by "j.randomhacker@vyos.io"
exit
```

*NOTE:*  
This is a long running compile process and will take 10-15 minutes to complete.
Final images will be located in `vyos-build/build/`  

#### loopback errors
Depending on your setup, you may experience mount errors for kernel loopbacks during compile.  
You can check what loop mounts exist with:  
```
losetup -a
```

Some troubleshooting steps:
- Ensure `--privileged` is set
- Ensure `/dev` is mounted into container
- Conflicts with `snapd` on host, disable/remove if not in use
