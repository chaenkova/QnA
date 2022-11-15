// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "./answers"
$(document).on('turbo:load', function() {
    console.log('turbo loaded!');
});
