# Compile ROM
(cd FIRMWARE; ./makeit.sh)

PROJECTNAME=nanorv
VERILOGS="$PROJECTNAME.v"
echo ======== Yosys
yosys -p "ice40_braminit" -p "synth_ice40 -top $PROJECTNAME -json $PROJECTNAME.json" $VERILOGS -p "write_verilog test_$PROJECTNAME.v" || exit
echo ======== NextPNR
nextpnr-ice40 --force --json $PROJECTNAME.json --pcf $PROJECTNAME.pcf --asc $PROJECTNAME.asc --freq 12 --hx1k --package tq144 $1 || exit
echo ======== IceTime
icetime -p $PROJECTNAME.pcf -P tq144 -r $PROJECTNAME.timings -d hx1k -t $PROJECTNAME.asc
echo ======== IcePack
icepack $PROJECTNAME.asc $PROJECTNAME.bin || exit
echo ======== IceProg
iceprog $PROJECTNAME.bin || exit
echo DONE.


