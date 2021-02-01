# Create an environment variable that contains the main Z80 project directory
Z80_HOME=$(dirname $(readlink -f $0))

# Check if microblaze has been build
if [ ! -d $Z80_HOME/tools/setup/microblazeel-xilinx-elf ]
then
	# If not, build it
	$Z80_HOME/tools/setup/microblaze.sh $Z80_HOME/tools/setup
fi

# Set the path
PATH=$Z80_HOME/bin:$Z80_HOME/tools/setup/microblazeel-xilinx-elf/bin:$PATH
