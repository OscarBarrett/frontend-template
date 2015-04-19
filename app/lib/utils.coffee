angular.module 'lib.utils', []
  .factory 'Utils', ($injector) ->
    class Utils
      # Generates a slug from a string
      @slug_for: (str) ->
        str = str.replace(/[^a-zA-Z0-9 _-]+/g, '').replace(/[_-\s]+/g, '-').toLowerCase()


      # Converts a state name to suitable classes
      @classes_for_state: (state) ->
        classes = ''

        if state?
          parent_class  = "#{state.replace(/\..*/, '')}-state"
          full_class    = "#{state.replace(/\./g, '-')}-state"

          if parent_class == full_class
            classes = parent_class
          else
            classes = "#{parent_class} #{full_class}"

        return classes


    $injector.get('$rootScope').Utils = Utils
