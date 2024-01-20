# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'https://ga.jspm.io/npm:@hotwired/stimulus@3.2.1/dist/stimulus.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin 'stimulus-use', to: 'https://ga.jspm.io/npm:stimulus-use@0.51.3/dist/index.js'
pin 'hotkeys-js', to: 'https://ga.jspm.io/npm:hotkeys-js@3.10.1/dist/hotkeys.esm.js'
pin 'bootstrap', to: 'https://ga.jspm.io/npm:bootstrap@5.2.0/dist/js/bootstrap.esm.js'
pin 'flowbite', to: 'https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.turbo.min.js'
pin 'alpine-turbo-drive-adapter', to: 'https://ga.jspm.io/npm:alpine-turbo-drive-adapter@2.0.0/dist/alpine-turbo-drive-adapter.esm.js'
pin 'alpinejs', to: 'https://ga.jspm.io/npm:alpinejs@3.10.5/dist/module.esm.js'
pin '@ryangjchandler/alpine-tooltip', to: 'https://ga.jspm.io/npm:@ryangjchandler/alpine-tooltip@1.2.0/dist/module.esm.js'
