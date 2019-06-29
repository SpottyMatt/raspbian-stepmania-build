StepMania Rasperry Pi Build
=========================

Scripts & instructions to build [StepMania](https://github.com/stepmania/stepmania) from source on a Rasperry Pi running Raspian.

1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Notes](#notes)

Prerequisites
=========================

**You** must provide the following:

1. A supported [Raspberry Pi model](https://www.raspberrypi.org/products/)
	1. 3B
	2. 3B+
2. An installed & working [Raspbian](https://www.raspberrypi.org/downloads/raspbian/) operating system, Stretch (v9) or later.

Quick Start
=========================

1. Clone this repository
2. Run `make`
3. Wait ~2 hours
4. Look in `/usr/local/stepmania-*`
5. Done!

**Note:** You've just _built_ the Stepmania binary but there's a lot more required to play it well on a Raspberry Pi.
For that, check out [`raspian-stepmania-arcade`](https://github.com/SpottyMatt/raspbian-3b-stepmania-arcade).

Notes
=========================

Building for Other Raspberry Pi Models
-------------------------

If you look at [`raspi-3b-arm.patch`](stepmania-build/raspi-3b-arm.patch), you'll see there are two variables that really matter for building StepMania:

1. `ARM_CPU`
2. `ARM_FPU`

Those are set in the `Makefile` to the correct values for the Raspberry Pi 3B/3B+.

See this excellent gist: [GCC compiler optimization for ARM-based systems](https://gist.github.com/fm4dd/c663217935dc17f0fc73c9c81b0aa845) for more information on compiling with GCC on Raspberry Pi.

In particular, it's got tables of the `ARM_CPU` and `ARM_FPU` values for other Raspberry Pi models.
Who knows, they might work! The regular 3B was just powerful enough to run StepMania acceptably; older models may struggle to perform.

Edit your `Makefile` and give it a try!

StepMania Source
-------------------------

This uses a working commit from the [`5_1-new`](https://github.com/stepmania/stepmania/tree/5_1-new) branch of StepMania as the source code.

If you want to try building from a more recent commit, [update the `stepmania` submodule](https://stackoverflow.com/questions/5828324/update-git-submodule-to-latest-commit-on-origin/5828396#5828396) before building and installing.

Previously, this repository used the (unmaintained) StepMania 5.2 code from the tip of the `master` branch.
If for some reason you want to set up _that_ StepMania, the old code has been preserved in the [`StepMania-5.2` branch](https://github.com/SpottyMatt/raspbian-3b-stepmania-arcade/tree/StepMania-5.2) of this repository.
