# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

angular.module 'commissions', []

# auto focus directive
angular.module('commissions').directive 'atAutofocus', ($timeout) ->
  {
    restrict: 'A'
    link:     ($scope, $element) =>
      $timeout () -> $element[0].focus()
  }

angular.module('commissions').controller 'Commissions', ($scope, $http) ->
  # get agents
  $http.get '/agents.json'
    .success (data, status) ->
      for agent in data
        agent.show_terminals = no
      $scope.agents = data
    .error (data, status) ->
      console.log "Error loading agents: #{ status }"

#   # get terminals
#   $http.get '/agents/7/terminals.json'
#     .success (data, status) ->
#       $scope.terminals = data
#     .error (data, status) ->
#       console.log "Error loading terminals: #{ status }"
  
  $scope.toggle_agent = (id) ->
    for agent in $scope.agents
      if agent.id is id
        agent.show_terminals = not agent.show_terminals
