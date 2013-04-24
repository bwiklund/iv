module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      compile:
        files:
          'dist/iv.js': 'iv.coffee'

    uglify:
      options: {}
      my_target:
        files:
          'dist/iv.min.js': ['dist/iv.js']


  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-uglify')

  grunt.registerTask 'default', ['coffee','uglify']