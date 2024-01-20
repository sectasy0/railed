// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'alpine-turbo-drive-adapter'
import Alpine from 'alpinejs'
import 'controllers'
import 'flowbite'


import Tooltip from "@ryangjchandler/alpine-tooltip";
Alpine.plugin(Tooltip)
window.Alpine = Alpine
Alpine.start()

document.addEventListener('turbo:render', () => {
	initCollapses();
})
