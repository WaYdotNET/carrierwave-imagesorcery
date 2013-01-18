require 'image_sorcery'

module CarrierWave
  module ImageSorcery
    extend ActiveSupport::Concern

    module ClassMethods
      def convert(format)
        process :convert => format
      end

      def resize_to_limit(width, height)
        process :resize_to_limit => [width, height]
      end

      def resize_to_fit(width, height)
        process :resize_to_fit => [width, height]
      end

      def resize_to_fill(width, height, gravity='Center')
        process :resize_to_fill => [width, height, gravity]
      end

      def resize_and_pad(width, height, background=:transparent, gravity='Center')
        process :resize_and_pad => [width, height, background, gravity]
      end
    end

     ##
    # Changes the image encoding format to the given format
    #
    # See  http://www.imagemagick.org/script/command-line-options.php#format
    #
    # === Parameters
    #
    # [format (#to_s)] an abreviation of the format
    #
    #
    # === Examples
    #
    #  image.convert(:png)
    #
    def convert(format)
      manipulate! do |img|
        img.manipulate!(:format => format.to_s.downcase)
        img = yield(img) if block_given?
        img
      end
    end

    ##
    # Resize the image to fit within the specified dimensions while retaining
    # the original aspect ratio. Will only resize the image if it is larger than the
    # specified dimensions. The resulting image may be shorter or narrower than specified
    # in the smaller dimension but will not be larger than the specified values.
    #
    # === Parameters
    #
    # [width (Integer)] the width to scale the image to
    # [height (Integer)] the height to scale the image to
    #
    def resize_to_limit(width, height)
      manipulate! do |img|
        img.manipulate!(:resize => "#{width}x#{height}>")
        img = yield(img) if block_given?
        img
      end
    end

    ##
    # Resize the image to fit within the specified dimensions while retaining
    # the original aspect ratio. The image may be shorter or narrower than
    # specified in the smaller dimension but will not be larger than the specified values.
    #
    # === Parameters
    #
    # [width (Integer)] the width to scale the image to
    # [height (Integer)] the height to scale the image to
    #
    def resize_to_fit(width, height)
      manipulate! do |img|
        img.manipulate!(:resize => "#{width}x#{height}")
        img = yield(img) if block_given?
        img
      end
    end

    ##
    # Resize the image to fit within the specified dimensions while retaining
    # the aspect ratio of the original image. If necessary, crop the image in the
    # larger dimension.
    #
    # === Parameters
    #
    # [width (Integer)] the width to scale the image to
    # [height (Integer)] the height to scale the image to
    # [gravity (String)] the current gravity suggestion (default: 'Center'; options: 'NorthWest', 'North', 'NorthEast', 'West', 'Center', 'East', 'SouthWest', 'South', 'SouthEast')
    #
    def resize_to_fill(width, height, gravity = 'Center')
      manipulate! do |img|
        cols, rows = img.dimensions[:x].to_i, img.dimensions[:y].to_i
        opt={}
        if width != cols || height != rows
          scale = [width/cols.to_f, height/rows.to_f].max
          cols = (scale * (cols + 0.5)).round
          rows = (scale * (rows + 0.5)).round
          opt[:resize] = "#{cols}x#{rows}"
        end
        opt[:gravity] = gravity
        opt[:background] = "rgba(255,255,255,0.0)"
        opt[:extent] = "#{width}x#{height}" if cols != width || rows != height
        img.manipulate!(opt)
        img = yield(img) if block_given?
        img
      end
    end

    ##
    # Resize the image to fit within the specified dimensions while retaining
    # the original aspect ratio. If necessary, will pad the remaining area
    # with the given color, which defaults to transparent (for gif and png,
    # white for jpeg).
    #
    # See http://www.imagemagick.org/script/command-line-options.php#gravity
    # for gravity options.
    #
    # === Parameters
    #
    # [width (Integer)] the width to scale the image to
    # [height (Integer)] the height to scale the image to
    # [background (String, :transparent)] the color of the background as a hexcode, like "#ff45de"
    # [gravity (String)] how to position the image
    #
    #
    def resize_and_pad(width, height, background=:transparent, gravity='Center')
      manipulate! do |img|
        opt={}
        opt[:thumbnail] = "#{width}x#{height}>"
        background == :transparent ? opt[:background] = "rgba(255, 255, 255, 0.0)" : opt[:background] = background
        opt[:gravity] = gravity
        opt[:extent] = "#{width}x#{height}"
        img.manipulate!(opt)
        img = yield(img) if block_given?
        img
      end
    end

    def dimensions
       manipulate! do |img|
        img.dimensions
      end
    end

    def manipulate!
      cache_stored_file! if !cached?
      image = ::ImageSorcery.new current_path
      image = yield(image)

      replace_file(image.file) if !image.is_a?(Hash) && image.filename_changed?

      image
    rescue RuntimeError, StandardError => e
      raise CarrierWave::ProcessingError , I18n.translate(:"errors.messages.imagesorcery_processing_error", :e => e)
    end

    private

    def replace_file(file)
      FileUtils.move Dir.glob(file).first, current_path
    end
  end
end
