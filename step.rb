require 'wavefile'
require 'pry'

info = WaveFile::Reader.info('viola.wav')

reader = WaveFile::Reader.new("viola.wav")

buffers = []
reader.each_buffer(info.sample_frame_count) do |buffer|
  buffers << buffer
end

data = buffers.first

