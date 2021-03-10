# Broadband-ABM
globals [
  similarity initial_blue initial_green ns cs np pc ndc cdc nr cr
    ]

turtles-own [
  afford inc edu dl
  wprice ;;sensitivity towards price
  wspeed ;;sensitivity towards speed
  wdatacap ;;Sensitivity towards datacap
  wreliability
  wsocial
  wutility
  utility
  socialInfluence
  decisionValue
  initialUser?
  infoReceived?
  decisionMade?
    ]

to setup
  clear-all
  create-households
  setup-households
  intial-user-setup
  create-links
ask turtles [ ask my-links [ hide-link ] ]
  seeding
  reset-ticks
end

to create-households
  ask n-of households/zip patches
  [
        ;; make each patch sprout one turtle and set the turtle's colour etc.
        sprout 1 [
            set shape "house"
            set color green
      set size 0.8

        ]
    ]
end

to setup-households
  ;; individual turtle initialization
    ask turtles [assign_weights
   set inc random 13 + 1
  ;; assign_inc
    set edu random 6 + 1
    ;;assign_edu
     set afford random-float 1 * (inc / 14)
    set dl random-float 1 * (edu / 7)
    set infoReceived? false
    set decisionMade? false
    ]
end

to intial-user-setup
  ask n-of (households/zip * initial_users) turtles [set initialUser? true set color blue]
  set initial_blue count turtles with [color = blue]
  set initial_green count turtles with [color = green]
end

to assign_inc
  ;;sets agents income level according to household wage distribution in perry, MO
  if who >= 0 and who <= 0.0997 * count turtles [set inc 1]
  if who > 0.0997 * count turtles and who <= 0.12387 * count turtles [set inc 2]
 if who > 0.12387 * count turtles and who <= 0.25378 * count turtles  [set inc 3 ]
  if who > 0.25378 * count turtles and who <= 0.32629 * count turtles  [set inc 4]
  if who > 0.32629 * count turtles and who <= 0.38671 * count turtles  [set inc 5]
 if who > 0.38671 * count turtles and who <= 0.48339 * count turtles  [set inc 6]
 if who > 0.48339 * count turtles and who <= 0.54079 * count turtles  [set inc 7]
 if who > 0.54079 * count turtles and who <= 0.62236 * count turtles  [set inc 8]
  if who > 0.62236 * count turtles and who <= 0.67372 * count turtles  [set inc 9]
  if who > 0.67372 * count turtles and who <= 0.77002 * count turtles  [set inc 10]
   if who > 0.77002 * count turtles and who <= 0.81232 * count turtles  [set inc 11]
  if who > 0.81232 * count turtles and who <= 0.88483 * count turtles  [set inc 12]
  if who > 0.88483 * count turtles and who <= 0.9664 * count turtles  [set inc 13]
    if who > 0.9664 * count turtles and who <= 1.0 * count turtles  [set inc 14 ]
end

to assign_edu
  ;;sets agents inc according to household wage distribution in perry, MO
  if who >= 0 and who <= (0.0891 * count turtles) [set edu 1]
  if who > (0.0891 * count turtles) and who <= (0.1544 * count turtles) [set edu 2]
 if who > (0.1544 * count turtles) and who <= (0.6019 * count turtles)  [set edu 3 ]
  if who > (0.6019 * count turtles) and who <= (0.7801 * count turtles)  [set edu 4]
  if who > (0.7801 * count turtles) and who <= (0.8751 * count turtles)  [set edu 5]
 if who > (0.8751 * count turtles) and who <= (0.9622 * count turtles)  [set edu 6]
 if who > (0.9622 * count turtles) and who <= (1.0 * count turtles)  [set edu 7]
end

to assign_weights
    set wprice random-float 1
    set wspeed random-float 1
    set wdatacap random-float 1
    set wreliability random-float 1
    set wsocial random-float 1
    set wutility random-float 1
end

to create-links
  let n 0
  while [n < count turtles][
  ask turtle n [
    ask turtles in-radius 5 [
     set similarity  (0.5 - abs(inc - [inc] of myself) / 14) + (0.5 - abs(edu - [edu] of myself) / 7)
        if similarity >= 0.8
        [
          if distance myself > 0[create-link-with turtle n]

        ]
      ]
   if random-float 1 < 0.5[create-links-with n-of 1 other turtles]
  ]

   set n n + 1
  ]

end

to go
  if ticks = 12[stop]
  ask turtles[diffusion influence]
  ask turtles[decision]
  tick
end


to seeding
  ;;selecting 5% random agents to start diffusion
    ask n-of (count turtles * 0.05) turtles [ set infoReceived? true utility-calculation]
end

to utility-calculation
  set ns speed_new / 1000
  set cs speed_current / 1000
  set np price_new / 200
  set pc price_current / 200
  set ndc datacap_new / 3000
  set cdc datacap_current / 3000
  set nr reliability_new / 5
  set cr reliability_current / 5

  ifelse initial_users = 0[utility_unserved][utility_underserved]
  set infoReceived? true
end

to utility_unserved
  ifelse afford + dl > 0.50 [set utility wspeed * ns - wprice * np + wdatacap * ndc + wreliability * nr] [set utility -1]
end

to utility_underserved
  ifelse initialUser? = true [set utility wspeed * (ns - cs) - wprice * (np - pc) + wdatacap * (ndc - cdc) + wreliability * (nr - cr)][utility_unserved]
end


to diffusion
  if infoReceived? = true [ask link-neighbors[utility-calculation]]
end

to influence
  ifelse count link-neighbors = 0 [set socialInfluence -1]
  [set socialInfluence sum [utility] of link-neighbors / count link-neighbors]
end

to decision
  set decisionValue wsocial * socialInfluence + wutility * utility
  if decisionValue > 0  [set color red
    set decisionMade? true]
end

to-report new-adopters
  report (count turtles with [decisionValue > 0] / count turtles) * 100
end

to-report switched-users
  report count turtles with [color = blue]
end
