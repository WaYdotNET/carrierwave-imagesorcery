# # require_relative '../../spec_helper'
# # For Ruby < 1.9.3, use this instead of require_relative
require (File.expand_path('./../../../spec_helper', __FILE__))

class Uploader  < CarrierWave::Uploader::Base
  include CarrierWave::ImageSorcery
end

describe CarrierWave::ImageSorcery do

  before do
    @klass = Class.new do
      include CarrierWave::ImageSorcery
    end
    @instance = Uploader.new
    FileUtils.cp(file_path('landscape.jpg'), file_path('landscape_copy.jpg'))
    @instance.stub(:current_path).and_return(file_path('landscape_copy.jpg'))
    @instance.stub(:cached?).and_return true
  end

  after do
    FileUtils.rm([file_path('landscape_copy.jpg'), file_path('landscape_copy.png')], :force => true)
  end

  describe "#convert" do
    it "should convert from one format to another" do
      @instance.convert('png')
      img = ImageSorcery.new @instance.current_path
      img.identify.should =~ /PNG/
    end
  end

  describe '#resize_to_fill' do
    it "should resize the image to exactly the given dimensions" do
      @instance.resize_to_fill(200, 200)
      @instance.dimensions.should == check_dimension(200, 200)
    end

    it "should scale up the image if it smaller than the given dimensions" do
      @instance.resize_to_fill(1000, 1000)
      @instance.dimensions.should == check_dimension(1000, 1000)
    end
  end

  describe '#resize_and_pad' do
    it "should resize the image to exactly the given dimensions" do
      @instance.resize_and_pad(200, 200)
      @instance.dimensions.should == check_dimension(200, 200)
    end

    it "should scale up the image if it smaller than the given dimensions" do
      @instance.resize_and_pad(1000, 1000)
      @instance.dimensions.should == check_dimension(1000, 1000)
    end

  end

  describe '#resize_to_fit' do
    it "should resize the image to fit within the given dimensions" do
      @instance.resize_to_fit(200, 200)
      @instance.dimensions.should == check_dimension(200, 150)
    end

    it "should scale up the image if it smaller than the given dimensions" do
      @instance.resize_to_fit(1000, 1000)
      @instance.dimensions.should == check_dimension(1000, 750)
    end
  end

  describe '#resize_to_limit' do
    it "should resize the image to fit within the given dimensions" do
      @instance.resize_to_limit(200, 200)
      @instance.dimensions.should == check_dimension(200, 150)
    end

    it "should not scale up the image if it smaller than the given dimensions" do
      @instance.resize_to_limit(1000, 1000)
      @instance.dimensions.should == check_dimension(640, 480)
    end
  end
end
