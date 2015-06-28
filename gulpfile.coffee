gulp = require('gulp')
sass = require('gulp-sass')
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


# elixir = require 'laravel-elixir'
# require 'laravel-elixir-clean'

# # gulp tool
# gulp = require 'gulp'
# util = require 'gulp-util'
# addsrc = require 'gulp-add-src'
# uglify = require 'gulp-uglify'
# concat = require 'gulp-concat'
# livereload = require 'gulp-livereload'
# autoprefixer = require 'gulp-autoprefixer'
# rename = require 'gulp-rename'
# fs = require 'fs'
# minifyCss = require 'gulp-minify-css'


# # compiler
# browserify = require 'gulp-browserify'
# sass = require 'gulp-sass'


# # browserify transform lib
# coffee_reactify = require 'coffee-reactify'



# # transform require 'react' to windwo.React
# literalify = require 'literalify'





# # /*
# #  |--------------------------------------------------------------------------
# #  | Elixir Asset Management
# #  |--------------------------------------------------------------------------
# #  |
# #  | Elixir provides a clean, fluent API for defining some basic Gulp tasks
# #  | for your Laravel application. By default, we are compiling the Less
# #  | file for our application, as well as publishing vendor resources.
# #  |
# #  */


# # is in production
# inProduction = util.env.production 

# process.env.NODE_ENV = if inProduction then 'production' else 'development'

# # is running watch task
# inWatch = 'watch' in util.env._





# # scripts
# elixir.extend 'myScripts', ->

#     gulp.task 'myScripts', ->

#         gulp.src([
#             'resources/assets/desktop/cjsx/pages/*.cjsx'
#         ], {read:false})
#         .pipe(browserify({
#             transform: [
#                 coffee_reactify, 
#                 literalify.configure({
#                     'jquery': 'window.$'
#                     'react': 'window.React'
#                     'react/addons': 'window.React'
#                     'react-router': 'window.ReactRouter'
#                     'fluxxor': 'window.Fluxxor'
#                     'underscore': 'window._'
#                     'classnames': 'window.classNames'
#                     'screenfull': 'window.screenfull'
#                 })
#             ]
#         }))
#         .on('error', util.log)
#         .pipe(
#             if inProduction then uglify() else util.noop()
#         )
#         .pipe(rename({extname:'.js'}))
#         .pipe(gulp.dest('./public/desktop/js/pages'))
        



#     # when changed, trigger this task
#     @registerWatcher 'myScripts', 'resources/assets/desktop/cjsx/**/*.cjsx'

#     @queueTask 'myScripts'




# vendor_script_list = [
#         name: 'jquery'
#         dev: './bower_components/jquery/dist/jquery.js'
#         min: './bower_components/jquery/dist/jquery.min.js'
#     ,
#         name: 'jquery-ui-mouse'
#         dev: './bower_components/jquery-ui/jquery-ui.js'
#         min: './bower_components/jquery-ui/jquery-ui.min.js'
#     ,
#         name: 'jQuery-ajaxTransport-XDomainRequest'
#         dev: './bower_components/jQuery-ajaxTransport-XDomainRequest/jQuery.XDomainRequest.js'
#         min: './bower_components/jQuery-ajaxTransport-XDomainRequest/jquery.xdomainrequest.min.js'
#     ,
#         name: 'jquery-ui-slider'
#         dev: './bower_components/jquery-ui/ui/slider.js'
#         min: './bower_components/jquery-ui/ui/minified/slider.min.js'
#     ,
#         name: 'react'
#         dev: './node_modules/react/dist/react-with-addons.js'
#         min: './node_modules/react/dist/react-with-addons.min.js'
#     ,
#         name: 'react-router'
#         dev: './node_modules/react-router/umd/ReactRouter.js'
#         min: './node_modules/react-router/umd/ReactRouter.min.js'
#     ,
#         name: 'fluxxor'
#         dev: './bower_components/fluxxor/build/fluxxor.js'
#         min: './bower_components/fluxxor/build/fluxxor.min.js'
#     ,
#         name: 'modernizr'
#         dev: './bower_components/modernizr/modernizr.js'
#         min: './bower_components/modernizr/modernizr.js'
#     ,
#         name: 'jquery-vide'
#         dev: './bower_components/vide/dist/jquery.vide.js'
#         min: './bower_components/vide/dist/jquery.vide.min.js'
#     ,
#         name: 'ScrollMagic'
#         dev: './bower_components/scrollmagic/scrollmagic/uncompressed/ScrollMagic.js'
#         min: './bower_components/scrollmagic/scrollmagic/minified/ScrollMagic.min.js'
#     ,
#         name: 'gsap-tween'
#         dev: './bower_components/gsap/src/uncompressed/TweenMax.js'
#         min: './bower_components/gsap/src/minified/TweenMax.min.js'
#     ,
#         name: 'gsap-timeline'
#         dev: './bower_components/gsap/src/uncompressed/TimelineMax.js'
#         min: './bower_components/gsap/src/minified/TimelineMax.min.js'
#     ,
#         name: 'slick'
#         dev: './bower_components/slick.js/slick/slick.js'
#         min: './bower_components/slick.js/slick/slick.min.js'
#     ,
#         name: 'jquery-imagefill'
#         dev: './bower_components/imagefill/js/jquery-imagefill.js'
#         min: './bower_components/imagefill/js/jquery-imagefill.js'
#     ,
#         name: 'imagesloaded'
#         dev: './bower_components/imagesloaded/imagesloaded.pkgd.js'
#         min: './bower_components/imagesloaded/imagesloaded.pkgd.min.js'
#     ,
#         name: 'underscore'
#         dev: './bower_components/underscore/underscore.js'
#         min: './bower_components/underscore/underscore-min.js'
#     ,
#         name: 'jquery-rest'
#         dev: './bower_components/jquery.rest/dist/1/jquery.rest.js'
#         min: './bower_components/jquery.rest/dist/1/jquery.rest.min.js'
#     ,
#         name: 'react-classnames'
#         dev: './bower_components/classnames/index.js'
#         min: './bower_components/classnames/index.js'
#     ,
#         name: 'screenfull'
#         dev: './bower_components/screenfull/dist/screenfull.js'
#         min: './bower_components/screenfull/dist/screenfull.js'
#     ,
#         name: 'overthrow'
#         dev: './bower_components/nanoscroller/bin/javascripts/overthrow.min.js'
#         min: './bower_components/nanoscroller/bin/javascripts/overthrow.min.js'
#     ,
#         name: 'nanoscroller'
#         dev: './bower_components/nanoscroller/bin/javascripts/jquery.nanoscroller.js'
#         min: './bower_components/nanoscroller/bin/javascripts/jquery.nanoscroller.min.js'
#     ,
#         name: 'dotdotdot'
#         dev: './bower_components/dotdotdot/src/js/jquery.dotdotdot.js'
#         min: './bower_components/dotdotdot/src/js/jquery.dotdotdot.min.js'
# ]


