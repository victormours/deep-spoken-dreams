require 'pocketsphinx-ruby'

decoder = Pocketsphinx::Decoder.new(Pocketsphinx::Configuration.default)

puts "Decoding"
decoder.decode 'violin2.wav'

puts "Finding hypothesis"
decoder.hypothesis

