# pddl-examples
__pddl__ examples including __strips__, __numeric__, and __time__ domains.

# Dependecies
This examples have been tested under `Ubuntu Linux 12.04` with the following
configuration:

+ `metric-ff 2.0`
+ `lpg-td-1.0`

# How to run the examples
## Metric-FF
Open a terminal, navigate to where `metric-ff` is installed, and run:

    ./ff -o path/to/domain.pddl -f path/to/problem.pddl

## LPG
Open a terminal, navigate to where `lpg-td` is installed, and run:
    
    ./lpg-td-1.0 -o path/to/domain.pddl -f path/to/problem.pddl -speed -noout

# Examples
Inspired by planetary rovers problems, this domain requires that a collection of
rovers navigate a planet surface, finding samples, taking images, and collecting
them back to a lander.

## STRIPS
In this version, rovers can carry one sample at a time. They must drop them at a
safe location before they can take the next one.

Must be executed with __metric-ff__.

## NUMERIC 
In the numeric version, rovers consume energy in their various activities, and 
can take a maximum number of samples with them.

Must be executed with __metric-ff__.

## TIME
This variant combined the demands of the simple time durations of activities 
with the complexities of managing energy levels as in the numeric version. 

Must be executed with __lpg-td__.

# References
1. http://planning.cis.strath.ac.uk/competition/
2. http://fai.cs.uni-saarland.de/hoffmann/metric-ff.html
3. http://prometeo.ing.unibs.it/lpg/
