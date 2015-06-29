gulp = require('gulp')
coffee = require('gulp-coffee')
uglify = require('gulp-uglify')
rename = require('gulp-rename')
plumber = require('gulp-plumber')


gulp.task 'scripts', ->

    gulp.src([
        'src/*.coffee'
    ])
    .pipe(plumber())
    .pipe(coffee({bare:true}))
    .pipe(gulp.dest('./dist/'))
    .pipe(uglify())
    .pipe(rename({suffix:'.min'}))
    .pipe(gulp.dest('./dist/'))

gulp.task('watcher', ()->
    gulp.watch([
        'src/*.coffee'
    ], ['scripts'])
)

gulp.task('default', ['scripts'])

gulp.task('watch', ['default', 'watcher'])