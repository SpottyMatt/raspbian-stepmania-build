#!/usr/bin/env python
from __future__ import print_function

import subprocess
import sys

class RPIModel:
	def __init__(self, model_name, cpu_rev, model_rev, release_date, cpu_target, fpu_target ):
		"""Create a representation of a Raspi hardware

		Arguments:
		model_name -- the human-readable model name, e.g. "3B"
		cpu_rev -- the CPU revision from /proc/cpuinfo
		model_rev -- the revision within a model_name
		release_date -- YYYYQ as to when the model was released, sortable integers
		cpu_target -- the gcc cpu target to -mtune to
		fpu_target -- the gcc fpu target to -
		"""

		self.model_name = model_name
		self.cpu_rev = cpu_rev
		self.model_rev = model_rev
		self.release_date = release_date
		self.cpu_target = cpu_target
		self.fpu_target = fpu_target

	def __repr__(self):
		return self.model_name + ":" + self.model_rev + ":" + self.release_date + ":" + self.cpu_rev + ":" + self.cpu_target + ":" + self.fpu_target

rpi_models = [
	RPIModel( "3B", "a02082", "1.0", "20161", "cortex-a53", "neon-fp-armv8" ),
	RPIModel( "3B", "a22082", "1.1", "20161", "cortex-a53", "neon-fp-armv8" ),
	RPIModel( "3B", "a32082", "1.2", "20164", "cortex-a53", "neon-fp-armv8" ),
	RPIModel( "3B+", "a020d3", "1.3", "20181", "cortex-a53", "neon-fp-armv8" ),
	RPIModel( "4B", "a03111", "1.1", "20192", "cortex-a72", "neon-fp-armv8" ),
	RPIModel( "4B", "b03111", "1.1", "20192", "cortex-a72", "neon-fp-armv8" ),
	RPIModel( "4B", "c03111", "1.1", "20192", "cortex-a72", "neon-fp-armv8" )
]

cpuinfo = subprocess.Popen(["cat", "/proc/cpuinfo"], stdout=subprocess.PIPE)
found = False

for line in cpuinfo.stdout.readlines():
	fields = line.strip().split()
	if fields and fields[0] == "Revision" :
		revision = fields[2]
		for rpi in rpi_models :
			if rpi.cpu_rev == revision :
				found = True
				print( str( rpi ) )
				break

if not found:
	sys.exit( "Unrecognized system: " + revision )
