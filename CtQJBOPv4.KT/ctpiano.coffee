window.AudioContext = window.AudioContext or window.webkitAudioContext
context = new AudioContext()

oscillatorVoice = (oscillatorType) ->

  oscillatorPrimitive = context.createOscillator()
  oscillatorPrimitive.frequency.value = 101
  oscillatorPrimitive.type = oscillatorType

  volumePrimitive = context.createGain()
  volumePrimitive.gain.value = 0

  oscillatorPrimitive.connect(volumePrimitive)
  volumePrimitive.connect(context.destination)

  oscillatorPrimitive.start(0)

  oscillator : oscillatorPrimitive
  volume : volumePrimitive
  availability : true
  #oscillatorType : oscillatorType or 'sine'
  stimulusKey : 9000

  setFrequency : (newFrequency) ->
    @oscillator.frequency.value = newFrequency

  begin : (newFrequency) ->
    if newFrequency
      @setFrequency(newFrequency)
    now = context.currentTime
    @volume.gain.setValueAtTime(0,now)
    @volume.gain.linearRampToValueAtTime(0.2,now+0.005)
    @availability = false

  end : () ->
    now = context.currentTime
    @volume.gain.setValueAtTime(0.2,now)
    @volume.gain.linearRampToValueAtTime(0,now+0.005)
    @availability = true

oscillatorGroup = [
  new oscillatorVoice('sawtooth')
  new oscillatorVoice('sawtooth')
  new oscillatorVoice('sawtooth')
  new oscillatorVoice('sawtooth')
  new oscillatorVoice('sawtooth')
]

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

tones = [1/1, 9/8, 5/4, 4/3, 3/2, 5/3, 15/8]

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
while numeralsIndex < 8
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
  currentlyPressedKeys = []
  oscillatorGroup.forEach (element)->
    currentlyPressedKeys.push element.stimulusKey*(!element.availability)
  rowNumber = 0
  while rowNumber < rows.length
    columnNumber = 0
    while columnNumber < rows[rowNumber].length
      chadtechCanvas.drawImage(notSelected, (columnNumber*64)+(rowNumber*16)+xMargin, (rowNumber*64)+yMargin+16)
      chadtechCanvas.drawImage(numbersToNumerals[columnNumber%7],(columnNumber*64)+(rowNumber*16)+45+xMargin,(rowNumber*64)+20+yMargin)
      chadtechCanvas.drawImage(numbersToNumerals[rowNumber+Math.floor(columnNumber/7)],(columnNumber*64)+(rowNumber*16)+33+xMargin,(rowNumber*64)+20+yMargin)
      columnNumber++
    currentlyPressedKeyIndex = 0
    while currentlyPressedKeyIndex < currentlyPressedKeys.length
      if rows[rowNumber].indexOf(currentlyPressedKeys[currentlyPressedKeyIndex])!= -1
       chadtechCanvas.drawImage(selected, (rows[rowNumber].indexOf(currentlyPressedKeys[currentlyPressedKeyIndex])*64)+(rowNumber*16)+xMargin, (rowNumber*64)+yMargin+16)
      currentlyPressedKeyIndex++
    rowNumber++

$(document).ready ()->
  $('body').keydown (event)->
    currentlyPressedKeys = []
    oscillatorGroup.forEach (element)->
      currentlyPressedKeys.push element.stimulusKey*(!element.availability)
    if currentlyPressedKeys.indexOf(event.which)== -1
      oscillatorIndex = 0
      availableOscillatorFound = false
      while oscillatorIndex<oscillatorGroup.length and not availableOscillatorFound
        if oscillatorGroup[oscillatorIndex].availability
          oscillatorGroup[oscillatorIndex].begin(findTone(event.which))
          oscillatorGroup[oscillatorIndex].stimulusKey = event.which
          availableOscillatorFound = true
          draw()
        oscillatorIndex++

$(document).ready ()->
  $('body').keyup (event)->
    oscillatorIndex = 0
    while oscillatorIndex < oscillatorGroup.length
      if oscillatorGroup[oscillatorIndex].stimulusKey == event.which
        oscillatorGroup[oscillatorIndex].end()
      oscillatorIndex++
    draw()

$(window).resize ()->
  draw()

setTimeout(()-> 
  draw()
,1000)