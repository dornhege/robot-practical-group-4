(define (domain nao-world)
(:requirements :typing :durative-actions)
(:types direction thing location - object
	robot box ball -thing)
(:predicates   (handempty ?r - robot)
	       (clear ?l - location)
		(holding ?r - robot ?b - box)
		(at ?t - thing ?l - location)
		(isGoal ?l - location)
		(MOVE-DIR ?l1 ?l2 - location ?d - direction))


(:durative-action move
   :parameters (?p - robot ?from ?to - location ?dir - direction)
   :duration  (= ?duration 1)
   :condition (and (at start (at ?p ?from))
                   (at start (clear ?to))
                   (over all (MOVE-DIR ?from ?to ?dir))
                   )
   :effect    (and (at start (not (at ?p ?from)))
                   (at start (not (clear ?to)))
                   (at end (at ?p ?to))
                   (at end (clear ?from))
                   )
   )


(:durative-action kick
	:parameters (?r - robot ?l1 ?l2 ?l3 - location ?d - direction ?b - ball)
	:duration (= ?duration 1)
	:condition (and(at start(at ?b ?l2) (at start(at ?r ?l1)) (at start (clear ?l3))
			(at start(MOVE-DIR ?l1 ?l2 ?d)) (at start (MOVE-DIR ?l2 ?l3 ?d)))
	:effect (and(at end(not (at ?b ?l2))) (at end(at ?b ?l3)) (at end (not (clear ?l3))) (at end(clear ?l2))) 
)

(:durative-action pick-up
	:parameters (?b - box ?r - robot ?l1 ?l2 - location ?d - direction)
	:duration (= ?duration 3)
	:precondition(handempty ?r)
	:condition (and (at start (at ?r ?l1)) (at start(at ?b ?l2)) (at start(MOVE-DIR ?l1 ?l2 ?d)))
	:effect (and (at end(not(handempty ?r))) (at end(not(at ?b ?l2))) (at end(clear ?l2)) (at end(holding ?r ?b)))
)

(:durative-action drop
	:parameters (?b - box ?r - robot ?l1 ?l2 - location ?d - direction)
	:duration (= ?duration 3)
	:precondition(not(handempty ?r))
	:condition (and (at start(at ?r ?l1)) (at start(holding ?r ?b)) (at start(clear ?l2)) (at start(MOVE-DIR ?l1 ?l2 ?d)))
	:effect (and (at end(handempty ?r)) (at end(at ?b ?l2)) (at end(not(holding ?r ?b))) (at end(not(clear ?l2))))
)