Compile StepMania on Raspberry Pi
=========================

![StepMania Raspberry Pi Build](stepmania-build.png)

Scripts & instructions to build [StepMania](https://github.com/stepmania/stepmania) from source on a Rasperry Pi running Raspian.

There is a lot more required to make StepMania actually _playable_ on a Raspberry Pi.
If all you want to do is play StepMania, check out
[`raspbian-stepmania-arcade`](https://github.com/SpottyMatt/raspbian-stepmania-arcade) instead.

1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Notes](#notes)

Prerequisites
=========================

**You** must provide the following:

1. A supported [Raspberry Pi model](https://www.raspberrypi.org/products/)
	1. 3B
	2. 3B+
	3. 4B
2. An installed & working [Raspbian](https://www.raspberrypi.org/downloads/raspbian/) operating system, Stretch (v9) or later.

Quick Start
=========================

1. Clone this repository
2. Run `make`
3. Wait a while
	1. ~2 hours for Rpi 3B
	2. ~30 minutes for Rpi 4
4. Look in `/usr/local/stepmania-*`
5. Done!

**Note:** You've just _built_ the Stepmania binary but there's a lot more required to play it well on a Raspberry Pi.
For that, check out [`raspbian-stepmania-arcade`](https://github.com/SpottyMatt/raspbian-stepmania-arcade).

Notes
=========================

Building for Other Raspberry Pi Models
-------------------------

If you look at [`sm-arm.patch`](stepmania-build/sm-arm.patch), you'll see there are two variables that really matter for building StepMania:

1. `ARM_CPU`
2. `ARM_FPU`

See this excellent gist: [GCC compiler optimization for ARM-based systems](https://gist.github.com/fm4dd/c663217935dc17f0fc73c9c81b0aa845) for more information on compiling with GCC on Raspberry Pi.

In particular, it's got tables of the `ARM_CPU` and `ARM_FPU` values for other Raspberry Pi models.
Who knows, they might work! The regular 3B was just powerful enough to run StepMania acceptably; older models may struggle to perform.

Edit your `Makefile` and give it a try!

Or, just run

	make ARM_CPU=... ARM_FPU=...

Supporting Other Raspberry Pi Models
-------------------------

This repository uses the [SpottyMatt/rpi-hw-info](https://github.com/SpottyMatt/rpi-hw-info) repository to decode Raspberry Pi hardware information and figure out the correct compiler flags.

If you manage to get this to compile on a new Raspberry Pi model, make sure that repository is capable of correctly-detecting the new Pi, and reports the correct CPU and FPU compile targets.

Then, update the `rpi-hw-info` submodule in this repo and you're done! This repo now supports compiling for the new Raspberry Pi hardware.

StepMania Source
-------------------------

This uses a working commit from the [`5_1-new`](https://github.com/stepmania/stepmania/tree/5_1-new) branch of StepMania as the source code.
Probably the latest 5.1 _release_.

If you want to try building from a more recent commit, [update the `stepmania` submodule](https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin/5828396#5828396) before building and installing.