# _ = require 'underscore'

# # vendor scripts
# elixir.extend 'vendorScripts', ->

#     gulp.task 'vendorScripts', ->

#         pluck_column = if inProduction then 'min' else 'dev'
#         vendor_scripts = _.pluck vendor_script_list, pluck_column
            
            
#         gulp.src(vendor_scripts)
#         .pipe(concat('vendors.js'))
#         .pipe(
#             if inProduction then uglify() else util.noop()
#         ).pipe(gulp.dest('./public/desktop/js'))

#     @registerWatcher 'vendorScripts'
#     @queueTask 'vendorScripts'




# # sass
# elixir.extend 'mySass', ->

#     gulp.task 'mySass', ->


#         gulp.src('resources/assets/desktop/sass/bundle.scss')
#         .pipe(sass({
#             errLogToConsole: true
#         }))
#         .pipe(
#             if inProduction then minifyCss() else util.noop()
#         )
#         .pipe(autoprefixer('last 2 version'))
#         .pipe(concat('all.css'))
#         .pipe(gulp.dest('./public/desktop/css'))
        


#     @registerWatcher 'mySass', 'resources/assets/desktop/sass/**/*.scss'

#     @queueTask 'mySass'





# # livereload
# elixir.extend 'livereload', ->

#     gulp.task 'livereload', ->

#         if fs.existsSync 'public/build/rev-manifest.json'
            
#             livereload.reload('something')
        

#     @registerWatcher 'livereload', [
#         'public/build/rev-manifest.json',
#         'resources/views/**/*.*'
#     ]

#     @queueTask 'livereload'



# elixir.extend 'myCopy', ->

#     gulp.task 'myCopy', ->
        
#         if fs.existsSync 'public/build/rev-manifest.json'
#             gulp.src([
#                 'bower_components/bootstrap-sass/assets/fonts/**/*',
#                 'bower_components/font-awesome/fonts/**/*',
#                 # 'bower_components/slick.js/slick/fonts/**/*',
#             ])
#             .pipe(gulp.dest('public/build/desktop/fonts'))
            
#             gulp.src([
#                 'resources/assets/desktop/icons/**/*',
#             ])
#             .pipe(gulp.dest('public/build/desktop/icons'))
            
#             gulp.src([
#                 'resources/assets/desktop/images/**/*',
#             ])
#             .pipe(gulp.dest('public/build/desktop/images'))
            

#     @registerWatcher 'myCopy', [
#         'public/build/rev-manifest.json'
#     ]

#     this.queueTask('myCopy');


# elixir (mix)->

#     mix.vendorScripts()
#         .myScripts()
#         .mySass()
#         .version(['desktop/js/**/*.js', 'desktop/css/all.css'])
#         .myCopy()


#     # start livereload when running watch task
#     if inWatch
#         mix.livereload()
#         livereload.listen()
    

