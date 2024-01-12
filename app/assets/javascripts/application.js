//= require rails-ujs
//= require activestorage
//= require jquery3
//= require turbolinks
//= require cocoon
//= require_tree ./channels
//= require action_cable
//= require skim
//= require_tree ./templates
//= require_tree .

var App = App || {};
App.cable = ActionCable.createConsumer(); 