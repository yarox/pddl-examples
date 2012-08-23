(define (domain rover-domain)

    (:requirements :durative-actions :fluents :duration-inequalities)

    (:functions
        (battery-amount ?rover)
        (sample-amount ?rover)
        (recharge-rate ?rover)
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
	     
    (:durative-action move
        :parameters 
            (?rover
             ?from-waypoint 
             ?to-waypoint)
        
        :duration 
            (= ?duration 5)
        
        :condition
	        (and 
	            (at start (rover ?rover)) 
	            (at start (waypoint ?from-waypoint)) 
	            (at start (waypoint ?to-waypoint)) 
	            (over all (can-move ?from-waypoint ?to-waypoint)) 
	            (at start (at ?rover ?from-waypoint)) 
	            (at start (> (battery-amount ?rover) 8)))
	            
        :effect
	        (and 
	            (at end (at ?rover ?to-waypoint))
	            (at end (been-at ?rover ?to-waypoint))
	            (at start (not (at ?rover ?from-waypoint))) 
	            (at start (decrease (battery-amount ?rover) 8)))
	)

    (:durative-action take-sample
        :parameters 
            (?rover 
             ?sample 
             ?waypoint)
        
        :duration 
            (= ?duration 8)
        
        :condition
	        (and 
	            (at start (rover ?rover)) 
	            (at start (waypoint ?waypoint)) 
	            (over all (at ?rover ?waypoint)) 
	            (at start (at ?rover ?waypoint)) 
	            (at start (>= (battery-amount ?rover) 5)) 
	            (at start (is-in ?sample ?waypoint)) 	        
	            (at start (< (sample-amount ?rover) (sample-capacity))))
	            
        :effect
	        (and 
	            (at end (not (is-in ?sample ?waypoint))) 
	            (at start (decrease (battery-amount ?rover) 5)) 
	            (at end (carry ?rover ?sample))
	            (at end (increase (sample-amount ?rover) 1)))    
	)

    (:durative-action drop-sample
        :parameters 
            (?rover
             ?sample
             ?waypoint)
        
        :duration 
            (= ?duration 1)
        
        :condition
            (and
                (at start (rover ?rover))
                (at start (sample ?sample))
                (at start (waypoint ?waypoint))
                (at start (is-dropping-dock ?waypoint))
                (over all (at ?rover ?waypoint))
                (at start (at ?rover ?waypoint))
                (at start (carry ?rover ?sample))
                (at start (> (battery-amount ?rover) 2)))
        
        :effect 
        	(and 
                (at end (is-in ?sample ?waypoint))
                (at end (not (carry ?rover ?sample)))
                (at end (stored-sample ?sample))
                (at start (decrease (battery-amount ?rover) 2))
                (at end (decrease (sample-amount ?rover) 1)))	    
    )

    (:durative-action take_image
        :parameters 
            (?rover
             ?objective 
             ?waypoint)
            
        :duration 
            (= ?duration 7)
            
        :condition
            (and 
                (at start (rover ?rover))
                (at start (objective ?objective))
                (at start (waypoint ?waypoint))
                (at start (at ?rover ?waypoint))
                (over all (at ?rover ?waypoint))
                (over all (is-visible ?objective ?waypoint))
                (at start (> (battery-amount ?rover) 1)))
     
        :effect
            (and 
                (at end (taken-image ?objective))
                (at start (decrease (battery-amount ?rover) 1)))       	    
    )
    
    (:durative-action recharge
        :parameters 
            (?rover
             ?waypoint)
        
        :duration 
            (= ?duration 
                (/ (- 80 (battery-amount ?rover)) (recharge-rate ?rover)))
        
        :condition
	        (and 
	            (at start (rover ?rover)) 
	            (at start (waypoint ?waypoint)) 
	            (at start (at ?rover ?waypoint)) 
	            (over all (at ?rover ?waypoint)) 
	            (at start (is-recharging-dock ?waypoint)) 
	            (at start (< (battery-amount ?rover) 80)))
     
        :effect
	        (at end 
	            (increase (battery-amount ?rover) 
	                (* ?duration (recharge-rate ?rover))))
	)
)
