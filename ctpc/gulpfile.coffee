gulp = require('gulp')
jade = require('gulp-jade')
stylus = require('gulp-stylus')
coffee = require('gulp-coffee')

gulp.task 'stylus', () ->
  gulp.src './src/css/business.styl'
    .pipe stylus({errors: true})
    .pipe gulp.dest './public/css'

gulp.task 'jade', () ->
  gulp.src './src/html/philosophicalComment.jade'
    .pipe jade()
    .pipe gulp.dest('./')

gulp.task 'coffee', () ->
  gulp.src './src/js/main.coffee'
    .pipe coffee()
    .pipe gulp.dest './public/js'

gulp.task 'default', ['stylus', 'jade', 'coffee']