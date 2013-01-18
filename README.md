# CarrierWave::ImageSorcery

Additional processing to use [ImageSorcery](https://github.com/EricR/image_sorcery) into [CarrierWave](https://github.com/jnicklas/carrierwave).

[![Gem Version](https://badge.fury.io/rb/carrierwave-imagesorcery.png)](http://badge.fury.io/rb/image_sorcery)
[![Build Status](https://travis-ci.org/WaYdotNET/carrierwave-imagesorcery.png)](https://travis-ci.org/WaYdotNET/carrierwave-imagesorcery)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/WaYdotNET/carrierwave-imagesorcery)

## Installation

Add this line to your application's Gemfile:

    gem 'carrierwave-imagesorcery'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install carrierwave-imagesorcery

## Usage

To use those, you should include specified module (ImageSorcery) into your uploader and use processors:

    class AvatarUploader < CarrierWave::Uploader::Base
      include CarrierWave::ImageSorcery
      .....

    end

## Method implemented

    convert
    dimensions
    resize_to_limit
    resize_to_fit
    resize_to_fill
    resize_and_pad

## Example

    class Uploader < CarrierWave::Uploader::Base
    ##
    # Image manipulator library:
    include CarrierWave::ImageSorcery

    process :resize_and_pad => [900,300,"#ffeecc", 'South']
    process :resize_to_fit => [1024, 768]

    end

## Example custom method

An example to implement custom method


    class Uploader < CarrierWave::Uploader::Base
    include CarrierWave::ImageSorcery
    process :watermark_text

    def watermark_text(text = "© #{Time.now.year} - Carlo Bertini [WaYdotNET]")
      manipulate! do |img|
        args  = {
          font: 'Helvetica', fill: 'white', stroke: '#00770080',
          gravity: 'South', pointsize: 20, draw: " text 0,0 \"#{text}\" "
        }
        img.manipulate! args
        img
      end
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Author

[![endorse](http://api.coderwall.com/waydotnet/endorsecount.png)](http://coderwall.com/waydotnet)

WaYdotNET, you can follow me on twitter [@WaYdotNET](http://twitter.com/WaYdotNET) or take a look at my site [waydotnet.com](http://www.waydotnet.com)

## Copyright

Copyright (C) 2012 Carlo Bertini - [@WaYdotNET](http://twitter.com/WaYdotNET)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the “Software”), to deal in the Software without restriction, including without
limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
