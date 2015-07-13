require 'pocketsphinx-ruby'

decoder = Pocketsphinx::Decoder.new(Pocketsphinx::Configuration.default)
decoder.decode 'violin2.wav'
decoder.hypothesis

