window.AudioContext = window.AudioContext or window.webkitAudioContext
context = new AudioContext()

oscillatorGroup = {}

oscillatorVoice = (oscillatorType, frequencyValue) ->

  oscillatorPrimitive = context.createOscillator()
  oscillatorPrimitive.frequency.value = frequencyValue || 101
  oscillatorPrimitive.type = oscillatorType

  volumePrimitive = context.createGain()
  volumePrimitive.gain.value = 0

  oscillatorPrimitive.connect(volumePrimitive)
  volumePrimitive.connect(context.destination)

  oscillatorPrimitive.start(0)

  oscillator: oscillatorPrimitive
  volume: volumePrimitive
  availability: true
  stimulusKey: 9000

  setFrequency: (newFrequency) ->
    @oscillator.frequency.value = newFrequency

  begin: ->
    now = context.currentTime
    @volume.gain.setValueAtTime(0,now)
    @volume.gain.linearRampToValueAtTime(0.2,now+0.005)
    @availability = false

  end: ->
    now = context.currentTime
    @volume.gain.setValueAtTime(0.2,now)
    @volume.gain.linearRampToValueAtTime(0,now+0.005)
    @oscillator.stop(now+0.007)
    keyToRemove = @stimulusKey
    setTimeout(()->
      delete oscillatorGroup[keyToRemove]
      draw()
    , 0.01)
    @availability = true


findTone = (eventKey) ->
  tone = ''
  rowSuspect = 0
  keepGoin = true
  while rowSuspect < rows.length and keepGoin
    keySuspect = 0
    while keySuspect < rows[rowSuspect].length and keepGoin
      if eventKey == rows[rowSuspect][keySuspect]
        tone = tones[keySuspect%tones.length]*Math.pow(2,rowSuspect+Math.floor(keySuspect/tones.length))*100
        keepGoin = false
      keySuspect++
    rowSuspect++
  return tone

everyFive = [
  [1, 9/8, 5/4, 4/3, 3/2, 5/3, 15/8]
  [1, 9/8, 5/4, 675/512, 3/2, 5/3, 15/8]
  [1, 10/9, 5/4, 4/3, 40/27, 5/3, 256/135]
  [1, 10/9, 5/4, 4/3, 40/27, 5/3, 15/8]
  [1, 9/8, 32/25, 4/3, 3/2, 128/75, 48/25]
  [1, 9/8, 5/4, 4/3, 3/2, 27/16, 15/8]
  [1, 256/225, 512/405, 4/3, 1024/675, 128/75, 256/135]
  [1, 10/9, 5/4, 4/3, 3/2, 5/3, 15/8]
  [1, 10/9, 5/4, 4/3, 3/2, 5/3, 15/8]
  [1, 9/8, 32/25, 27/20, 3/2, 27/16, 48/25]
  [1, 9/8, 81/64, 27/20, 3/2, 27/16, 15/8]
  [1, 256/225, 32/25, 4/3, 3/2, 128/75, 256/135]
]

inverseEveryFive = [
  [1, 16/15, 6/5, 4/3, 3/2, 8/5, 16/9]
  [1, 16/15, 6/5, 4/3, 1024/675, 8/5, 16/9]
  [1, 135/128, 6/5, 27/20, 3/2, 8/5, 9/5]
  [1, 16/15, 6/5, 27/20, 3/2, 8/5, 9/5]
  [1, 25/24, 75/64, 4/3, 3/2, 25/16, 16/9]
  [1, 16/15, 32/27, 4/3, 3/2, 8/5, 16/9]
  [1, 135/128, 75/64, 675/512, 3/2, 405/256, 225/128]
  [1, 16/15, 6/5, 4/3, 3/2, 8/5, 9/5]
  [1, 16/15, 6/5, 4/3, 3/2, 8/5, 9/5]
  [1, 25/24, 32/27, 4/3, 40/27, 25/16, 16/9]
  [1, 16/15, 32/27, 4/3, 40/27, 128/81, 16/9]
  [1, 135/128, 75/64, 4/3, 3/2, 25/16, 225/128]
]

everySeven = [
  [1, 28/27, 7/6, 4/3, 3/2, 14/9, 7/4]
  [1, 243/224, 243/196, 4/3, 3/2, 81/49, 12/7]
  [1, 28/27, 32/27, 4/3, 32/21, 14/9, 16/9]
  [1, 54/49, 32/27, 4/3, 3/2, 32/21, 16/9]
  [1, 28/27, 7/6, 4/3, 112/81, 14/9, 7/4]
  [1, 28/27, 7/6, 21/16, 3/2, 14/9, 7/4]
  [1, 243/224, 243/196, 9/7, 3/2, 729/448, 729/392]
  [1, 28/27, 7/6, 4/3, 3/2, 14/9, 16/9]
  [1, 54/49, 8/7, 4/3, 3/2, 81/49, 16/9]
  [1, 49/48, 7/6, 21/16, 3/2, 14/9, 7/4]
  [1, 64/63, 32/27, 4/3, 32/21, 128/81, 16/9]
  [1, 9/8, 81/64, 81/56, 14/9, 27/16, 27/14]
]

