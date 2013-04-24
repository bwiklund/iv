module.exports = (grunt) ->

  grunt.initConfig

    clean: ['dist/*']

    coffee:
      compile:
        files:
          'dist/iv.js': 'iv.coffee'


    uglify:
      options: {}
      my_target:
        files:
          'dist/iv.min.js': ['dist/iv.js']


  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.registerTask 'default', ['clean','coffee','uglify']