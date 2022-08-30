# Moment resistance frame analysis with loateral load  
# by prasanna dinesh (www.linkedin.com/in/prasanna-dinesh-bandara)
# Reference: Acun, B. ed., 2012. Eurocode 8: Seismic design of buildings, worked examples. Publications Office of the European Union. 
# Reference: Luis Fernando Gutiérrez Urzúa (OpenSees - Your first OpenSees model)
# Units: length - m; weight - KN; time - s; mass - tons

wipe 

#--------------------------------------------------------------------------------------------------------
# SetUP work place
#--------------------------------------------------------------------------------------------------------

set numModes 2
# create data directory
file mkdir modes; 

model BasicBuilder -ndm 2 -ndf 3;

set gravityanalysis on; # on / off
set modalanalysis on;   # on / off

#--------------------------------------------------------------------------------------------------------
# Define Global geometry 
#--------------------------------------------------------------------------------------------------------
    set Span 8;
    set Story 2.9;

#   Grid lines 
    #horizontal axes, x
    set x0 [expr 0.0];
    set x1 [expr $x0+$Span];
    set x2 [expr $x1+$Span];
    set x3 [expr $x2+$Span];

    #vertical axes, y
    set y0 [expr 0.0];
    set y1 [expr $y0+$Story];
    set y2 [expr $y1+$Story];
    set y3 [expr $y2+$Story];
    set y4 [expr $y3+$Story];
    set y5 [expr $y4+$Story];
    set y6 [expr $y5+$Story];
    
#--------------------------------------------------------------------------------------------------------
# Define node numbers  
#--------------------------------------------------------------------------------------------------------    

#   Node_tag    Node 
set A0          1;      set B0          2;      set C0          3;      set D0          4;      set A1          5;
set B1          6;      set C1          7;      set D1          8;      set A2          9;      set B2          10;
set C2          11;     set D2          12;     set A3          13;     set B3          14;     set C3          15;
set D3          16;     set A4          17;     set B4          18;     set C4          19;     set D4          20;
set A5          21;     set B5          22;     set C5          23;     set D5          24;     set A6          25;
set B6          26;     set C6          27;     set D6          28;

#--------------------------------------------------------------------------------------------------------
# Assign node coordinates 
#--------------------------------------------------------------------------------------------------------

#     node_tag  node_coord      
node    $A0  $x0 $y0;       node    $B0  $x1 $y0;       node    $C0  $x2 $y0;       node    $D0  $x3 $y0;
node    $A1  $x0 $y1;       node    $B1  $x1 $y1;       node    $C1  $x2 $y1;       node    $D1  $x3 $y1;
node    $A2  $x0 $y2;       node    $B2  $x1 $y2;       node    $C2  $x2 $y2;       node    $D2  $x3 $y2; 
node    $A3  $x0 $y3;       node    $B3  $x1 $y3;       node    $C3  $x2 $y3;       node    $D3  $x3 $y3;
node    $A4  $x0 $y4;       node    $B4  $x1 $y4;       node    $C4  $x2 $y4;       node    $D4  $x3 $y4;
node    $A5  $x0 $y5;       node    $B5  $x1 $y5;       node    $C5  $x2 $y5;       node    $D5  $x3 $y5;
node    $A6  $x0 $y6;       node    $B6  $x1 $y6;       node    $C6  $x2 $y6;       node    $D6  $x3 $y6;

#--------------------------------------------------------------------------------------------------------
# Define restraints (boundary conditions)
#--------------------------------------------------------------------------------------------------------

#   fix    node_tag   (ndf $constrvalues)
fix     $A0       1 1 1;
fix     $B0       1 1 1;
fix     $C0       1 1 1; 
fix     $D0       1 1 1;   


#--------------------------------------------------------------------------------------------------------
# Define geometric transformation for beam and column elements
#--------------------------------------------------------------------------------------------------------

geomTransf  Linear 1;   #beam
geomTransf  PDelta 2;   #column 

# define beam elements 

#--------------------------------------------------------------------------------------------------------
# Define beam elements and assign material properties 
#--------------------------------------------------------------------------------------------------------

# elastic beam - IPE500
set Ab  0.01155;           # m^2 
set Ib  0.0004819853;      # m^4 
set E   200000000;         # KN/m^2 

