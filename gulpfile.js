'use strict';

var gulp = require('gulp'),

    livereload = require('gulp-livereload'),
    csso = require('gulp-csso'),
    plumber = require('gulp-plumber'),
    sass = require('gulp-ruby-sass'),
    cleanhtml = require("gulp-cleanhtml");

gulp.task('default', function () {
    gulp.start('build');
});

gulp.task('test', function () {

});

gulp.task('sass', function () {
    return sass('homepage/app/css/style.scss')
        .pipe(plumber())
        .on('error', function (err) {
            console.error('Error!', err.message);
        })
        .pipe(gulp.dest('homepage/app/css'));
});

gulp.task('styles', function () {

    gulp.src('homepage/app/css/**/*.scss')
        .pipe(gulp.dest('homepage/app/css'))
        .pipe(csso())
        .pipe(gulp.dest('homepage/app/css/min'));
});

gulp.task('pages', function () {
    return gulp.src('homepage/app/*.html')
        .pipe(cleanhtml())
        .pipe(gulp.dest('dist'));
});

gulp.task('build', [, , 'pages']);

gulp.task('server', function () {
    var connect = require('connect'),
        server = connect();
    server.use(connect.static('homepage/app')).listen(process.env.PORT || 9003);
    require('opn')('http://localhost:' + (process.env.PORT || 9003));
});

gulp.task('watch', ['server'], function () {
    gulp.start('build');



    gulp.watch('homepage/app/*.html', ['pages']);
    gulp.watch('homepage/app/**/*.scss', ['sass']);

    var server = livereload();
    gulp.watch('homepage/dist/**').on('change', function (file) {
        server.changed(file.path);
    });
});
