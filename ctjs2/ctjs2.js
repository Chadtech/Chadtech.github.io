(function() {
  var Body, Keys, arrayOfLines, arrayOfPages, characterHeight, characterInWord, characterWidth, convertCharacterListToWordList, convertLinesToCharacterLists, convertWordListToLineList, currentCursorSpot, currentlyPressedKeys, cursorInLine, cursorsLine, doc, documentUpdate, draw, fileLoad, i, justPressedKey, key, keyDownThenDraw, keyEventDown, keyEventUp, len, lineLength, lineSpace, onDragOver, onMouseDown, organizeWords, ref, scriptVariety, words, writeData, xMargin, yMargin, zeroPadder,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  characterWidth = 11;

  characterHeight = 19;

  xMargin = 8 * characterWidth;

  yMargin = 2 * characterHeight;

  lineSpace = 8;

  scriptVariety = [true, true];

  doc = [];

  currentCursorSpot = 0;

  justPressedKey = void 0;

  currentlyPressedKeys = [];

  words = [];

  arrayOfLines = [];

  arrayOfPages = [];

  cursorsLine = 0;

  cursorInLine = 0;

  lineLength = 0;

  lineLength = Math.floor((window.innerWidth - (xMargin * 2)) / 2);

  characterInWord = 0;

  Keys = {
    'backspace': 8,
    'tab': 9,
    'enter': 13,
    'shift': 16,
    'ctrl': 17,
    'alt': 18,
    'caps lock': 20,
    'escape': 27,
    'space': 32,
    'left': 37,
    'up': 38,
    'right': 39,
    'down': 40,
    'delete': 46,
    '0': 48,
    '1': 49,
    '2': 50,
    '3': 51,
    '4': 52,
    '5': 53,
    '6': 54,
    '7': 55,
    '8': 56,
    '9': 57,
    'a': 65,
    'b': 66,
    'c': 67,
    'd': 68,
    'e': 69,
    'f': 70,
    'g': 71,
    'h': 72,
    'i': 73,
    'j': 74,
    'k': 75,
    'l': 76,
    'm': 77,
    'n': 78,
    'o': 79,
    'p': 80,
    'q': 81,
    'r': 82,
    's': 83,
    't': 84,
    'u': 85,
    'v': 86,
    'w': 87,
    'x': 88,
    'y': 89,
    'z': 90,
    'left command': 91,
    'right command': 93,
    'numpad0': 96,
    'numpad1': 97,
    'numpad2': 98,
    'numpad3': 99,
    'numpad4': 100,
    'numpad5': 101,
    'numpad6': 102,
    'numpad7': 103,
    'numpad8': 104,
    'numpad9': 105,
    'f1': 112,
    'f2': 113,
    'f3': 114,
    'f4': 115,
    'f5': 116,
    'f6': 117,
    'f7': 118,
    'f8': 119,
    'f9': 120,
    'f10': 121,
    'f11': 122,
    'f12': 123,
    'semicolon': 186,
    'equals': 187,
    'comma': 188,
    'minus': 189,
    'period': 190,
    'forward slash': 191,
    'tilda': 192,
    'left bracket': 219,
    'back slash': 220,
    'right bracket': 221,
    'single quote': 222
  };

  ref = Object.keys(Keys);
  for (i = 0, len = ref.length; i < len; i++) {
    key = ref[i];
    Keys[Keys[key]] = key;
  }

  zeroPadder = function(number, zeros) {
    var output;
    output = '';
    while (output.length < zeros) {
      output = '0' + output;
    }
    return output;
  };

  convertCharacterListToWordList = function(doc) {
    var docIndex, wordCursorIsIn;
    words = [[]];
    docIndex = 0;
    while (docIndex < doc.length) {
      switch (doc[docIndex]) {
        case 52:
          words[words.length - 1].push(doc[docIndex]);
          words.push([]);
          break;
        case 53:
          words.push([53]);
          words.push([]);
          break;
        default:
          words[words.length - 1].push(doc[docIndex]);
      }
      if (docIndex === (currentCursorSpot - 1)) {
        wordCursorIsIn = words.length - 1;
        characterInWord = words[words.length - 1].length - 1;
      }
      if (currentCursorSpot === 0) {
        cursorInLine = 0;
      }
      docIndex++;
    }
    return words;
  };

  convertWordListToLineList = function(words) {
    var lines, wordIndex;
    lines = [[]];
    lineLength = 0;
    wordIndex = 0;
    while (wordIndex < words.length) {
      if (words[wordIndex].length) {
        if (words[wordIndex][0] === 53) {
          lines.push([]);
          lineLength = 0;
        } else {
          if ((lineLength + words[wordIndex].length) < lineLength) {
            lines[lines.length - 1].push(words[wordIndex]);
            lineLength += words[wordIndex].length;
          } else {
            lines.push([]);
            lines[lines.length - 1].push(words[wordIndex]);
            lineLength = words[wordIndex].length;
          }
        }
      }
      if (wordCursorIsIn === wordIndex) {
        cursorsLine = lines.length - 1;
        cursorInLine = lineLength - (words[wordIndex] - characterInWord - 1);
      }
      wordIndex++;
    }
    return lines;
  };

  convertLinesToCharacterLists = function(lines) {
    var character, j, k, len1, len2, lineIndex, ref1, thisLine, word;
    lineIndex = 0;
    while (lineIndex < lines.length) {
      thisLine = [];
      ref1 = lines[lineIndex];
      for (j = 0, len1 = ref1.length; j < len1; j++) {
        word = ref1[j];
        for (k = 0, len2 = word.length; k < len2; k++) {
          character = word[k];
          thisLine.push(character);
        }
      }
      lines[lineIndex] = thisLine;
    }
    return lines;
  };

  organizeWords = function(doc) {
    var lines;
    words = convertCharacterListToWordList(doc);
    lines = convertWordListToLineList(words);
    lines = convertLinesToCharacterLists(lines);
    return lines;
  };

  draw = function() {
    var canvas, charIndex, ctx, lineIndex, thisImage, xCor, yCor;
    if (currentCursorSpot < 0) {
      currentCursorSpot = 0;
    }
    canvas = document.getElementById('docCanvas');
    ctx = canvas.getContext('2d');
    ctx.cavnas.width = window.innerWidth;
    if (windoer.innerHeight < lines.length * (characterHeight + lineSpace) + 64) {
      ctx.canvas.height = lines.length * (characterHeight + lineSpace) + 64;
    } else {
      ctx.canvas.height = window.innerHeight;
    }
    if (lines.length * (characterHeight + lineSpace) + 64 - (window.pageYOffset + yMargin + cursorsLine * (characterHeight + lineSpace)) < 124) {
      if (currentlyPressedKeys.length) {
        window.scrollBy(0, characterHeight + lineSpace);
      }
    }
    organizeWords();
    ctx.fillStyle = '#000000';
    if (window.innerHeight > lines.length * (characterHeight + lineSpace) + 64) {
      ctx.fillRect(0, 0, window.innerWidth, window.innerHeight);
    } else {
      ctx.fillRect(0, 0, window.innerWidth, lines.length * (characterHeight + lineSpace) + 64);
    }
    lineIndex = 0;
    while (lineIndex < lines.length) {
      charIndex = 0;
      while (charIndex < lines[lineIndex].length) {
        thisImage = characters[lines[lineIndex][charIndex]].bigImage;
        xCor = (charIndex * characterWidth) + xMargin;
        yCor = ((lineSpace + characterHeight) * lineIndex) + yMargin;
        ctx.drawImage(thisImage, xCor, yCor);
        charIndex++;
      }
      lineIndex++;
    }
    xCor = cursorInLine * characterWidth + xMargin;
    yCor = cursorsLine * (characterHeight + lineSpace) + yMargin;
    ctx.drawImage(cursorImage, xCor, yCor);
    return writeData();
  };

  documentUpdate = function(doc) {
    var charIndex, commandIndex, keepGoing, necCondIndex, passedANecessaryCondition, passedNecessaryConditions, passedPrecludingConditions, preClCondIndex, results, thisChar, thisCommand, thisCondition, triggerIndex;
    keepGoing = true;
    charIndex = 0;
    while ((charIndex < characters.length) && keepGoing) {
      triggerIndex = 0;
      thisChar = characters[charIndex];
      while (triggerIndex < characters[charIndex].triggers.length) {
        passedNecessaryConditions = true;
        necCondIndex = 0;
        while (necCondIndex < thisChar.necessaryConditions.length) {
          thisCondition = thisChar.necessaryConditions[necCondIndex];
          if (!(indexOf.call(thisCondition, currentlyPressedKeys) >= 0)) {
            passedNecessaryConditions = false;
          }
          necCondIndex++;
        }
        passedPrecludingConditions = true;
        preClCondIndex = 0;
        while (preClCondIndex < thisChar.precludingConditions.length) {
          thisCondition = thisChar.precludingConditions[preClCondIndex];
          if (indexOf.call(thisCondition, currentlyPressedKeys) >= 0) {
            passedPrecludingConditions = false;
          }
          preClCondIndex++;
        }
        if (passedPrecludingConditions && passedNecessaryConditions) {
          keepGoing = false;
          doc.splice(currentCursorSpot, 0, charIndex);
          currentCursorSpot++;
        }
        triggerIndex++;
      }
      charIndex++;
    }
    keepGoing = true;
    commandIndex = 0;
    results = [];
    while ((commandIndex < commands.length) && keepGoing) {
      triggerIndex = 0;
      thisCommand = commands[commandIndex];
      while (triggerIndex < commands[commandIndex].triggers.length) {
        if (thisCommand.triggers[triggerIndex] === justPressedKey) {
          passedANecessaryCondition = !thisCommand.necessaryConditions.length;
          if (!passedANecessaryCondition) {
            necCondIndex = 0;
            while (necCondIndex < thisCommand.necessaryConditions.length) {
              thisCondition = thisCommand.necessaryConditions[necCondIndex];
              if (indexOf.call(thisCondition, currentlyPressedKeys) >= 0) {
                passedANecessaryCondition = true;
              }
              necCondIndex++;
            }
          }
          passedPrecludingConditions = true;
          preClCondIndex = 0;
          while (preClCondIndex < thisCommand.precludingConditions.length) {
            thisCondition = thisCommand.precludingConditions[preClCondIndex];
            if (indexOf.call(thisCondition, currentlyPressedKeys) >= 0) {
              passedPrecludingConditions = false;
            }
            preClCondIndex++;
          }
          if (passedANecessaryCondition && passedPrecludingConditions) {
            commands[commandIndex].execution();
            keepGoing = false;
          }
        }
        triggerIndex++;
      }
      results.push(commandIndex++);
    }
    return results;
  };

  writeData = function(doc) {
    var canvas, canvasPixel, color, ctx, datumIndex, docAsData, docIndex, firstByte, pixel, pixelIndex, pixels, results, secondByte, xCor, yCor;
    canvas = document.getElementById('docCanvas');
    ctx = canvas.getContext('2d');
    docAsData = [];
    docIndex = 0;
    while (docIndex < doc.length) {
      firstByte = Math.floor(doc[docIndex] / 256);
      secondByte = doc[docIndex] % 256;
      docAsData.push(firstByte);
      docAsData.push(secondByte);
      docIndex++;
    }
    pixels = [];
    pixel = [];
    pixels.push([2, 1, 3, 255]);
    datumIndex = 0;
    while (datumIndex < docAsData.length) {
      pixel.push(docAsData[datumIndex]);
      if (pixel.length === 3) {
        pixels.push(pixel);
      }
      datumIndex++;
    }
    if ((pixel.length > 0) && (3 > pixel.length)) {
      while (3 > pixel.length) {
        pixel.push(83);
      }
    } else {
      pixel = [83, 83, 83];
    }
    pixels.push(pixel);
    pixelIndex = 0;
    results = [];
    while (pixelIndex < pixels.length) {
      canvasPixel = ctx.createImageData(1, 1);
      color = canvasPixel.data;
      color[0] = pixels[pixelIndex][0];
      color[1] = pixels[pixelIndex][1];
      color[2] = pixels[pixelIndex][2];
      color[3] = 255;
      xCor = pixelIndex;
      xCor = Math.floor(xCor / (lines.length * (characterHeight + lineSpace) + 64));
      yCor = pixelIndex;
      yCor = yCor % (lines.length * (characterHeight + lineSpace) + 64);
      ctx.putImageData(canvasPixel, xCor, yCor);
      results.push(pixelIndex++);
    }
    return results;
  };

  onMouseDown = function(evnet) {
    var AboveBottomEdge, BelowTopEdge, characterLineClickedOn, leftOfRightEdge, lineHeight, lineIndex, rightOfLeftEdge, whichCharInLine, whichLineInDoc, withHorizontal, withinVertical, xCor, yCor;
    xCor = event.clientX;
    yCor = event.clientY;
    leftOfRightEdge = xCor < (window.innerWidth - xMargin);
    rightOfLeftEdge = xMargin < xCor;
    withHorizontal = leftOfRightEdge && rightOfLeftEdge;
    AboveBottomEdge = yCor < (window.innerHeight - yMargin);
    BelowTopEdge = yMargin < yCor;
    withinVertical = AboveBottomEdge && BelowTopEdge;
    if (withHorizontal && withinVertical) {
      lineHeight = characterHeight + lineSpace;
      whichLineInDoc = ySpot + window.pageYOffset;
      whichLineInDoc = Math.floor(whichLineInDoc / lineHeight);
      whichCharInLine = Math.floor((xCor - xMargin) / characterWidth);
      characterLineClickedOn = 0;
      if ((whichLineInDoc - 1) < lines.length) {
        lineIndex = 0;
        while (lineIndex < (whichLineInDoc - 1)) {
          if (lines[lineIndex].length < lineLength) {
            characterLineClickedOn += lines[lineIndex].length + 1;
          } else {
            characterLineClickedOn += lines[lineIndex].length;
          }
          lineIndex++;
        }
        if (whichCharInLine < lines[whichLineInDoc - 1].length) {
          currentCursorSpot = characterLineClickedOn + whichCharInLine;
        } else {
          currentCursorSpot = characterLineClickedOn + lines[whichLineInDoc - 1].length;
        }
        return draw();
      }
    }
  };

  keyEventDown = function(event) {
    console.log('DOPE!');
    console.log(event);
    justPressedKey = event.keyCode;
    if (!(indexOf.call(currentlyPressedKeys, justPressedKey) >= 0)) {
      currentlyPressedKeys.push(event.keyCode);
    }
    documentUpdate();
    return event.preventDefault();
  };

  keyEventUp = function(event) {
    var indexToRemove;
    indexToRemove = currentlyPressedKeys.indexOf(event.keyCode);
    return currentlyPressedKeys.splice(indexToRemove, 1);
  };

  onDragOver = function(event) {
    event.preventDefault();
    return false;
  };

  fileLoad = function(event) {
    var canvas, ctx, fileName, fileType, imageReader, loadEnd;
    canvas = document.getElementById('docCanvas');
    ctx = canvas.getContext('2d');
    event.preventDefault();
    fileName = event.dataTransfer.files[0].name;
    fileType = event.dataTransfer.files[0].type.slice(0, 5);
    if (fileType === 'image') {
      imageReader = new FileReader;
      loadEnd = (function(theFile) {
        fileName = theFile.name;
        return function(e) {
          var authenticChadtechDocument, colorIndex, counter, firstByte, imageToPaste, keepGrabbing, openedDoc, pixelData, pixelIndex, secondByte, thisPixel, verified, vertificatinData, xCor, yCor;
          imageToPaste = new image;
          imageToPaste.src(e.target.result);
          ctx.canvas.height = imageToPaste.height;
          ctx.drawImage(imageToPaste, 0, 0);
          authenticChadtechDocument = false;
          vertificatinData = ctx.getImageData(0, 0, 1, 1);
          vertificatinData = vertificatinData.data;
          verified = true;
          if (vertificatinData[0] !== 2) {
            verified = false;
          }
          if (vertificatinData[1] !== 1) {
            verified = false;
          }
          if (vertificatinData[2] !== 3) {
            verified = false;
          }
          if (verified) {
            document.title = fileName;
            pixelData = [];
            openedDoc = [];
            pixelIndex = 1;
            keepGrabbing = true;
            counter = 0;
            while (keepGrabbing && (counter < 4000)) {
              xCor = Math.floor(pixelIndex / imageToPaste.height);
              yCor = pixelIndex % imageToPaste.height;
              thisPixel = ctx.getImageData(xCor, yCor, 1, 1);
              thisPixel = thisPixel.data;
              colorIndex = 0;
              while ((colorIndex < 3) && keepGrabbing) {
                if (thisPixel[pixelIndex] === 83) {
                  keepGrabbing = false;
                } else {
                  pixelData.push(thisPixel[colorIndex]);
                }
                colorIndex++;
              }
              pixelIndex++;
            }
            firstByte = void 0;
            secondByte = void 0;
            pixelIndex = 0;
            while (pixelIndex < pixelData.length) {
              if ((pixelIndex % 2) === 0) {
                firstByte = pixelData[pixelIndex] * 256;
              } else {
                secondByte = pixelData[pixelIndex];
                openedDoc.push(firstByte + secondByte);
              }
              pixelIndex++;
            }
            return doc = openedDoc;
          } else {
            return draw();
          }
        };
      })(event.dataTransfer.files[0]);
      return imageReader.readAsDataURL(event.dataTransfer.files[0]);
    }
  };

  keyDownThenDraw = function(event) {
    keyEventDown(event);
    return draw();
  };

  Body = document.getElementsByTagName('body');

  Body = Body[0];

  console.log(draw);

  Body.addEventListener('onLoad', draw);

  Body.addEventListener('ondragover', onDragOver);

  Body.addEventListener('ondrop', fileLoad);

  Body.addEventListener('onkeydown', keyDownThenDraw(event));

  Body.addEventListener('onmousedown', onMouseDown);

  Body.addEventListener('onresize', draw);

  Body.addEventListener('onkeyup', keyEventUp);

}).call(this);
