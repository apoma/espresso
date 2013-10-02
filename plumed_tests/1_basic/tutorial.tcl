puts "[code_info]"

set l_poly  40
set n_ci    $l_poly
set n_part  [expr $l_poly+$n_ci]
set density 0.001

set volume     [expr $n_part/$density] 
set box_length [expr pow($volume,1.0/3.0)]

puts "Simulate PE Solution N=$l_poly at density $density"
puts "Simulation box: $box_length"

setmd box_l $box_length $box_length $box_length
setmd time_step 0.01
setmd skin 0.4
integrate set nvt
thermostat langevin 1.0 1.0

puts [setmd box_l]
puts [setmd time_step]
puts [setmd skin]
puts [integrate]
puts [thermostat]

inter 0 fene 7.0 2.0
inter 0 0 lennard-jones 1.0 1.0 1.12246 0.25 0.0
inter 0 1 lennard-jones 1.0 1.0 1.12246 0.25 0.0
inter 1 1 lennard-jones 1.0 1.0 1.12246 0.25 0.0

#polymer 1 $l_poly 1.0 start 0 charge 1.0 types 0 0 FENE 0
#counterions $n_ci start [setmd n_part] charge -1.0 type 1 
polymer 1 $l_poly 1.0 start 0 charge 0.0 types 0 0 FENE 0
counterions $n_ci start [setmd n_part] charge 0.0 type 1 
 
 
puts [part 10] 
puts [part 50] 

set vmd "no"

if { $vmd == "yes" } {
    prepare_vmd_connection tutorial start wait 3000 ignore_charges
    imd positions
}

set min 0
set cap 10
while { $min < 0.8 } {
    # set forcecap
    inter forcecap $cap
    # integrate a number of steps, e.g. 20
    integrate 20
    # check the status of the sytem
    set min [analyze mindist]
    # this is a shortcut for 'set cap [expr $cap+10]'
    incr cap 10
}
puts "Warmup finished. Minimal distance now $min"
# turn off the forcecap, which is done by setting the 
# force cap value to zero:
inter forcecap 0

#inter coulomb 1 p3m 13.9629 8 3 0.127621 0.000832468

#puts "[inter coulomb 1.0 p3m tune accuracy 0.001 mesh 8]"

set n_cycle 100
set n_steps 100

set f [open "test.vtf" w]
writevsf $f

setmd plumedison 1
setmd plumedfile plumed.dat
set plumed_input [open "plumed.dat" "w"] 
puts  $plumed_input "d1: DISTANCE ATOMS=1,40" 
puts  $plumed_input "PRINT ARG=* STRIDE=50 FILE=COLVAR" 
close $plumed_input
#
# this is where plumed is applied
#
set i 0 
while { $i<$n_cycle } {
    integrate $n_steps

    if { $vmd == "yes" } { imd positions }

    writevcf $f
    incr i
}

close $f
