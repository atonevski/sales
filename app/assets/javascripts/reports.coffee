# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

angular.module 'reports', []

angular.module('reports').controller 'AnnuallyPerMonthPerGame', ($scope, $http) ->
  $scope.year = 2010
  $scope.years = [2010]
  $scope.months = ['january', 'february', 'march', 'april', 'may', 'june', 'july',
                   'august', 'september', 'october', 'november', 'december']

  $scope.setYear = (y)->
    $scope.year = y
    $http.get("/annually-per-month-per-game/#{ y }.json")
        .then (res) ->
            $scope.year       = res.data.year
            $scope.years      = [res.data.first_year .. res.data.last_year]
            $scope.sales      = res.data.sales
            $scope.terminals  = res.data.terminals
            console.log "Loading annual sales for #{ $scope.year }"

  $http.get('/annually-per-month-per-game/2016.json')
       .then (res) ->
          $scope.year       = res.data.year
          $scope.years      = [res.data.first_year .. res.data.last_year]
          $scope.sales      = res.data.sales
          $scope.terminals  = res.data.terminals
          console.log 'Initial load'

  # second argument === 'mk' will return mk thousand separated format
  $scope.thou_sep = (n) ->
    return n unless n?
    
    n = n.toString()
    n = n.replace /(\d+?)(?=(\d{3})+(\D|$))/g, '$1,'
    return n unless arguments.length > 1
    if arguments[1] is 'mk'
      n = n.replace /\./g, ';'
      n = n.replace /,/g, '.'
      n = n.replace /;/g, ','
    n # return this value

  $scope.sales_total_for = (month) ->
    tot = null
    return null unless $scope.sales?
    for gs in $scope.sales
      if gs? and gs[month]?
        tot ||= 0
        tot += gs[month]
    tot

angular.module('reports').controller 'InstantsAnnuallyPerMonthPerGame', ($scope, $http) ->
  $scope.year = 2010
  $scope.years = [2010]
  $scope.months = ['january', 'february', 'march', 'april', 'may', 'june', 'july',
                   'august', 'september', 'october', 'november', 'december']

  $scope.setYear = (y)->
    $scope.year = y
    $http.get("/instants-annually-per-month-per-game/#{ y }.json")
        .then (res) ->
            $scope.year       = res.data.year
            $scope.years      = [res.data.first_year .. res.data.last_year]
            $scope.sales      = res.data.sales
            $scope.tickets    = res.data.tickets
            $scope.terminals  = res.data.terminals
            console.log "Loading annual sales for #{ $scope.year }"

  $http.get('/instants-annually-per-month-per-game/2016.json')
       .then (res) ->
          $scope.year       = res.data.year
          $scope.years      = [res.data.first_year .. res.data.last_year]
          $scope.sales      = res.data.sales
          $scope.tickets    = res.data.tickets
          $scope.terminals  = res.data.terminals
          console.log 'Initial load'

  # second argument === 'mk' will return mk thousand separated format
  $scope.thou_sep = (n) ->
    return n unless n?
    
    n = n.toString()
    n = n.replace /(\d+?)(?=(\d{3})+(\D|$))/g, '$1,'
    return n unless arguments.length > 1
    if arguments[1] is 'mk'
      n = n.replace /\./g, ';'
      n = n.replace /,/g, '.'
      n = n.replace /;/g, ','
    n # return this value

  $scope.sales_total_for = (month) ->
    tot = null
    return null unless $scope.sales?
    for gs in $scope.sales
      if gs? and gs[month]?
        tot ||= 0
        tot += gs[month]
    tot

  $scope.tickets_total_for = (month) ->
    tot = null
    return null unless $scope.tickets?
    for gt in $scope.tickets
      if gt? and gt[month]?
        tot ||= 0
        tot += gt[month]
    tot
