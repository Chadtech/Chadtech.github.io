var gulp = require('gulp');
var browserSync = require('browser-sync').create();
var sass = require('gulp-sass');
var less = require('gulp-less-sourcemap');
var cp = require('child_process');

// Static Server
gulp.task('serve', function() {
    browserSync.init({
        server: ".",
        images: "./assets/images/*.png"
    });
});

// Compile Elm
gulp.task('elm', function() {

  var cmd = "elm-make ./assets/elm/Main.elm";
  cmd += " --output ./assets/js/elm.js";

  cp.exec(cmd, function(error, stdout){
    console.log("Elm Says .. ")
    if (error) {
      console.log(error);
    } else {
      console.log(stdout.slice(0, stdout.length - 1));
    }
  })

});
 




// Watching scss/less/html files
gulp.task('watch', ['serve', 'sass', 'less'], function() {
    gulp.watch("assets/scss/*.scss", ['sass']);
    gulp.watch("assets/elm/**/*.elm", ["elm"])
    gulp.watch("*.html").on('change', browserSync.reload);
});

// Compile SASS into CSS & auto-inject into browsers
gulp.task('sass', function() {
  return gulp.src("assets/scss/*.scss")
    .pipe(sass({
      sourceComments: 'map',
      sourceMap: 'scss'
    }))
    .pipe(gulp.dest("assets/css"))
    .pipe(browserSync.stream());
});

// Compile LESS into CSS & auto-inject into browsers
gulp.task('less', function() {
  return gulp.src("assets/less/*.less")
    .pipe(less({
      sourceMap: {
        sourceMapRootpath: './assets/less' // Optional absolute or relative path to your LESS files
      }
    }))
    .pipe(gulp.dest("assets/css"))
    .pipe(browserSync.stream());
});


gulp.task('default', ['serve', 'watch']);
gulp.task('server', ['serve']);
gulp.task('dev', ['watch']);



