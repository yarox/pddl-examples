(define (domain rover-domain)
    
    (:predicates
        (can-move ?from-waypoint ?to-waypoint)
        (is-visible ?objective ?waypoint)                       
        (is-in ?sample ?waypoint)
        (been-at ?rover ?waypoint)
        (carry ?rover ?sample)  
        (at ?rover ?waypoint)
        (is-dropping-dock ?waypoint)
        (taken-image ?objective)
        (stored-sample ?sample)
        (objective ?objective)
        (waypoint ?waypoint)    
        (sample ?sample) 
        (rover ?rover)
        (empty ?rover)                            
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
                (can-move ?from-waypoint ?to-waypoint))

        :effect 
            (and 
                (at ?rover ?to-waypoint)
                (been-at ?rover ?to-waypoint)
                (not (at ?rover ?from-waypoint)))
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
                (empty ?rover))

        :effect 
            (and 
                (not (is-in ?sample ?waypoint))
                (carry ?rover ?sample)
                (not (empty ?rover)))
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
                (carry ?rover ?sample))                     
                           
        :effect 
            (and 
                (is-in ?sample ?waypoint) 
                (not (carry ?rover ?sample))
                (stored-sample ?sample)
                (empty ?rover))
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
                (is-visible ?objective ?waypoint))
                           
        :effect 
            (taken-image ?objective)
    )
)
