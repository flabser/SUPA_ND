var gulp = require('gulp');
var jshint = require('gulp-jshint');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var uglify = require('gulp-uglify');
var csso = require('gulp-csso');

var js_files = ['js/src/nb.js', 'js/src/*.js'];
var css_files = ['./css/**/*.css'];

gulp.task('lint', function() {
    gulp.src(js_files)
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
});

gulp.task('minify_js', function() {
    gulp.src(js_files)
        .pipe(concat('nb.build.js'))
        .pipe(gulp.dest('./js'));
});

gulp.task('minify_css', function() {
    gulp.src(css_files)
        .pipe(concat('nb.min.css'))
        .pipe(csso())
        .pipe(gulp.dest('./css'));
});

gulp.task('default', function() {
    gulp.run('minify_css', 'lint', 'minify_js');

    gulp.watch(js_files, function(event) {
        gulp.run('minify_js');
    });

    gulp.watch(css_files, function(event) {
        gulp.run('minify_css');
    });
});
