var gulp          = require('gulp');
var $             = require('gulp-load-plugins')();
var autoprefixer  = require('autoprefixer');
const sass = require('gulp-sass')(require('node-sass'));

var sassPaths = [
    'node_modules/foundation-sites/scss',
    'node_modules/motion-ui/src'
];

function sassFunction() {
    return gulp.src('scss/app.scss')
        .pipe(sass({
            includePaths: sassPaths,
            outputStyle: 'compressed'
        })
            .on('error', sass.logError))
        .pipe($.postcss([
            autoprefixer()
        ]))
        .pipe(gulp.dest('../../Public/Styles'));
};

function watchFunction() {
    gulp.watch("scss/*.scss", sassFunction);
}

function moveJsFunction() {
    return gulp.src([
        'js/app.js',
        'node_modules/jquery/dist/jquery.js',
        'node_modules/foundation-sites/dist/js/foundation.js'
    ])
        .pipe(gulp.dest('../../Public/JavaScript/'));
}


gulp.task('build', gulp.series(sassFunction, moveJsFunction));
gulp.task('watch', gulp.series('build', watchFunction));
gulp.task('default', gulp.series('watch'));