#element elasticBeamColumn eleID node1 node2 A E Iz geomTransfTag
#beam at level 1
element elasticBeamColumn 1 $A1 $B1 $Ab $E $Ib 1;
element elasticBeamColumn 2 $B1 $C1 $Ab $E $Ib 1;
element elasticBeamColumn 3 $C1 $D1 $Ab $E $Ib 1;
#beam at level 2
element elasticBeamColumn 4 $A2 $B2 $Ab $E $Ib 1;
element elasticBeamColumn 5 $B2 $C2 $Ab $E $Ib 1;
element elasticBeamColumn 6 $C2 $D2 $Ab $E $Ib 1;
#beam at level 3
element elasticBeamColumn 7 $A3 $B3 $Ab $E $Ib 1;
element elasticBeamColumn 8 $B3 $C3 $Ab $E $Ib 1;
element elasticBeamColumn 9 $C3 $D3 $Ab $E $Ib 1;
#beam at level 4
element elasticBeamColumn 10 $A4 $B4 $Ab $E $Ib 1;
element elasticBeamColumn 11 $B4 $C4 $Ab $E $Ib 1;
element elasticBeamColumn 12 $C4 $D4 $Ab $E $Ib 1;
#beam at level 5
element elasticBeamColumn 13 $A5 $B5 $Ab $E $Ib 1;
element elasticBeamColumn 14 $B5 $C5 $Ab $E $Ib 1;
element elasticBeamColumn 15 $C5 $D5 $Ab $E $Ib 1;
#beam at level 6
element elasticBeamColumn 16 $A6 $B6 $Ab $E $Ib 1;
element elasticBeamColumn 17 $B6 $C6 $Ab $E $Ib 1;
element elasticBeamColumn 18 $C6 $D6 $Ab $E $Ib 1;

# elastic column - HE340M
set Ac   0.031580;          #m^2 
set Icz  0.0007637168;      #m^4 
set Icy  0.0001971071;      #m^4 

#element elasticBeamColumn eleID node1 node2 A E Iz geomTransfTag
# columns at GL1
element elasticBeamColumn 19 $A0 $A1 $Ac $E $Icy 2;
element elasticBeamColumn 20 $A1 $A2 $Ac $E $Icy 2;
element elasticBeamColumn 21 $A2 $A3 $Ac $E $Icy 2;
element elasticBeamColumn 22 $A3 $A4 $Ac $E $Icy 2;
element elasticBeamColumn 23 $A4 $A5 $Ac $E $Icy 2;
element elasticBeamColumn 24 $A5 $A6 $Ac $E $Icy 2;
# columns at GL2
element elasticBeamColumn 25 $B0 $B1 $Ac $E $Icz 2;
element elasticBeamColumn 26 $B1 $B2 $Ac $E $Icz 2;
element elasticBeamColumn 27 $B2 $B3 $Ac $E $Icz 2;
element elasticBeamColumn 28 $B3 $B4 $Ac $E $Icz 2;
element elasticBeamColumn 29 $B4 $B5 $Ac $E $Icz 2; 
element elasticBeamColumn 30 $B5 $B6 $Ac $E $Icz 2;
# columns at GL3
element elasticBeamColumn 31 $C0 $C1 $Ac $E $Icz 2;
element elasticBeamColumn 32 $C1 $C2 $Ac $E $Icz 2;
element elasticBeamColumn 33 $C2 $C3 $Ac $E $Icz 2;
element elasticBeamColumn 34 $C3 $C4 $Ac $E $Icz 2;
element elasticBeamColumn 35 $C4 $C5 $Ac $E $Icz 2; 
element elasticBeamColumn 36 $C5 $C6 $Ac $E $Icz 2;
# columns at GL4
element elasticBeamColumn 37 $D0 $D1 $Ac $E $Icy 2;
element elasticBeamColumn 38 $D1 $D2 $Ac $E $Icy 2;
element elasticBeamColumn 39 $D2 $D3 $Ac $E $Icy 2;
element elasticBeamColumn 40 $D3 $D4 $Ac $E $Icy 2;
element elasticBeamColumn 41 $D4 $D5 $Ac $E $Icy 2; 
element elasticBeamColumn 42 $D5 $D6 $Ac $E $Icy 2;

#--------------------------------------------------------------------------------------------------------
# Define and assign Gravity/lateral loads along global X and -Y direction respectively
#--------------------------------------------------------------------------------------------------------

    #timeSeries "LinearDefault":    tsTag    cFactor 
    timeSeries   Linear             1        -factor +1.000000E+00 
    
    #Distributed loads
    set     DL     35.42;  # kN/m
    
    set     F1     27.9;  # KN
    set     F2     55.8;  # KN
    set     F3     83.7;  # KN
    set     F4     111.6; # KN
    set     F5     139.5; # KN
    set     F6     167.5; # KN
  
    
    #pattern PatternType $PatternID TimeSeriesType
    pattern    Plain        1            1       {
    
    #load $nodeTag (ndf $LoadValues)
    
    load  $A1     $F1 0. 0. ;
    load  $A2     $F2 0. 0. ;
    load  $A3     $F3 0. 0. ;
    load  $A4     $F4 0. 0. ;
    load  $A5     $F5 0. 0. ;
    load  $A6     $F6 0. 0. ;

    #eleLoad -ele $eleTag1 <$eleTag2 ....> -type -beamUniform $Wy <$Wx>                          
    eleLoad -ele 1 2 3 -type -beamUniform [expr -$DL]; 
    eleLoad -ele 4 5 6 -type -beamUniform [expr -$DL];
    eleLoad -ele 7 8 9 -type -beamUniform [expr -$DL];
    eleLoad -ele 10 11 12 -type -beamUniform [expr -$DL];
    eleLoad -ele 13 14 15 -type -beamUniform [expr -$DL];
    eleLoad -ele 16 17 18 -type -beamUniform [expr -$DL];     
   }    

