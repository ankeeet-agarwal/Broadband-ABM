globals [
  similarity existing_blue existing_green ns cs np pc ndc cdc nr cr
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
  existingUser?
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
            set color red
      set size 0.8

        ]
    ]
end

to setup-households
  ;; individual turtle initialization
  ask turtles [assign_weights
   set inc random 13 + 1
 ;; assign_inc_perry
    set edu random 6 + 1
    ;;assign_edu_perry
     set afford random-float 1 * (inc / 14)
    set dl random-float 1 * (edu / 7)
    set infoReceived? false
    set decisionMade? false
    ]
end

to intial-user-setup
  ask n-of (households/zip * existing_users) turtles [set existingUser? true set color blue]
  set existing_blue count turtles with [color = blue]
  set existing_green count turtles with [color = red]
end

to assign_inc_perry
  ;;sets agents income level according to household wage distribution in perry, MO
  if who >= 0 and who <= 0.0997 * count turtles [set inc 1]
  if who > 0.0997 * count turtles and who <= 0.12387 * count turtles [set inc 2]
 if who > 0.12387 * count turtles and who <= 0.25378 * count turtles  [set inc 3 ]
  if who > 0.25378 * count turtles and who <= 0.32629 * count turtles  [set inc 4]
  if who > 0.32629 * count turtles and who <= 0.38671 * count
   turtles  [set inc 5]
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

to assign_edu_perry
  ;;sets agents inc according to household wage distribution in perry, MO
  if who >= 0 and who <= (0.03 * count turtles) [set edu 1]
  if who > (0.03 * count turtles) and who <= (0.09 * count turtles) [set edu 2]
 if who > (0.09 * count turtles) and who <= (0.554 * count turtles)  [set edu 3 ]
  if who > (0.554 * count turtles) and who <= (0.846 * count turtles)  [set edu 4]
  if who > (0.846 * count turtles) and who <= (0.916 * count turtles)  [set edu 5]
 if who > (0.916 * count turtles) and who <= (0.975 * count turtles)  [set edu 6]
 if who > (0.975 * count turtles) and who <= (1.0 * count turtles)  [set edu 7]
end

to assign_inc_patton
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

to assign_edu_patton
  ;;sets agents inc according to household wage distribution in perry, MO
  if who >= 0 and who <= (0.042 * count turtles) [set edu 1]
  if who > (0.042 * count turtles) and who <= (0.088 * count turtles) [set edu 2]
 if who > (0.088 * count turtles) and who <= (0.587 * count turtles)  [set edu 3 ]
  if who > (0.587 * count turtles) and who <= (0.844 * count turtles)  [set edu 4]
  if who > (0.844 * count turtles) and who <= (0.94 * count turtles)  [set edu 5]
 if who > (0.94 * count turtles) and who <= (0.981 * count turtles)  [set edu 6]
 if who > (0.981 * count turtles) and who <= (1.0 * count turtles)  [set edu 7]
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

  ifelse existing_users = 0[utility_unserved][utility_underserved]
  set infoReceived? true
end

to utility_unserved
  ifelse afford + dl > 0.50 [set utility wspeed * ns - wprice * np + wdatacap * ndc + wreliability * nr] [set utility -1]
end

to utility_underserved
  ifelse existingUser? = true [set utility wspeed * (ns - cs) - wprice * (np - pc) + wdatacap * (ndc - cdc) + wreliability * (nr - cr)][utility_unserved]
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
  if decisionValue > 0  [set color green
    set decisionMade? true]
end

to-report new-adopters
  report (count turtles with [decisionValue > 0] / count turtles) * 100
end

to-report switched-users
  report count turtles with [color = blue]
end
@#$#@#$#@
GRAPHICS-WINDOW
401
10
838
448
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

SLIDER
223
98
396
131
speed_current
speed_current
0
1000
7.0
1
1
Mbps
HORIZONTAL

SLIDER
224
136
396
169
price_current
price_current
10
200
114.99
1
1
$
HORIZONTAL

SLIDER
222
55
394
88
households/zip
households/zip
0.0
1000
462.0
1.0
1
NIL
HORIZONTAL

SLIDER
223
176
395
209
reliability_current
reliability_current
0.0
5.0
3.3
0.1
1
NIL
HORIZONTAL

SLIDER
222
249
394
282
speed_new
speed_new
0
1000
25.0
1
1
Mbps
HORIZONTAL

SLIDER
223
289
395
322
price_new
price_new
0
200
124.99
1
1
$
HORIZONTAL

SLIDER
223
330
395
363
reliability_new
reliability_new
0.0
5.0
3.2
0.1
1
NIL
HORIZONTAL

BUTTON
236
410
303
443
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
312
410
375
443
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
223
10
395
43
existing_users
existing_users
0.0
1
0.601
0.01
1
NIL
HORIZONTAL

MONITOR
843
185
1004
230
New Service Adopters%
new-adopters
3
1
11

PLOT
843
31
1043
181
Adoption%
ticks
Adoption%
0.0
10.0
0.0
100.0
true
false
"" ""
PENS
"default" 100.0 0 -5298144 true "" "plot ((count turtles with [decisionValue > 0] / count turtles) * 100)"
"pen-1" 100.0 0 -13345367 true "" "plot ((count turtles with [color = blue] / count turtles) * 100)"

SLIDER
222
213
394
246
datacap_current
datacap_current
30
3000
3000.0
10
1
NIL
HORIZONTAL

SLIDER
222
368
394
401
datacap_new
datacap_new
10
3000
3000.0
10
1
NIL
HORIZONTAL

MONITOR
843
246
1007
291
Current service subscribers
switched-users
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="senstivity" repetitions="1000" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>new-adopters</metric>
    <enumeratedValueSet variable="price_current">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="datacap_new">
      <value value="3000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="households/zip">
      <value value="500"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed_current">
      <value value="12"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reliability_new">
      <value value="3.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reliability_current">
      <value value="3.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price_new">
      <value value="60"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed_new">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="datacap_current">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="existing_users">
      <value value="0.65"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="perry" repetitions="1000" sequentialRunOrder="false" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>new-adopters</metric>
    <enumeratedValueSet variable="datacap_new">
      <value value="3000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price_current">
      <value value="64"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="households/zip">
      <value value="274"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed_current">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reliability_new">
      <value value="3.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reliability_current">
      <value value="3.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price_new">
      <value value="55"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed_new">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="datacap_current">
      <value value="1024"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="existing_users">
      <value value="0.7"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Patton" repetitions="1000" sequentialRunOrder="false" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <metric>new-adopters</metric>
    <enumeratedValueSet variable="datacap_new">
      <value value="3000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price_current">
      <value value="114.99"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="households/zip">
      <value value="462"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed_current">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reliability_new">
      <value value="4.95"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reliability_current">
      <value value="3.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="price_new">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed_new">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="datacap_current">
      <value value="3000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial_users">
      <value value="0.6"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
