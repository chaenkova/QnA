// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "jquery"
import Rails from '@rails/ujs';
import "./answers"

Rails.start();
$(document).on('turbo:load', function() {
    console.log('turbo loaded!');
});