#--------------------------------------------------------------------------------------------------------
# Define masses
#--------------------------------------------------------------------------------------------------------

# totsl mass on building frame : 85008;   
set mass 101.996;   # 108.4768 3542 kg/m*24m


#   Assign mass to nodes
    #mass $nodeTag (ndf $massValues)
    mass  $A1   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $B1   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)    
    mass  $C1   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $D1   [expr $mass/6.] 0. 0. ;    # (1/6 of mass) 
    mass  $A2   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $B2   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $C2   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)   
    mass  $D2   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $A3   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $B3   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $C3   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $D3   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $A4   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $B4   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $C4   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $D4   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $A5   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $B5   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $C5   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $D5   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $A6   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)
    mass  $B6   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $C6   [expr $mass/3.] 0. 0. ;    # (1/3 of mass)
    mass  $D6   [expr $mass/6.] 0. 0. ;    # (1/6 of mass)

if {$gravityanalysis == "on"}   {

initialize 

puts "Gravity analysis has been considered" 

recorder Node -file Displacement.out -time -node $A0 $A1 $A2 $A3 $A4 $A5 $A6 -dof 1 2 disp
recorder Node -file Reaction.out -time -node $A0 $B0 $C0 $D0 -dof 1 2 reaction 

# Constraint Handler 
constraints Plain
# DOF Numberer                                
numberer  RCM 
# System of Equations  
system  ProfileSPD 
# Convergence Test 
test  NormDispIncr    +1.000000E-008   200      0        2;    
# Solution Algorithm 
algorithm  Newton 
# Integrator
#integrator LoadControl $lambda <$numIter $minLambda $maxLambda>  
integrator  LoadControl  +0.01 
# Analysis Type 
analysis  Static 
# Record initial state of model 
record
# Analyze model 
analyze    10 

# Reset for next analysis case 
# ---------------------------- 
setTime 0.0 
loadConst 


} else {
	puts "Gravity analysis has not been considered";
	return -1;
}

if {$modalanalysis == "on"}   {

initialize 

puts "Modal analysis has been considered" 

initialize 

# Node Recorder "EigenVectors":    fileName    <nodeTag>    dof    respType 
recorder  Node -file ModalAnalysis_Node_EigenVectors_EigenVec1.out  -node $A0 $A1 $A2 $A3 $A4 $A5 $A6  -dof 1  eigen1; # mode 1
recorder  Node -file ModalAnalysis_Node_EigenVectors_EigenVec2.out  -node $A0 $A1 $A2 $A3 $A4 $A5 $A6  -dof 1  eigen2; # mode 2

# Constraint Handler 
constraints  Transformation 
# DOF Numberer 
numberer  Plain 
# System of Equations 
system  BandGeneral 
# Convergence Test 
test  NormDispIncr  +1.000000E-12    100     0     2 
# Solution Algorithm 
algorithm  Newton 
# Integrator 
integrator  Newmark  +5.000000E-01  +2.500000E-01 
# Analysis Type 
analysis  Transient 

# Analyze model (and record response)
set pi [expr acos(-1.0)] 
set eigFID [open ModalAnalysis_Node_EigenVectors_EigenVal.out w]  
set lambda [eigen     2]     
puts $eigFID " lambda          omega           period          frequency" 
foreach lambda $lambda { 
    set omega [expr sqrt($lambda)] 
    set period [expr 2.0*$pi/$omega] 
    set frequ [expr 1.0/$period] 
    puts $eigFID [format " %+2.6e  %+2.6e  %+2.6e  %+2.6e" $lambda $omega $period $frequ] 
} 
close $eigFID 

# Record eigenvectors 
record 

# Reset for next analysis case 
# ---------------------------- 
setTime 0.0 
loadConst 

# View modeshapes 
#                 $windowTitle $xLoc $yLoc $xPixels $yPixels
recorder display "Mode Shape 1"  10    10    500      500     -wipe  
prp $Story $Story 1;                                         # projection reference point (prp); defines the center of projection (viewer eye)
vup  0  1 0;                                         # view-up vector (vup) 
vpn  0  0 1;                                         # view-plane normal (vpn)     
viewWindow -15 15 -15 15;                        # coordiantes of the window relative to prp  
display -1 5 10;                                     # the 1st arg. is the tag for display mode (ex. -1 is for the first mode shape)
                                                     # the 2nd arg. is magnification factor for nodes, the 3rd arg. is magnif. factor of deformed shape
recorder display "Mode Shape 2" 760 10 500 500 -wipe
prp $Story $Story 1;
vup  0  1 0;
vpn  0  0 1;
viewWindow -15 15 -15 15; 
display -2 5 10;

} else {
	puts "Modal analysis has not been considered";
	return -1;
}