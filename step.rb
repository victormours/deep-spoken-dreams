require 'wavefile'
require 'spcore'
require 'pry'

# Algorithm variables
# - step_length
# - step_frequency_length

# Step variables:
# - step_start at random between
# - step_frequency_start
# - step_factor


info = WaveFile::Reader.info('viola.wav')

reader = WaveFile::Reader.new("viola.wav")

buffers = []
reader.each_buffer(info.sample_frame_count) do |buffer|
  buffers << buffer
end

data = buffers.first.samples


frequencies = SPCore::FFT.forward(data)
require 'pry'; binding.pry;

frequencies = SPCore::FFT.inverse(frequencies)


