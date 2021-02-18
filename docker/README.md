* How to use
	docker build -t test -c </path/to/file/Dockfile> .				--squash (experimental, but not usefaul)
	docker run -u 0 -it --rm <image_id>												run as user 0(root)

* for systemctl but not working at last
	-v /sys/fs/cgroup:/sys/fs/cgroup:ro
	--cap-add=SYS_ADMIN
	--security-opt seccomp:unconfined
	-e "container=docker" # useless?
	--privileged=true
	-v /bin/systemctl:/bin/systemctl # useless
	-v /run/systemd/system:/run/systemd/system
	-v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket (solve **dbus connection error** for ubuntu)
	(for debian, use /etc/init.d/avahi-daemon start)

* lineanu/LibcSearcher and matrix1001/glibc-all-in-one are large repo,
	suggest install them on local machine instead of loading them in docker

* alpine is good and tiny, but something(e.g. system service or some package for compiling) go wrong, definitely better for developing.
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
	apk add --no-cache py-pi (package for python2/3-pip)