inverseEverySeven= [
  [1, 8/7, 9/7, 4/3, 3/2, 12/7, 27/14]
  [1, 7/6, 98/81, 4/3, 3/2, 392/243, 448/243]
  [1, 9/8, 9/7, 21/16, 3/2, 27/16, 27/14]
  [1, 9/8, 21/16, 4/3, 3/2, 27/16, 49/27]
  [1, 8/7, 9/7, 81/56, 3/2, 12/7, 27/14]
  [1, 8/7, 9/7, 4/3, 32/21, 12/7, 27/14]
  [1, 784/729, 896/729, 4/3, 14/9, 392/243, 448/243]
  [1, 9/8, 9/7, 4/3, 3/2, 12/7, 27/14]
  [1, 9/8, 98/81, 4/3, 3/2, 7/4, 49/27]
  [1, 8/7, 9/7, 4/3, 32/21, 12/7, 96/49]
  [1, 9/8, 81/64, 21/16, 3/2, 27/16, 63/32]
  [1, 28/27, 32/27, 9/7, 112/81, 128/81, 16/9]
]

scales = [everyFive, inverseEveryFive, everySeven, inverseEverySeven]

primeSystem = 0
ofSystem = 0

tones = scales[primeSystem][ofSystem]

while primeSystem < scales.length
  ofSystem = 0
  while ofSystem < 7
    ofSystem++
  primeSystem++

primeSystem = 0
ofSystem = 0

selected = new Image()
selected.src = 'selected.png'
notSelected = new Image()
notSelected.src = 'notSelected.png'

title = new Image()
title.src = 'title.png'

numbersToNumerals = 
  0: new Image()
  1: new Image()
  2: new Image()
  3: new Image()
  4: new Image()
  5: new Image()
  6: new Image()
  7: new Image()
  8: new Image()
  9: new Image()
  10: new Image()
  11: new Image()
  12: new Image()
  13: new Image()
  14: new Image()
  15: new Image()

zeroPadder = (number,zerosToFill) ->
  numberAsString = number+''
  while numberAsString.length < zerosToFill
    numberAsString = '0'+numberAsString
  return numberAsString

numeralsIndex = 0
while numeralsIndex < 16
  numbersToNumerals[numeralsIndex].src = 'n'+zeroPadder(numeralsIndex,2)+'.PNG'
  numeralsIndex++

rows = [
  [49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 189, 187]
  [81, 87, 69, 82, 84, 89, 85, 73, 79, 80, 219, 221, 220]
  [65, 83, 68, 70, 71, 72, 74, 75, 76, 186, 222]
  [90, 88, 67, 86, 66, 78, 77, 188, 190, 191]
]

draw = ()->
  xMargin = 96
  yMargin = 32
  chadtechCanvas = document.getElementById('CtQJBOPv4.KT').getContext('2d')
  chadtechCanvas.canvas.width = window.innerWidth
  chadtechCanvas.canvas.height = window.innerHeight
  chadtechCanvas.drawImage(title,xMargin,yMargin)
  chadtechCanvas.drawImage(numbersToNumerals[primeSystem],xMargin+title.width, yMargin)
  chadtechCanvas.drawImage(numbersToNumerals[ofSystem],xMargin+title.width+12, yMargin)
  rowNumber = 0
  while rowNumber < rows.length
    columnNumber = 0
    while columnNumber < rows[rowNumber].length
      chadtechCanvas.drawImage(notSelected, (columnNumber*64)+(rowNumber*16)+xMargin, (rowNumber*64)+yMargin+16)
      chadtechCanvas.drawImage(numbersToNumerals[columnNumber%7],(columnNumber*64)+(rowNumber*16)+45+xMargin,(rowNumber*64)+20+yMargin)
      chadtechCanvas.drawImage(numbersToNumerals[rowNumber+Math.floor(columnNumber/7)],(columnNumber*64)+(rowNumber*16)+33+xMargin,(rowNumber*64)+20+yMargin)
      if oscillatorGroup[rows[rowNumber][columnNumber]]
        chadtechCanvas.drawImage(selected, (columnNumber*64)+(rowNumber*16)+xMargin, (rowNumber*64)+yMargin+16)        
      columnNumber++
    rowNumber++

changeScale = (keyCode)->
  if keyCode == 37
    if primeSystem>0
      primeSystem--
  else if keyCode == 38
    if ofSystem>0
      ofSystem--
  else if keyCode == 39
    if primeSystem<(scales.length-1)
      primeSystem++
  else if keyCode == 40
    if ofSystem<(scales[primeSystem].length-1)
      ofSystem++
  tones = scales[primeSystem][ofSystem]

$(document).ready ()->
  $('body').keydown (event)->
    if (41<event.which) or (event.which<37)
      if not oscillatorGroup[event.which]
        oscillatorGroup[event.which] = new oscillatorVoice('sawtooth', findTone(event.which))
        keyJustPressed = event.which
        oscillatorGroup[event.which].stimulusKey = keyJustPressed
        oscillatorGroup[event.which].begin()
    else
      changeScale(event.which)
    draw()

  $('body').keyup (event)->
    oscillatorGroup[event.which].end()

  $(window).resize ()->
    draw()

setTimeout(()-> 
  draw()
,1000)