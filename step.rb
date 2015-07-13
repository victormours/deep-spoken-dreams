require 'wavefile'
require 'spcore'
require 'pry'

# Algorithm variables
# - step_length = sample_size / 100

# Step variables:
# - step_start at random between 0 and sample_size / 100
# - step_frequency_cutoff
# - type: low_pass or high_pass
# - filter_factor: 0.9 or 1.1



Edit = Struct.new(:start, :length, :frequency_cutoff, :type, :filter_factor) do
  def apply(data)
    data_segment = data[start..-1][0..length-1]

    min = data_segment.min
    max = data_segment.max

    edited_data_segment = data_segment.map do |data_point|
      (rand(max-min) + min + 19*data_point)/20
    end

    data[0..start-1] + edited_data_segment + data[start+length..-1]
  end


end

EditCreator = Struct.new(:sample_size, :sample_frequency) do

  def self.create(sample_size, sample_frequency)
    new(sample_size, sample_frequency).create
  end

  def create
    Edit.new(start, length, frequency_cutoff, type, filter_factor)
  end

  private

  def start
    rand(sections_count) * length
  end

  def length
    sample_size / sections_count
  end

  def frequency_cutoff
    rand(length)
  end

  def type
    random ? :low_pass : :high_pass
  end

  def filter_factor
    random ? 3 : 0.3
  end

  def sections_count
    100
  end

  def random
    rand > 0.5
  end

end

info = WaveFile::Reader.info('viola.wav')

reader = WaveFile::Reader.new("viola.wav")

buffers = []
reader.each_buffer(info.sample_frame_count) do |buffer|
  buffers << buffer
end

buffer = buffers.first

data = buffer.samples



edited_data = nil
10.times do
  edit = EditCreator.create(data.count, info.sample_rate)
  edited_data = edit.apply(data)
end

buffer.instance_variable_set(:@samples, edited_data)


WaveFile::Writer.new("result.wav", buffer.instance_variable_get(:@format)) do |writer|
  writer.write(buffer)
end
