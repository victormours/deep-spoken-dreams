require 'pocketsphinx-ruby'

decoder = Pocketsphinx::Decoder.new(Pocketsphinx::Configuration.default)
decoder.decode 'viola.wav'
decoder.hypothesis

