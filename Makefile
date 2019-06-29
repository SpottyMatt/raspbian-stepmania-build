.PHONY: all
all:
	$(MAKE) system-prep
	$(MAKE) stepmania-prep
	$(MAKE) stepmania-build
	$(MAKE) stepmania-install

.PHONY: build-only
build-only:
	$(MAKE) build-prep
	$(MAKE) stepmania-prep
	$(MAKE) stepmania-build

.PHONY: system-prep
system-prep:
	$(MAKE) build-prep

.PHONY: build-prep
build-prep:
	sudo sed -i 's/#deb-src/deb-src/g' /etc/apt/sources.list
	sudo apt-get update
	sudo apt-get install -y \
		binutils-dev \
		build-essential \
		cmake \
		ffmpeg \
		libasound-dev \
		libbz2-dev \
		libc6-dev \
		libcairo2-dev \
		libgdk-pixbuf2.0-dev \
		libglew1.5-dev \
		libglib2.0-dev \
		libglu1-mesa-dev \
		libgtk2.0-dev \
		libjack0 \
		libjack-dev \
		libjpeg-dev \
		libmad0-dev \
		libogg-dev \
		libpango1.0-dev \
		libpng-dev \
		libpulse-dev \
		libudev-dev \
		libva-dev \
		libvorbis-dev \
		libxrandr-dev \
		libxtst-dev \
		mesa-common-dev \
		mesa-utils \
		yasm \
		zlib1g-dev
	sudo apt-get autoremove -y
	sudo mkdir -p /usr/local/stepmania-5.1
	sudo chmod a+rw /usr/local/stepmania-5.1


.PHONY: stepmania-prep
.ONESHELL:
stepmania-prep:
	git submodule init
	git submodule update
	cd stepmania
	git submodule init
	git submodule update
	git apply ../stepmania-build/raspi-3b-arm.patch && git commit --author="raspian-3b-stepmania-arcade <SpottyMatt@gmail.com>" -a -m "Patched to enable building on ARM processors with -DARM_CPU=XXX -DARM_FPU=XXX"
	cmake -G "Unix Makefiles" \
	        -DWITH_CRASH_HANDLER=0 \
	        -DWITH_SSE2=0 \
	        -DWITH_MINIMAID=0 \
	        -DWITH_FULL_RELEASE=1 \
		-DCMAKE_BUILD_TYPE=Release \
	        -DARM_CPU=cortex-a53 \
		-DARM_FPU=neon-fp-armv8
	cmake .
	git reset --hard HEAD^

.PHONY: stepmania-build
stepmania-build:
	$(MAKE) --dir stepmania

.PHONY: stepmania-install
stepmania-install:
	$(MAKE) --dir stepmania install
