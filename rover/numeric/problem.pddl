(define (problem rover-single)

    (:domain 
        rover-domain    
    )
    
    (:objects
        waypoint1 waypoint2 waypoint3 waypoint4 waypoint5 waypoint6 
        waypoint7 waypoint8 waypoint9 waypoint10 waypoint11 waypoint12
        
        sample1 sample2 sample3 sample4 sample5 sample6 sample7 sample8 
        sample9 
        
        objective1 objective2 objective3 objective4
        
        rover1
    )
    
    (:init
        (= (battery-capacity) 100)
        (= (sample-capacity) 2)
        
        (waypoint waypoint1) (waypoint waypoint2) (waypoint waypoint3) 
        (waypoint waypoint4) (waypoint waypoint5) (waypoint waypoint6) 
        (waypoint waypoint7) (waypoint waypoint8) (waypoint waypoint9)
        
        (sample sample1) (sample sample2) (sample sample3) (sample sample4)
        (sample sample5) (sample sample6)
        
        (objective objective1) (objective objective2) (objective objective3)
        (objective objective4)
        
        (can-move waypoint1 waypoint5) (can-move waypoint1 waypoint9)
        (can-move waypoint2 waypoint5) (can-move waypoint3 waypoint4) 
        (can-move waypoint3 waypoint6) (can-move waypoint4 waypoint3) 
        (can-move waypoint4 waypoint8) (can-move waypoint4 waypoint9)
        (can-move waypoint5 waypoint1) (can-move waypoint5 waypoint2)
        (can-move waypoint6 waypoint3) (can-move waypoint6 waypoint7)
        (can-move waypoint6 waypoint8) (can-move waypoint7 waypoint6)
        (can-move waypoint8 waypoint4) (can-move waypoint8 waypoint6)
        (can-move waypoint9 waypoint1) (can-move waypoint9 waypoint4)
        
        (is-visible objective1 waypoint2) (is-visible objective1 waypoint3)
        (is-visible objective1 waypoint4) (is-visible objective2 waypoint5)
        (is-visible objective2 waypoint7) (is-visible objective3 waypoint8)
        (is-visible objective4 waypoint5) (is-visible objective4 waypoint1)
        
        
        (is-in sample1 waypoint2) (is-in sample2 waypoint3) 
        (is-in sample3 waypoint9) (is-in sample4 waypoint8)
        (is-in sample5 waypoint3) (is-in sample6 waypoint3)   
        
        (is-recharging-dock waypoint1)
        (is-dropping-dock waypoint7)
        
        (rover rover1)
        (at rover1 waypoint6)
        (= (battery-amount rover1) 40) 
        (= (sample-amount rover1) 0)
    )
    
    (:goal
        (and 
            (stored-sample sample1)
            (stored-sample sample2)
            (stored-sample sample3)
            (stored-sample sample4)
            (stored-sample sample5)
            (stored-sample sample6)
            
            (taken-image objective1)
            (taken-image objective2)
            (taken-image objective3)
            (taken-image objective4)     
            
            (at rover1 waypoint1))
    )
    
    (:metric 
        minimize (battery-amount))
)
