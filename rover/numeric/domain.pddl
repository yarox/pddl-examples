(define (domain rover-domain)
    (:requirements :fluents)
    
    (:functions
        (battery-amount ?rover)
        (sample-amount ?rover)
        (battery-capacity)
        (sample-capacity)
    )
    
    (:predicates
        (can-move ?from-waypoint ?to-waypoint)
        (is-visible ?objective ?waypoint)                       
        (is-in ?sample ?waypoint)
        (been-at ?rover ?waypoint)
        (carry ?rover ?sample)  
        (at ?rover ?waypoint)
        (is-recharging-dock ?waypoint)
        (is-dropping-dock ?waypoint)
        (taken-image ?objective)
        (stored-sample ?sample)
        (objective ?objective)
        (waypoint ?waypoint)    
        (sample ?sample) 
        (rover ?rover)                             
    )
    
    (:action move
        :parameters 
            (?rover
             ?from-waypoint 
             ?to-waypoint)

        :precondition 
            (and 
                (rover ?rover)
                (waypoint ?from-waypoint)
                (waypoint ?to-waypoint) 
                (at ?rover ?from-waypoint)
                (can-move ?from-waypoint ?to-waypoint)
                (> (battery-amount ?rover) 8))

        :effect 
            (and 
                (at ?rover ?to-waypoint)
                (been-at ?rover ?to-waypoint)
                (not (at ?rover ?from-waypoint))
                (decrease (battery-amount ?rover) 8))
    )

    (:action take-sample
        :parameters 
            (?rover 
             ?sample 
             ?waypoint)

        :precondition 
            (and 
                (rover ?rover)
                (sample ?sample)
                (waypoint ?waypoint) 
                (is-in ?sample ?waypoint)
                (at ?rover ?waypoint)
                (> (battery-amount ?rover) 3)
                (< (sample-amount ?rover) (sample-capacity)))

        :effect 
            (and 
                (not (is-in ?sample ?waypoint))
                (carry ?rover ?sample)
                (decrease (battery-amount ?rover) 3)
                (increase (sample-amount ?rover) 1))
    )
    
    (:action drop-sample
        :parameters 
            (?rover
             ?sample 
             ?waypoint)

        :precondition 
            (and 
                (rover ?rover)
                (sample ?sample)
                (waypoint ?waypoint)
                (is-dropping-dock ?waypoint)
                (at ?rover ?waypoint)
                (carry ?rover ?sample)
                (> (battery-amount ?rover) 2))                     
                           
        :effect 
            (and 
                (is-in ?sample ?waypoint) 
                (not (carry ?rover ?sample))
                (stored-sample ?sample)
                (decrease (battery-amount ?rover) 2)
                (decrease (sample-amount ?rover) 1))
    )

    (:action take-image
        :parameters 
            (?rover
             ?objective 
             ?waypoint)

        :precondition 
            (and 
                (rover ?rover)
                (objective ?objective)
                (waypoint ?waypoint)
                (at ?rover ?waypoint)
                (is-visible ?objective ?waypoint)
                (> (battery-amount ?rover) 1))
                           
        :effect 
            (and 
                (taken-image ?objective)
                (decrease (battery-amount ?rover) 1))
    )
    
    (:action recharge
        :parameters 
            (?rover
             ?waypoint)
        
        :precondition
	        (and
	            (rover ?rover)
	            (waypoint ?waypoint)  
	            (at ?rover ?waypoint)
	            (is-recharging-dock ?waypoint) 
	            (< (battery-amount ?rover) 20))
	            
        :effect
            (increase (battery-amount ?rover) 
                (- (battery-capacity) (battery-amount ?rover)))
    )
)
