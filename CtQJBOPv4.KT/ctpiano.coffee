window.AudioContext = window.AudioContext or window.webkitAudioContext
context = new AudioContext()

oscillators = []

oscillators.forEach (element)->
  element.connect(context.destination)

tones= [1/1, 9/8, 5/4, 4/3, 3/2, 5/3, 15/8, 2/1]

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

numeralsIndex = 0
while numeralsIndex < 8
  numbersToNumerals[numeralsIndex].src = 'n'+numeralsIndex+'.PNG'
  numeralsIndex++


rows = [
  [49, 50, 51, 52, 53, 54, 55, 56],
  [81, 87, 69, 82, 84, 89, 85, 73],
  [65, 83, 68, 70, 71, 72, 74, 75],
  [90, 88, 67, 86, 66, 78, 77, 188]
  ]

draw = ()->
  xMargin = 96
  yMargin = 32
  chadtechCanvas = document.getElementById('CtQJBOPv4.KT').getContext('2d')
  chadtechCanvas.canvas.width = window.innerWidth
  chadtechCanvas.canvas.height = window.innerHeight
  chadtechCanvas.drawImage(title,xMargin,yMargin)
  currentlyPressedKeys = []
  oscillators.forEach (element)->
    currentlyPressedKeys.push element[0]

  rowNumber = 0
  while rowNumber < rows.length
    columnNumber = 0
    while columnNumber < tones.length
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
    proceed = true
    oscillatorIndex = 0
    while oscillatorIndex < oscillators.length
      if oscillators[oscillatorIndex][0]==event.which
        proceed= false
      oscillatorIndex++
    if proceed
      rowSuspect = 0
      while rowSuspect<rows.length
        keySuspect = 0
        while keySuspect<rows[rowSuspect].length
          if rows[rowSuspect][keySuspect]==event.which
            now = context.currentTime
            newOscillator = context.createOscillator()
            newOscillator.type = 'sawtooth'
            newVolume = context.createGain()
            newOscillator.connect(newVolume)
            newVolume.gain.setValueAtTime(0,now)
            newVolume.gain.linearRampToValueAtTime(0.2,now+0.01)
            newFilter = context.createBiquadFilter()
            newFilter.type = 0
            newFilter.frequency.value = 1000;
            newVolume.connect(newFilter)
            newFilter.connect(context.destination)
            newOscillator.frequency.value = 100*(tones[keySuspect])*Math.pow(2,rowSuspect)
            newOscillator.start(0)
            oscillators.push [event.which, newVolume]
          keySuspect++
        rowSuspect++
    draw()

$(document).ready ()->
  $('body').keyup (event)->
    oscillatorIndex = 0
    while oscillatorIndex < oscillators.length
      if oscillators[oscillatorIndex][0]==event.which
        now = context.currentTime
        oscillators[oscillatorIndex][1].gain.setValueAtTime(0.2,now)
        oscillators[oscillatorIndex][1].gain.linearRampToValueAtTime(0,now+0.5)
        oscillators[oscillatorIndex][1].disconnect()
        oscillators.splice(oscillatorIndex,1)
      oscillatorIndex++
    draw()

$(window).resize ()->
  draw()

setTimeout(()-> 
  draw()
,200)